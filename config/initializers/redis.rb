require 'redis'

redis_config_from_yml = YAML.load( File.open( Rails.root.join("config/redis.yml") ) ).symbolize_keys
REDIS_CONFIG_APP = redis_config_from_yml[Rails.env.to_sym].symbolize_keys if redis_config_from_yml[Rails.env.to_sym]

$redis = Redis.new(REDIS_CONFIG_APP)
$redis.flushdb

# To clear out the db before each test
$redis.flushdb if Rails.env.test?