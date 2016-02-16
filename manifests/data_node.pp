#This class sets up the hadoop name node 
class hadoop::data_node (
  $download_url               = 'http://mirror.sdunix.com/apache/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz',
  $hadoop_user                = 'hadoop',
  $cluster_name               = 'hadoop_cluster',
  $default_fs                 = 'hdfs://localhost:9000',
  $io_file_buffer_size        = '131072',
  $dfs_replication            = '1',
  $dfs_namenode_name_dir      = '/var/log/hadoop',
  $dfs_blocksize              = '268435456',
  $dfs_namenode_handler_count = '100',
  $dfs_datanode_data_dir      = "${hadoop_home}/data",
){
  $hadoop_home                = "/home/${hadoop_user}/hadoop"

  class { 'hadoop':
    hadoop_user         => $hadoop_user,
    cluster_name        => $cluster_name,
    download_url        => $download_url,
    default_fs          => $default_fs,
    io_file_buffer_size => $io_file_buffer_size,
  }

  file { "${hadoop_home}/etc/hadoop/hdfs-site.xml":
    ensure  => 'file',
    content => template('hadoop/data_node/hdfs-site.xml'),
    group   => $hadoop_user,
    owner   => $hadoop_user,
    mode    => '0644',
    require => Class[hadoop],
  }

  file { $dfs_datanode_data_dir:
    ensure  => 'directory',
    group   => $hadoop_user,
    owner   => $hadoop_user,
    mode    => '0644',
    require => Class[hadoop],
  }
}
