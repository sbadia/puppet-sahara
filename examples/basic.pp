# First, install a mysql server
class { 'mysql::server':
  # sahara documentation recommends this configuration.
  override_options   => {
    'mysqld' => {
      'max_allowed_packet' => '256M'
    }
  },

  # many configurations will need this line, too
  package_name       => 'mariadb-galera-server',

  # if you're installing into an existing openstack
  manage_config_file => false,
  purge_conf_dir     => false,
}

# Then, create a database
class { 'sahara::db::mysql':
  password => 'a_big_secret',
}

# And connect a message bus
class { 'sahara::notify::rabbitmq':
  rabbit_password => 'guest',
  rabbit_use_ssl  => false,
}

# Then the common class
class { 'sahara':
  database_connection => 'mysql://sahara:a_big_secret@127.0.0.1:3306/sahara',
  verbose             => true,
  debug               => true,
  os_username         => 'admin',
  os_password         => 'secrets_everywhere',
  os_tenant_name      => 'admin',
  os_auth_url         => 'http://127.0.0.1:5000/v2.0/',
  identity_url        => 'http://127.0.0.1:35357/',
  service_host        => '127.0.0.1',
  service_port        => 8386,
  use_neutron         => true,
}

# Finally, make it accessible
class { 'sahara::keystone::auth': }
