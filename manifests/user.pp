#This class sets up the hadoop user and all of the necessary environmental variables
class hadoop::user (
  $hadoop_user = 'hadoop',
  $hadoop_home = "/home/${$hadoop_user}/hadoop",
  $java_home   = '/etc/alternatives/java_sdk',
){
  #Setup Hadoop user
  user { $hadoop_user:
    ensure     => present,
    managehome => true,
  }

  file_line { 'JAVA_HOME':
    path  => "/home/${hadoop_user}/.bashrc",
    line  => "export JAVA_HOME=${java_home}",
    match => 'JAVA_HOME=',
  }

  file_line { 'HADOOP_HOME':
    path  => "/home/${hadoop_user}/.bashrc",
    line  => "export HADOOP_HOME=${hadoop_home}",
    match => 'HADOOP_HOME=',
  }

  file_line { 'HADOOP_INSTALL':
    path    => "/home/${hadoop_user}/.bashrc",
    line    => "export HADOOP_INSTALL=\$HADOOP_HOME",
    match   => 'HADOOP_INSTALL=',
    require => File_line['HADOOP_HOME'],
  }

  file_line { 'HADOOP_MAPRED_HOME':
    path    => "/home/${hadoop_user}/.bashrc",
    line    => "export HADOOP_MAPRED_HOME=\$HADOOP_HOME",
    match   => 'HADOOP_MAPRED_HOME=',
    require => File_line['HADOOP_HOME'],
  }

  file_line { 'HADOOP_COMMON_HOME':
    path    => "/home/${hadoop_user}/.bashrc",
    line    => "export HADOOP_COMMON_HOME=\$HADOOP_HOME",
    match   => 'HADOOP_COMMON_HOME=',
    require => File_line['HADOOP_HOME'],
  }

  file_line { 'HADOOP_HDFS_HOME':
    path    => "/home/${hadoop_user}/.bashrc",
    line    => "export HADOOP_HDFS_HOME=\$HADOOP_HOME",
    match   => 'HADOOP_HDFS_HOME=',
    require => File_line['HADOOP_HOME'],
  }

  file_line { 'YARN_HOME':
    path    => "/home/${hadoop_user}/.bashrc",
    line    => "export YARN_HOME=\$HADOOP_HOME",
    match   => 'YARN_HOME=',
    require => File_line['HADOOP_HOME'],
  }

  file_line { 'HADOOP_COMMON_LIB_NATIVE_DIR':
    path    => "/home/${hadoop_user}/.bashrc",
    line    => "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native",
    match   => 'HADOOP_COMMON_LIB_NATIVE_DIR=',
    require => File_line['HADOOP_HOME'],
  }

  file_line { 'HADOOP_USER_PATH':
    path    => "/home/${hadoop_user}/.bashrc",
    line    => "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin",
    require => File_line['HADOOP_HOME'],
  }
}
