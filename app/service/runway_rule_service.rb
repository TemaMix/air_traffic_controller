require 'singleton'
require 'redis'
require 'redis-namespace'

class RunwayRuleService
  include Singleton

  attr_accessor :handler_run, :store

  def initialize
    @store ||= Redis.new(REDIS_CONFIG_APP)
    handler_run_store = ActiveRecord::Type::Boolean.new.cast(store.get('handler:run'))
    @handler_run ||= handler_run_store ? handler_run_store : false
  end

  # @note: check plane id on uniq value and push plane id to queue
  # @param: instance of Plane class
  # @return: true if plane id added to queue
  #          and false if plane id dit not add to queue
  def push_to_queue(plane)
    if plane_ids.include?(plane.id)
      false
    else
      store.rpush('plane:ids',plane.id)
      true
    end
  end

  def queue_handler
    return if self.handler_run
    handler_run_start
    queue_planes = get_queue_planes
    while queue_planes.size > 0 do
      plane_launch( get_plane_from(queue_planes) )
      queue_planes = get_queue_planes
    end
    handler_run_stop
  end

  private

  # @note: return first plane which it added first
  #        and remove plane id from redis array 'planes:id'
  # @param: array Plane class instances
  # @return: instance of Plane class
  def get_plane_from(queue_planes)
    plane_takeoff = queue_planes.shift
    store.lrem('plane:ids',-1, plane_takeoff.id)
    plane_takeoff
  end

  # @return: array Plane class instances
  def get_queue_planes
    Plane.get_order_planes(plane_ids).to_a
  end

  def plane_ids
    store.lrange('plane:ids',0,-1)
  end

  def plane_launch(plane)
    plane.get_off! unless plane.takeoff?
    sleep(10)
    plane.fly_off!
  end

  def handler_run_start
    store.set('handler:run',true)
    self.handler_run = true
  end

  def handler_run_stop
    store.set('handler:run',false)
    self.handler_run = false
  end

end