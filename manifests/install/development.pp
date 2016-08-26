# This script installs a "development node

class myplace::install::development inherits myplace::install {

    $moodlesource   =   'git://github.com/moodle/moodle.git'
    $sourceprovider =   'git' #Should be consistent with above
    $sourcebranch   =   'master'    # or SVN path
    
    notice("Installing Development Environment")
    package { 'subversion':
            ensure => 'present'
    }
    # Clone moodle
    vcsrepo { $install_dir :
        ensure => present,
        provider => $sourceprovider,
        source => $moodlesource,
        revision => $sourcebranch,
        before => Class['myplace::install::developmentmodules']
    }   

    class { 'myplace::install::developmentmodules': }
}

