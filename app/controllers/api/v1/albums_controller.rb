class Api::V1::AlbumsController < ApiBaseController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      render :show
    else
      head :no_content
    end
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      render :show, :status => 201
    end
  end

  def destroy
    @album = Album.find(params[:id]).delete
    head :no_content
  end

  private

  def album_params
    params.require(:album).permit(:id, :name, :artist_id, :genre_id, :year_id)
  end
end