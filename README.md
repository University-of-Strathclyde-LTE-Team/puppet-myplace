# puppet-myplace


This is a puppet module for downloading and moving in to place the 
University of Strathclyde's VLE, Myplace.

### Beginning with Myplace
To have Puppet install Myplace you must declare the `myplace` class:

```` puppet
class { 'myplace' : }
```

However this will *not* perform any actions.

## Usage
### Developer Provisioning

The default `myplace` class does not perform any actions


