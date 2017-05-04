class TrafficControllerService

  attr_accessor :plane, :runway_rule

  def initialize(plane)
    @plane = plane
    @runway_rule = RunwayRuleService.instance
  end

  def decide!
    has_plane_takeoff? ? plane.wait! : plane.get_off!
    if runway_rule.push_to_queue(plane)
      PlaneTakeoffJob.perform_later unless runway_rule.handler_run
    end
  end

  private

  def has_plane_takeoff?
    !! Plane.find_by(aasm_state: :takeoff)
  end

end

