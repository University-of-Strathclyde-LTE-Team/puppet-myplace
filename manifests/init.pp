# == Class: myplace
# Installs Myplace
#
# === Parameters
# [*install_dir*]
#  Where should Myplace source code be deployed
# [*backup_existing*]
#  Take a back up of previous install_dir
# [*version*]
#  Myplace Release to deploy 
# [*source_url*]

#include vcsrepo

class myplace (
    $install_dir = $myplace::params::install_dir,
    $backup_existing = $myplace::params::backup_existing,
    $version     = $myplace::params::version,
    $source_url  = $myplace::params::source_url
) inherits ::myplace::params {
#   require apache
#   require php

   class { '::myplace::install': }
#   class { '::myplace::config' } ->
#   class { '::myplace::service'} ->
}

