class CatalogController < ApplicationController
    before_filter :initialize_cart

  def show
    @tshirt = Tshirt.find(params[:id])
    @page_title = @tshirt.club
  end

  def index
    @tshirts = Tshirt.order("tshirts.id desc").includes(:manufacturer).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Catalog'
  end

  def latest
    @tshirts = Tshirt.latest 5
    @page_title = 'Latest T-shirts'
  end

end
