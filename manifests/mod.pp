# Class Myplace Module Installer

include vcsrepo
define myplace::mod (
    $install_dir    =   false,   # If we need to put this somewhere special
    $version        =   undef,   # Version number or trunk
    $production     =   true,    # Use Tagged version
    $source_base    =   'http://svn.strath.ac.uk/repos/moodle/plugins',

    $basicauthusername = undef,
    $basicauthpassword = undef
) {
    if ! defined(Class['myplace']) {
        fail('You must include the Myplace base class before using any myplace defined resources')
    }

    notice ("Version: ${version}")    
    #$source_base ='svn://svn.strath.ac.uk/repos/moodle/plugins'

    $mod = $name
    $base_dir = $::myplace::install_dir
    if ! $base_dir {
        fail("base_dir not defined")
    }
    
    # Expect all myplace modules to be name in form "type-name"
    # e.g. mod-strathcom, block-attendance

    $modinfo = split($mod, '-')
        
        $modtype = $modinfo[0]
        $modname = $modinfo[1]

    if ! $install_dir {       
        $mod_dir = "${base_dir}/${modtype}/${modname}"
    } else {
        $mod_dir = "${base_dir}/${install_dir}"
    }
    
    if $version == 'trunk' {
       $source_url = "${source_base}/${name}/trunk"
    } elsif ! $version {
           fail("A version (or 'trunk') must be provided")
    } else {
        if $production {
            $source_url = "${source_base}/${name}/tags/${version}"
        } else {
            $source_url = "${source_base}/${name}/branches/${version}"
        } 
    }
   
    notice("Source URL: ${source_url}")
    notice("Install Location: ${mod_dir}")

    if $basicauthusername {
        vcsrepo { $mod_dir:
        ensure => present,
        provider => svn,
        source => $source_url,
        basic_auth_username => "${basicauthusername}",
        basic_auth_password => "${basicauthpassword}"
       }
    } else {
        vcsrepo { $mod_dir:
            ensure => present,
            provider => svn,
            source => $source_url
        }
    }
}
