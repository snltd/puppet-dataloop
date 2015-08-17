Puppet::Type.type(:dataloop_tag).provide(:tagger) do
  #
  # Use it like this:
  #
  # dataloop_tag { 'value'
  #   ensure => 'present'
  #   key    => 'abcdef0123456789',
  # }
  #
  desc 'Manage Dataloop tags'
  #
  # The provider is only valid if we have the Dataloop agent.
  #
  commands :agent => '/usr/local/bin/dataloop-lin-agent'

  # Cache the tags we find, because lookups can take a while and we want
  # our puppet runs to be as quick as possible
  #
  $tags = []

  def create
    Puppet.debug "add Dataloop tag #{@resource[:name]}"
    agent('-a', @resource[:key], '--add-tags', @resource[:name])
  end

  def exists?
    Puppet.debug "look up Dataloop tag #{@resource[:name]}"

    if $tags
      Puppet.debug "using tag cache (#{$tags.size} known)"
    else
      #
      # I've decided not to abort the Puppet run if the tag lookup
      # fails. We'll return false, so 'create' requests will still
      # happen, but 'destroy's won't.
      #
      begin
        $tags = agent('-a', @resource[:key], '--list-tags').split
      rescue
        Puppet.warning 'Dataloop tag request timed out'
      end

    end

    $tags.include?(@resource[:name])
  end

  def destroy
    Puppet.debug "remove Dataloop tag #{@resource[:name]}"
    agent('-a', @resource[:key], '--remove-tags', @resource[:name])
  end
end
