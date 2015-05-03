
class nullmailer::params inherits nullmailer::default {

  $base_name = 'nullmailer'

  #---

  $build_package_names  = module_array('build_package_names')
  $common_package_names = module_array('common_package_names')
  $extra_package_names  = module_array('extra_package_names')
  $package_ensure       = module_param('package_ensure', 'present')

  #---

  $config_owner      = module_param('config_owner', 'mail')
  $config_group      = module_param('config_group', 'root')
  $config_file_mode  = module_param('config_file_mode', '0660')

  $remotes_file       = module_param('remotes_file')
  $remotes_template   = module_param('remotes_template', 'nullmailer/remotes.erb')
  $remotes            = module_array('remotes')

  $default_domain_file     = module_param('default_domain_file')
  $default_domain_template = module_param('default_domain_template', 'nullmailer/defaultdomain.erb')
  $default_domain          = module_param('default_domain')

  #---

  $service_name   = module_param('service_name', 'nullmailer')
  $service_ensure = module_param('service_ensure', 'running')
}
