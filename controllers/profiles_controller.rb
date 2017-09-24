class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_avatar_status, only: [:update]
  before_action :authenticate_admin!, only: [:destroy, :index]

  
  respond_to :html
   
  def index
    @profiles = Profile.all
  end
  
  def show
    redirect_to @profile.user
    #respond_with(@profile)
  end
  
  def new
    @profile = Profile.new
    @profile.avatar = params[:file]
    respond_with(@profile)
  end
  
  def edit  
  end
  
  #def create
  #  @profile = Profile.new(profile_params)
  #  @profile.user_id = current_user.id
  #  @profile.save
  #  if @profile.save
  #    redirect_to current_user, notice: 'Profile was successfully submitted.'
  #  else
  #    render 'new', notice: @profile.errors.full_messages
  #  end
  #end
  
  def update

    @profile.update(profile_params)

    if @profile.save
    @profile.avatar_status
    respond_with(@profile.user)
    else
      render 'edit'
    end
  end
  
  def destroy
    @profile.destroy
    respond_with(@profiles)
  end

  
  private

  def set_profile
    @profile = Profile.find(params[:id])
  end
  
  def set_avatar_status    
    @profile.avatar_status = [false]
  end
  
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :nickname, :bio, :location, :age, :artist_genre, :avatar, :avatar_status, :user_id)
  end
  
end
