# Class Myplace Module Installer

include vcsrepo
define myplace::mod  (
    $install_dir    =   false,   # If we need to put this somewhere special
    $version        =   undef,   # Version number or trunk
    $source_base    =   'http://svn.strath.ac.uk/repos/moodle/plugins',
    $username       =   undef,
    $password       =   undef
) {
    include myplace
    include myplace::modparams

    if ! defined(Class['myplace']) {
        fail('You must include the Myplace base class before using any myplace defined resources')
    }

    $mod = $name
    $base_dir = $::myplace::install_dir
    if ! $base_dir {
        fail("base_dir not defined")
    }
    
    # Expect all myplace modules to be name in form "type-name"
    # e.g. mod-strathcom, block-attendance

    $modinfo = split($mod, '-')
    $modtype = $modinfo[0]
    $modname = $modinfo[-1]
    
    if ! $install_dir {       
        $nomodname = $modinfo[0,-2]
        $modpath = join($nomodname,"/")

        $mod_dir = "${base_dir}/${modpath}/${modname}"
        
    } else {
        $mod_dir = "${base_dir}/${install_dir}" 
    }
    
    if $version == 'trunk' {
       $source_url = "${source_base}/${name}/trunk"
    } elsif ! $version {
           fail("A version (or 'trunk') must be provided")
    } else {
        if $environment=="production" {
            $source_url = "${source_base}/${name}/tags/${version}"
        } else {
            $hasv = $version[0,1]
            if $hasv  != 'v' {
                $vnum = floor($version)
            } else {
                $vnum = floor($version[1,-1])
            }
            $vstring = "v${vnum}"            
            $source_url = "${source_base}/${name}/branches/${vstring}"
        } 
    }
    notice("Mod: ${mod}")
    notice ("Version: ${version}")   
    notice("Source URL: ${source_url}")
    notice("Install Location: ${mod_dir}")

    if $username {
        vcsrepo { $mod_dir:
        ensure => present,
        provider => svn,
        source => $source_url,
        basic_auth_username => "${username}",
        basic_auth_password => "${password}"
       }
    } else {
        vcsrepo { $mod_dir:
            ensure => present,
            provider => svn,
            source => $source_url
        }
    }
}
