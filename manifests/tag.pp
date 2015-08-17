#
# add any Dataloop tags defined in Hiera
#
class dataloop::tag()
{

  dataloop_tag{ $dataloop::all_tags:
    ensure => 'present',
    key    => $dataloop::api_key,
  }

}

