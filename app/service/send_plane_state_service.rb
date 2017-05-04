class SendPlaneStateService

  extend ChannelHelper


  def self.update(plane)
    broadcast 'TrafficChannel', render_json(
        template: 'planes/_plane',
        locals: { plane: plane }
    )
  end

end