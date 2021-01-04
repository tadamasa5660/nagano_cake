class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :edit]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
     redirect_to admin_genres_path
    else
     render 'admin/genres/index'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
     redirect_to admin_genres_path
    else
     render 'admin/genres/index'
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_active, :created_at, :updated_at)
  end

end
