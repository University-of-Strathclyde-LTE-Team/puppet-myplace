class myplace::install::developmentmodules {
    $username = ''
    $password = ''
    myplace::mod { 'mod-strathcom': version=>'trunk', username=>$username,password=>$password}

}
