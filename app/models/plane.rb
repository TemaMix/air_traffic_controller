class Plane < ApplicationRecord
  include AASM

  aasm do

    # в ангаре
    state :in_shelter, initial: true
    # ожидание вылета
    state :waiting # waiting
    # взлетает
    state :takeoff
    # вылетел
    state :flying


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
end
