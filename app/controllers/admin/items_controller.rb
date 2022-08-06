class Admin::ItemsController < ApplicationController
  def new
    @genres = Genre.all
    @item = Item.new
  end

  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def index
    @geners = Genre.all
    @item = Item.new
    @items = Item.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :genre_id, :is_active)
  end

end
