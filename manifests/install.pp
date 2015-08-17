#
# Install the Dataloop agent and whatever else it needs
#
class dataloop::install()
{

  user { 'dataloop':
    ensure   => present,
    password => '!',
    notify   => Exec['install_agent'],
  }

  exec { 'install_agent':
    command => "curl -s https://download.dataloop.io/setup.sh | \
      bash -s '${dataloop::api_key}' all dataloop",
    unless  => 'test -f /usr/local/bin/dataloop-lin-agent',
  }

}
