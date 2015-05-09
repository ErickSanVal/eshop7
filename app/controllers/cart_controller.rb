class CartController < ApplicationController
	before_filter :initialize_cart

  def add
  	@tshirt = Tshirt.find params[:id]
  	@page_title = 'Add item'
  	if request.post?
  		@item = @cart.add params[:id]
  		flash[:cart_notice] = "Added <em>#{@item.tshirt.club}</em>."
        redirect_to :controller => 'catalog'
  	else
  		render :controller => 'cart', :action => 'add', :template => 'cart/add'
	end
  end

  def remove
  		@tshirt = Tshirt.find params[:id]
  	@page_title = 'Add item'
  	if request.post?
  		@item = @cart.remove params[:id]
  		flash[:cart_notice] = "Added <em>#{@item.tshirt.club}</em>."
        redirect_to :controller => 'catalog'
  	else
  		render :controller => 'cart', :action => 'add', :template => 'cart/add'
	end
  end

  def clear
  	@page_title = 'Clear cart'
    if request.post?
      @cart.cart_items.destroy_all
      flash[:cart_notice] = "Cleared cart."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'clear'
    end
  end
end
