
class nullmailer::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $common_package_names = ['nullmailer']
      $service_name         = 'nullmailer'

      $remotes_file = '/etc/nullmailer/remotes'
    }
  }
}
