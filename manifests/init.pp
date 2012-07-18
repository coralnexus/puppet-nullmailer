# Class: nullmailer
#
#   This module manages the NullMailer MTA service.
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <examples/params.json> for Hiera configurations)
#
# Actions:
#
#  Installs, configures, and manages the NullMailer MTA service.
#
# Requires:
#
# Sample Usage:
#
#   $emailserver1 = {
#      host     => 'mail.example.com',
#      port     => 25,
#      protocol => 'smtp',
#      user     => 'me@example.com',
#      password => 'mypassword',
#   }
#
#   class { 'nullmailer':
#     remotes => [ $emailserver1 ],
#   }
#
# [Remember: No empty lines between comments and class definition]
class nullmailer (

  $package          = $nullmailer::params::os_nullmailer_package,
  $package_ensure   = $nullmailer::params::nullmailer_package_ensure,
  $service          = $nullmailer::params::os_nullmailer_service,
  $service_ensure   = $nullmailer::params::nullmailer_service_ensure,
  $remotes_dir      = $nullmailer::params::os_remotes_dir,
  $remotes          = $nullmailer::params::remotes,
  $remotes_template = $nullmailer::params::os_remotes_template,

) inherits nullmailer::params {

  #-----------------------------------------------------------------------------
  # Installation

  if ! $package or ! $package_ensure {
    fail('Nullmailer package and version must be defined')
  }
  package { 'nullmailer':
    name   => $package,
    ensure => $package_ensure,
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $remotes_dir {
    file { 'nullmailer-remotes':
      path     => $remotes_dir,
      owner    => "mail",
      group    => "mail",
      mode     => 600,
      content  => template($remotes_template),
      require  => Package['nullmailer'],
      notify   => Service['nullmailer'],
    }
  }

  #-----------------------------------------------------------------------------
  # Services

  service { 'nullmailer':
    name    => $service,
    ensure  => $service_ensure,
    enable  => true,
    require => Package['nullmailer'],
  }
}
