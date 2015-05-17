class Admin::ManufacturerController < AuthenticatedController
  def new
    @manufacturer = Manufacturer.new
    @page_title = 'Create new manufacturer'
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:notice] = "Manufacturer #{@manufacturer.name} was succesfully created."
      redirect_to :action => 'index'
    else
      @page_title = 'Create new manufacturer'
      render :action => 'new'
    end
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
    @page_title = 'Edit manufacturer'
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(manufacturer_params)
      flash[:notice] = "manufacturer #{@manufacturer.name} was succesfully updated."
      redirect_to :action => 'show', :id => @manufacturer
    else
      @page_title = 'Edit manufacturer'
      render :action => 'edit'
    end
  end

  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer.destroy
    flash[:notice] = "Succesfully deleted manufacturer #{@manufacturer.name}."
    redirect_to :action => 'index'
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    @page_title = @manufacturer.name
  end

  def index
    @manufacturers = Manufacturer.all
    @page_title = 'Listing manufacturers'
  end

  private
    def manufacturer_params
      params.require(:manufacturer).permit(:name, :telephone)
    end
end
