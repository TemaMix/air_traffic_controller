require 'rails_helper'

describe TrafficControllerService, type: :service do
  subject(:traffic) { described_class.new(plane) }

  context 'No planes on the runway' do
    let(:plane) { create :plane }

    before { traffic.decide! }

    it 'plane change state on takeoff' do
      expect(plane.aasm_state).to eq 'takeoff'
    end

  end

  context 'plane is already takeoff' do
    let(:plane)  {create :plane }

    before :each do
      create :plane, aasm_state: :takeoff
      traffic.decide!
    end

    it 'plane change state on waiting' do
      expect(plane.aasm_state).to eq 'waiting'
    end

  end

end