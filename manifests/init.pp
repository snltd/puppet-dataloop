# dataloop Module

class dataloop(
  $api_key  = 'undefined',
  $all_tags = hiera_array('dataloop::tags'),
){

  anchor { 'dataloop::begin':
    notify  => Class['dataloop::install'],
  }

  class { 'dataloop::install':
    require => Anchor['dataloop::begin'],
    notify  => Class['dataloop::configure'],
  }

  class { 'dataloop::configure':
    require => Class['dataloop::install'],
    notify  => Class['dataloop::service'],
  }

  class { 'dataloop::service':
    require => Class['dataloop::configure'],
    notify  => Class['dataloop::tag'],
  }

  class { 'dataloop::tag':
    require => Class['dataloop::service'],
    notify  => Anchor['dataloop::end'],
  }

  anchor { 'dataloop::end': }
}
