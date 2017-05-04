require 'rails_helper'

describe RunwayRuleService, type: :service do

  context 'public methods' do

    let(:plane) { create :plane }

    let(:instance) { described_class.new }

    context 'queue consist unique plane id' do
      it 'plane add to queue' do
        expect(instance.push_to_queue(plane)).to eq true
      end
    end
  end

end