json.(@album)
json.set! :id, @album.id
json.set! :name, @album.name
json.set! :artist, @album.artist.name
json.set! :genre, @album.genre.name
json.set! :year, @album.year.year