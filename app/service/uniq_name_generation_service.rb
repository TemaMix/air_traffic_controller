class UniqNameGenerationService

  class << self

    # @note: generate uniq name for plane and check uniqs
    # @result: string
    def generate
      begin
        uniq_string = generate_string
        plane = Plane.find_by(name: uniq_string)
      end while plane.present?
      uniq_string
    end

    private

    def generate_string
      "plane-#{rand(36**4).to_s(36)}"
    end
  end

end