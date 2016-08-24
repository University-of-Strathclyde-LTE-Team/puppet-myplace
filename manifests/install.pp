class myplace::install inherits myplace {
	if ! defined(Class['myplace::params']) {
	    fail('You must include the myplace::params class before this')
	}
    
    if ( $backup_existing ) {
        $source_dir = $install_dir
        $target_dir = "${install_dir}${backup_suffix}"
        file { 'backup' :
            path => "${target_dir}",
            ensure => 'directory',
            source => "file://${source_dir}",
            recurse => true,
            before => File['deleteold']   
        }
    }

    file { "deleteold" :
	path => $install_dir, 
	ensure => 'directory',
        purge => true,
        recurse => true,
        before => File['tempdir']
    }
    
    $tempdir = "/tmp/myplace"
    $temppackage = "${tempdir}/myplace.tar.gz"
    
    file { "tempdir" : 
        path => $tempdir,
        ensure => 'directory',
        before => File['installpackage']
    }
    # Move the Myplace package in to place
    # Assumptions:
    # 1. Package is located at the $source_url location
    # 2. It is an archive file
    file { 'installpackage' :
        source => $source_url,
        path => "${temppackage}",
        ensure => 'file',
        before => Exec["expandtarball"]
    }
    
    exec { "expandtarball": 
	path => "/bin",
        command => "tar -xzvf ${temppackage} -C ${install_dir}",
        cwd => "${tempdir}",
        require => [
            File["tempdir"],
            File["installpackage"]
        ]
    }
    
}
