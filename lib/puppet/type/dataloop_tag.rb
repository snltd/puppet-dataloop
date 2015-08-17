Puppet::Type.newtype(:dataloop_tag) do
  @doc = 'manage Dataloop tags'
  ensurable

  newparam(:name) do
    desc 'the tag name'

    validate do |value|
      raise ArgumentError, 'tag is not a string' unless value.is_a?(String)
    end

    isnamevar
  end

  newparam(:key) do
    desc 'Dataloop API key'

    validate do |value|

      unless value.is_a?(String) && value.match(/^[0-9a-f\-]+$/)
        raise ArgumentError, 'API key is invalid'
      end

    end
  end

end
