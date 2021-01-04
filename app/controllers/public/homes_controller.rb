class Public::HomesController < ApplicationController
  def top
    @genre = Genre.all
    @item = Item.where(is_active: true)
  end

  def about
  end

end
