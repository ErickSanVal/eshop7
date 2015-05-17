class Admin::TshirtController < AuthenticatedController
  def new
    load_data
    @tshirt = Tshirt.new
    @page_title = 'Create new tshirt'
  end

  def create
    @tshirt = Tshirt.new(tshirt_params)
    if @tshirt.save
      flash[:notice] = "tshirt #{@tshirt.club} was succesfully created."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Create new tshirt'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @tshirt = Tshirt.find(params[:id])
    @page_title = 'Edit tshirt'
  end

  def update
    @tshirt = Tshirt.find(params[:id])
    if @tshirt.update_attributes(tshirt_params)
      flash[:notice] = "tshirt #{@tshirt.club} was succesfully updated."
      redirect_to :action => 'show', :id => @tshirt
    else
      @page_title = 'Edit tshirt'
      render :action => 'edit'
    end
  end

  def destroy
    @tshirt = Tshirt.find(params[:id])
    @tshirt.destroy
    flash[:notice] = "Succesfully deleted tshirt #{@tshirt.club}."
    redirect_to :action => 'index'
  end

  def show
    load_data
    @tshirt = Tshirt.find(params[:id])
    @page_title = @tshirt.club
  end

  def index
    @tshirts = Tshirt.all
    @page_title = 'Listing tshirts'
  end

  private
    def tshirt_params
      params.require(:tshirt).permit(:manufacturer_id, :price, :size, :country, :club)#, :image)
    end

    def load_data
    @manufacturers = Manufacturer.all
end
end
