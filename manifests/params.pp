
class nullmailer::params inherits nullmailer::default {

  $base_name = 'locales'

  #---

  $build_package_names  = module_array('build_package_names')
  $common_package_names = module_array('common_package_names')
  $extra_package_names  = module_array('extra_package_names')
  $package_ensure       = module_param('package_ensure', 'present')

  #---

  $remotes_file       = module_param('remotes_file')
  $remotes_owner      = module_param('remotes_owner', 'mail')
  $remotes_group      = module_param('remotes_group', 'root')
  $remotes_file_mode  = module_param('remotes_file_mode', '0660')

  $remotes_template   = module_param('remotes_template', 'nullmailer/remotes.erb')
  $remotes            = module_array('remotes')

  #---

  $service_name   = module_param('service_name', 'nullmailer')
  $service_ensure = module_param('service_ensure', 'running')
}
