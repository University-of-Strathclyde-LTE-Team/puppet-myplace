# This script installs only the Moodle codebase

class myplace::install::moodle inherits myplace::install {

    $moodlesource   =   'git://github.com/moodle/moodle.git'
    $sourceprovider =   'git' #Should be consistent with above
    $sourcebranch   =   'master'    # or SVN path
    
    notice("Installing Development Environment")
    package { 'subversion':
        ensure => 'present'
    } ->
    # Clone moodle
    vcsrepo { $install_dir :
        require => Package['subversion'],
        ensure => present,
        provider => $sourceprovider,
        source => $moodlesource,
        revision => $sourcebranch
#        before => Class['myplace::install::developmentmodules']
    }
}

