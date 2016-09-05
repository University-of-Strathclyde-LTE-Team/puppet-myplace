# Configures Myplace
class myplace::config inherits myplace {
    notice('Configuring Myplace') 
    file { "${::myplace::install_dir}/config.php": 
        ensure => file,
        content => epp('myplace/config.php.epp', {

            'dbhost' => $dbhost,
            'dbport' => $dbport,
            'dbscoket' => $dbsocket,
            'db' => $db,
            'install_dir' => $install_dir,
            'data_dir' => $data_dir,
            'dbuser' => $dbuser,
            'dbpass' => $dbpass
        })
    }
    file { "${::myplace::data_dir}": 
        ensure => directory,
        owner => 'www-data',
        group=> 'www-data'
    }
}
