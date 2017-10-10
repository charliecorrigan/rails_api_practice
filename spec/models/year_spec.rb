require 'rails_helper'

RSpec.describe Year, type: :model do
  let(:year) { Year.create(year: "1988") }

  context 'validations' do
    it { should validate_presence_of(:year) }
  end

  context 'relationships' do
    it { should have_many(:albums) }
  end
end
