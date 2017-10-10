require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist) { Artist.create(name: 'Madonna') }

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'relationships' do
    xit { should have_many(:albums) }
  end
end
