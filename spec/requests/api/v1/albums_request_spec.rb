require 'rails_helper'

describe 'Albums API' do
  it 'can return a list of albums' do
    artist = Artist.create!(name: 'Madonna')
    genre = Genre.create!(name: 'Pop')
    year = Year.create!(year: '1986')
    10.times do |i|
      Album.create!(name: "Clever Album Name #{i}",
                    artist: artist,
                    genre: genre,
                    year: year
                    )
    end

    get '/api/v1/albums'

    expect(response).to be_success

    albums = JSON.parse(response.body)
    album = albums.first

    expect(albums.count).to eq(10)
    expect(album).to have_key('id')
    expect(album).to have_key('name')
    expect(album).to have_key('artist')
    expect(album).to have_key('genre')
    expect(album).to have_key('year')
  end

  it 'can return an album by its id' do
    artist = Artist.create!(name: 'Madonna')
    genre = Genre.create!(name: 'Pop')
    year = Year.create!(year: '1986')
    album = Album.create!(name: 'True Blue',
                          artist: artist,
                          genre: genre,
                          year: year)
    get "/api/v1/albums/#{album.id}"

    expect(response).to be_success

    album = JSON.parse(response.body)

    expect(album).to have_key('id')
    expect(album).to have_key('name')
    expect(album).to have_key('artist')
    expect(album).to have_key('genre')
    expect(album).to have_key('year')
  end

  it 'can update an album' do
    artist = Artist.create!(name: 'Madonna')
    genre = Genre.create!(name: 'Pop')
    year = Year.create!(year: '1986')
    album = Album.create!(name: 'True Blue',
                          artist: artist,
                          genre: genre,
                          year: year)
    old_name = album.name
    params = {album: {name: 'Like a Prayer'}}
    put "/api/v1/albums/#{album.id}", params

    expect(response).to be_success

    album_response = JSON.parse(response.body)

    expect(album_response['name']).to eq(params[:album][:name])
    expect(album_response['name']).to_not eq(old_name)
  end

  it 'can create a new album' do
    artist = Artist.create!(name: 'Madonna')
    genre = Genre.create!(name: 'Pop')
    year = Year.create!(year: '1986')
    params = {album: {
                name: 'True Blue',
                artist_id: artist.id,
                genre_id: genre.id,
                year_id: year.id
                }
              }
    post '/api/v1/albums', params

    expect(response).to have_http_status(201)

    album = JSON.parse(response.body)

    expect(album).to have_key('id')
    expect(album).to have_key('name')
    expect(album).to have_key('artist')
    expect(album).to have_key('genre')
    expect(album).to have_key('year')
    expect(album['name']).to eq(params[:album][:name])
    expect(album['artist']).to eq(artist.name)
    expect(album['genre']).to eq(genre.name)
    expect(album['year']).to eq(year.year)
  end

  it 'can delete an album' do
    artist = Artist.create!(name: 'Madonna')
    genre = Genre.create!(name: 'Pop')
    year = Year.create!(year: '1986')
    album = Album.create!(name: 'True Blue',
                          artist: artist,
                          genre: genre,
                          year: year)

    delete "/api/v1/albums/#{album.id}"

    expect(response).to have_http_status(204)
    expect{Album.find(album.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end