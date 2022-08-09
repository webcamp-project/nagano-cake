class Public::ItemsController < ApplicationController
  def index
    @geners = Genre.all
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
