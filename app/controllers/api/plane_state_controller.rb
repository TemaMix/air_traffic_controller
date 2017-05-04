module Api
  class PlaneStateController < ActionController::API

    def update
      traffic_controller = TrafficControllerService.new(current_plane)
      traffic_controller.decide!
      render partial: 'planes/plane', locals: { plane: current_plane }
    end

    private

    def current_plane
      @current_plane ||= Plane.find(params[:id])
    end

  end
end
