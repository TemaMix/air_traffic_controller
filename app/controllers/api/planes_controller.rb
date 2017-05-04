module Api
  class PlanesController < ActionController::API

    def create
      uniq_name = UniqNameGenerationService.generate
      plane = Plane.create(name: uniq_name)
      render partial: 'planes/plane', locals: { plane: plane }
    end


  end
end