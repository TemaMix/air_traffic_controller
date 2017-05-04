require 'rails_helper'

describe UniqNameGenerationService, type: :service do

  before { plane }


  context 'check public method' do
    let(:plane) { create :plane, name: 'plane-1' }

    it 'check uniq name' do
      allow(described_class).to receive(:generate_string).and_return('plane-1', 'plane-1234')
      expect(described_class.generate).to eq('plane-1234')
    end
  end



end