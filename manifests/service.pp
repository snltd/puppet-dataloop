#
# Start the agent
#
class dataloop::service ()
{

  service { 'dataloop-agent':
    #
    # Dataloop doesn't play nicely with Upstart, so 'service
    # dataloop-agent status' doesn't always tell the truth. Tell Puppet
    # to use the init script to get status, which does work.
    #
    ensure   => running,
    provider => 'init',
  }

}
