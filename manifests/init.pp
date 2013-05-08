# Class: nullmailer
#
#   This module manages Nullmailer.
#
#   Adrian Webb <adrian.webb@coralnexus.com>
#   2013-05-08
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <example/params.json> for Hiera configurations)
#
# Actions:
#
#  Installs, configures, and manages Nullmailer.
#
# Requires:
#
# Sample Usage:
#
#   include nullmailer
#
class nullmailer inherits nullmailer::params {

  $base_name = $nullmailer::params::base_name

  #-----------------------------------------------------------------------------
  # Installation

  coral::package { $base_name:
    resources => {
      build_packages  => {
        name => $nullmailer::params::build_package_names
      },
      common_packages => {
        name    => $nullmailer::params::common_package_names,
        require => 'build_packages'
      },
      extra_packages  => {
        name    => $nullmailer::params::extra_package_names,
        require => 'common_packages'
      }
    },
    defaults  => {
      ensure => $nullmailer::params::package_ensure
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  $remotes = $nullmailer::params::remotes

  coral::file { $base_name:
    resources => {
      config => {
        path    => $nullmailer::params::remotes_file,
        content => template($nullmailer::params::remotes_template),
        owner   => $nullmailer::params::remotes_owner,
        group   => $nullmailer::params::remotes_group,
        mode    => $nullmailer::params::remotes_file_mode,
        notify  => Service["${base_name}_service"]
      }
    }
  }

  #-----------------------------------------------------------------------------
  # Actions

  coral::exec { $base_name: }

  #-----------------------------------------------------------------------------
  # Services

  coral::service { $base_name:
    resources => {
      service => {
        name   => $nullmailer::params::service_name,
        ensure => $nullmailer::params::service_ensure
      }
    },
    require => [ Coral::Package[$base_name], Coral::File[$base_name] ]
  }

  #---

  coral::cron { $base_name:
    require => Coral::Service[$base_name]
  }
}
