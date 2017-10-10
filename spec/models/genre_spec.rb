require 'rails_helper'

RSpec.describe Genre, type: :model do
  let(:genre) { Genre.create(name: 'Pop') }

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'relationships' do
    it { should have_many(:albums) }
  end
end

