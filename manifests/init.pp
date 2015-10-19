# Class: hadoop
# ===========================
#
# Full description of class hadoop here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'hadoop':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Bryan Wood <bryan.wood@puppetlabs.com>
#
# Copyright
# ---------
#
# Copyright 2015 Bryan Wood, unless otherwise noted.
#
class hadoop (
  $download_base_url = 'http://apache.arvixe.com/hadoop/common/hadoop-2.7.1',
  $filename          = 'hadoop-2.7.1.tar.gz',
  $hadoop_user       = 'hadoop',
){

  #Install/configure java
  require java

  #$hadoop_home = "/home/${hadoop_user}/hadoop"
  #I would rather get something like this to work but I can't:  $java_home = $java::params::java[$distribution]['java_home']
  $java_home   = '/etc/alternatives/java_sdk'
  $hadoop_home = "/home/${hadoop_user}/hadoop"

  #Create Hadoop user
  class { 'hadoop::user':
    hadoop_user => $hadoop_user,
    hadoop_home => $hadoop_home,
    java_home   => $java_home,
  }

  #Create $hadoop_home
  file { $hadoop_home:
    ensure  => directory,
    mode    => '0775',
    owner   => $hadoop_user,
    group   => $hadoop_user,
    require => User[$hadoop_user],
  }

  #Download Hadoop media
  staging::file { $filename:
    source => "${download_base_url}/${filename}",
  }

  #Extract Hadoop media to $hadoop_home
  staging::extract { $filename:
    source  => "/opt/staging/hadoop/${filename}",
    target  => "/home/${hadoop_user}/hadoop",
    user    => $hadoop_user,
    group   => $hadoop_user,
    strip   => 1,
    creates => "${hadoop_home}/bin",
    require => [File[$hadoop_home],Staging::File[$filename]],
  }

}
