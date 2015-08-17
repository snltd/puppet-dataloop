#
# Carry out whatever configuration is needed for the agent to run
# properly
#
class dataloop::configure()
{

  file { ['/var/log/dataloop',
          '/opt/dataloop',
          '/opt/dataloop/collectors',
          '/opt/dataloop/plugins',
          '/opt/dataloop/plugins/rpc',
          '/etc/dataloop']:
    ensure => 'directory',
    owner  => 'dataloop',
    mode   => '0755',
  }

}
