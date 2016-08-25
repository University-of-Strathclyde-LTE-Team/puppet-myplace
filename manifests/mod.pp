# Class Myplace Module Installer

include vcsrepo

define myplace::mod (
    $install_dir    =   false   # If we need to put this somewhere special
    $version        =   undef   # Version number or trunk
    $production     =   true    # Use Tagged version
) {
    if ! defined(Class['myplace']) {
        fail('You must include the Myplace base class before using any myplace defined resources')
    }
    $source_base ='https://svn.strath.ac.uk/repos/moodle/plugins'
    
    $mod = $name
    $base_dir = $::myplace::install_dir
    
    # Expect all myplace modules to be name in form "type-name"
    # e.g. mod-strathcom, block-attendance

    $modinfo = split($mod, '-')
        
        $modtype = $modinfo[0]
        $modname = $modinfo[1]

    if ! $install_dir {       
        $mod_dir = "${base_dir}/${modtype}/${modname}"
    } else {
        $mod_dir = $install_dir
    }
    
    if $version == "trunk" {
       $source_url = "${source_base}/${name}/trunk"
    } elseif $production {
       $source_url = "${source_base}/${name}/tags/${version}"
    } else {
       $source_url = "${source_base}/${name}/branches/${version}"
    }

    vcsrepo { $install_dir:
        ensure => present,
        provider => svn,
        source => $source_url
    
    }
}
