# == Class: sahara::notify::rabbitmq
#
#  RabbitMQ broker configuration for Sahara
#
# === Parameters
#
# [*durable_queues*]
#   (Optional) Use durable queues in broker.
#   Defaults to false.
#
# [*rabbit_host*]
#   (Optional) IP or hostname of the rabbit server.
#   Defaults to '127.0.0.1'.
#
# [*rabbit_port*]
#   (Optional) Port of the rabbit server.
#   Defaults to 5672.
#
# [*rabbit_use_ssl*]
#   (Optional) Connect over SSL for RabbitMQ.
#   Defaults to false.
#
# [*rabbit_userid*]
#   (Optional) User to connect to the rabbit server.
#   Defaults to 'guest'.
#
# [*rabbit_password*]
#   (Optional) Password to connect to the rabbit server.
#   Defaults to 'guest'.
#
# [*rabbit_login_method*]
#   (Optional) Method to auth with the rabbit server.
#   Defaults to 'AMQPLAIN'.
#
# [*rabbit_virtual_host*]
#   (Optional) Virtual host to use.
#   Defaults to '/'.
#
# [*rabbit_retry_interval*]
#   (Optional) Reconnection attempt frequency for rabbit.
#   Defaults to 1.
#
# [*rabbit_retry_backoff*]
#   (Optional) Backoff between reconnection attempts for rabbit.
#   Defaults to 2.
#
# [*rabbit_max_retries*]
#   (Optional) Number of times to retry (0 == no limit).
#   Defaults to 0.
#
# [*rabbit_ha_queues*]
#   (Optional) Whether to use HA queues in rabbit.
#   Defaults to false.
#
# [*notification_topics*]
#   (Optional) Topic to use for notifications.
#   Defaults to 'notifications'.
#
# [*control_exchange*]
#   (Optional) The default exchange to scope topics.
#   Defaults to 'openstack'.
#
class sahara::notify::rabbitmq(
  $durable_queues = false,
  $rabbit_host = 'localhost',
  $rabbit_port = 5672,
  $rabbit_use_ssl = false,
  $rabbit_userid = 'guest',
  $rabbit_password = 'guest',
  $rabbit_login_method = 'AMQPLAIN',
  $rabbit_virtual_host = '/',
  $rabbit_retry_interval = 1,
  $rabbit_retry_backoff = 2,
  $rabbit_max_retries = 0,
  $rabbit_ha_queues = false,
  $notification_topics = 'notifications',
  $control_exchange = 'openstack',
) {
  if $rabbit_use_ssl {
    fail('SSL configuration of message broker is not yet supported!')
  }

  sahara_config {
    'DEFAULT/rpc_backend': value => 'rabbit';
    'DEFAULT/rabbit_hosts': value => '$rabbit_host:$rabbit_port';

    'DEFAULT/amqp_durable_queues': value => $durable_queues;
    'DEFAULT/rabbit_host': value => $rabbit_host;
    'DEFAULT/rabbit_port': value => $rabbit_port;
    'DEFAULT/rabbit_use_ssl': value => $rabbit_use_ssl;
    'DEFAULT/rabbit_userid': value => $rabbit_userid;
    'DEFAULT/rabbit_password':
      value => $rabbit_password,
      secret => true;
    'DEFAULT/rabbit_login_method': value => $rabbit_login_method;
    'DEFAULT/rabbit_virtual_host': value => $rabbit_virtual_host;
    'DEFAULT/rabbit_retry_interval': value => $rabbit_retry_interval;
    'DEFAULT/rabbit_retry_backoff': value => $rabbit_retry_backoff;
    'DEFAULT/rabbit_max_retries': value => $rabbit_max_retries;
    'DEFAULT/rabbit_ha_queues': value => $rabbit_ha_queues;
    'DEFAULT/notification_topics': value => $notification_topics;
    'DEFAULT/control_exchange': value => $control_exchange;
  }
}
