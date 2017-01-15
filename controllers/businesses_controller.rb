class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!, only: [:index, :new, :create, :destroy]
  respond_to :html

  def index
    @businesses = Business.all
    respond_with(@businesses)
    
  end

  def show
    @reviews = @business.reviews.paginate(:page => params[:page], :per_page => 7)
  end

  def new
    @business = Business.new
    respond_with(@business)
  end

  def edit
  end

  def create
    @business = Business.new(business_params)
    respond_to do |format|
      if @business.save
        format.html { redirect_to edit_business_path(@business), notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { redirect_to state_city_category_path(@business.category.city.state, @business.category.city, @business.category), notice: @business.errors.full_messages }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @business.update(business_params)
    respond_with(@business)
  end

  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to state_city_category_path(@business.category.city.state, @business.category.city, @business.category), notice: 'Business was successfully destroyed.' }
      format.json { head :no_comment }
    end
  end

  private
    def set_business
      @business = Business.find(params[:id])
    end

    def business_params
      params.require(:business).permit(:business_name, :business_address, :business_phone, :business_website, :business_description, :business_photo_url, :business_email, :category_id)
    end
end
