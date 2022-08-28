class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @genres = Genre.all
    @item = Item.new
  end

  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
      flash[:notice] = "新規商品を登録しました。"
    else
      render :new
    end
  end

  def index
    @geners = Genre.all
    @item = Item.new
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path
      flash[:notice] = "商品内容をを更新しました。"
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :genre_id, :is_active)
  end

end
