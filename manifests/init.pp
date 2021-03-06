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
	$url			=	$myplace::params::url,
    $install_dir 	=	$myplace::params::install_dir,
	$data_dir		= 	$myplace::params::data_dir,
    $backup_existing= 	$myplace::params::backup_existing,
    $version     	= 	$myplace::params::version,
    $source_url  	= 	$myplace::params::source_url,
    $dbhost         =   $myplace::params::dbhost,
    $db				= 	$myplace::params::dbname,
	$dbuser			= 	$myplace::params::dbuser,
	$dbpass			=	$myplace::params::dbpass,
	$dbsocket       =   $myplace::params::dbsocket
) inherits ::myplace::params {
    notice("Installing Myplace Code Base (${environment})")
    $installer = "::myplace::install::${environment}"
    notice("Using installer ${installer}")
    class { $installer: } ->
    class { '::myplace::config': }
	    
}

