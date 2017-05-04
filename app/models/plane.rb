class Plane < ApplicationRecord
  include AASM

  has_paper_trail only: [:aasm_state]

  default_scope { order('created_at DESC') }

  scope :get_order_planes, ->(plane_ids){ where(id: plane_ids).order("position(id::text in '#{plane_ids.join(',')}')") }

  aasm do

    # в ангаре
    state :in_shelter, initial: true
    # ожидание вылета
    state :waiting
    # взлетает
    state :takeoff
    # вылетел
    state :flying

    after_all_events :send_updated_plane

    event :wait do
      transitions :from => :in_shelter, :to => :waiting
    end

    event :get_off do
      transitions :from => [:in_shelter,:waiting], :to => :takeoff
    end

    event :fly_off do
      transitions :from => :takeoff, :to => :flying
    end

  end

  def send_updated_plane
    SendPlaneStateService.update(self)
  end

  # @note: return history state with locale
  # @return: array
  def history_human_states
    history_human_states = []
    self.versions.each do |version|
      unless version.reify.nil?
        history_human_states  << version.reify.aasm.human_state
      end
    end
    history_human_states.push(self.aasm.human_state)
    history_human_states.reverse
  end

end
