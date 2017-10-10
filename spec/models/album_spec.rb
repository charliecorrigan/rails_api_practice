require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:artist) { Artist.create(name: 'Madonna') }
  let(:genre) { Genre.create(name: 'Pop') }
  let(:year) { Year.create(year: '1986') }
  let(:album) { Album.create(name: 'True Blue', artist: artist, genre: genre, year: year) }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:artist) }
    it { should validate_presence_of(:genre) }
    it { should validate_presence_of(:year) }
  end

  context 'relationships' do
    it { should belong_to(:artist) }
    it { should belong_to(:genre) }
    it { should belong_to(:year) }
  end
end
