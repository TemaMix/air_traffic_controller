class PlaneTakeoffJob < ApplicationJob

  queue_as :default

  def perform
    RunwayRuleService.instance.queue_handler
  end
end
