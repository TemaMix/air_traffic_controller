class TrafficChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'TrafficChannel'
  end
end