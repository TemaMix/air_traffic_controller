require 'rails_helper'

RSpec.describe PlaneTakeoffJob, type: :job do

  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      PlaneTakeoffJob.perform_later
    }.to have_enqueued_job.on_queue('default')
  end

end
