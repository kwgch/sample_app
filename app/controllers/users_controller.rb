class momotarosController < ApplicationController
   before_action :signed_in_momotaro,
                only: [:index, :edit, :update, :destroy, :following, :followers] # SessionsHelper
  before_action :correct_momotaro,    only:[:edit, :update] #private
  before_action :admin_momotaro,      only:[:destroy] #private
  
  def index
    @momotaros = momotaro.paginate(page: params[:page])
  end

  def show
    @momotaro = momotaro.find(params[:id])
    @microposts = @momotaro.microposts.paginate(page: params[:page])
  end
    
  def new
    if signed_in?
      redirect_to root_path
    end
    @momotaro = momotaro.new
  end
  
  def create
    if signed_in?
      redirect_to root_path
    end
    @momotaro = momotaro.new(momotaro_params)
    if @momotaro.save
      sign_in @momotaro
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @momotaro
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update 
    if @momotaro.update_attributes(momotaro_params)
      flash[:success] = "Profile updated"
      redirect_to @momotaro
    else
      render 'edit'
    end
  end

  def destroy
    momotaro = momotaro.find(params[:id])#.destroy
    if momotaro.admin?
      flash[:error] = "Admin momotaro can't destroy."
    else
      momotaro.destroy
      flash[:success] = "momotaro destroyed."
    end
    redirect_to momotaros_url
  end

  def following
    @title = "Following"
    @momotaro = momotaro.find(params[:id])
    @momotaros = @momotaro.followed_momotaros.paginate(page: params[:page])
    render 'show_follow'
  end
    
  def followers
    @title = "Followers"
    @momotaro = momotaro.find(params[:id])
    @momotaros = @momotaro.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

    def momotaro_params
      params.require(:momotaro).permit(:name, :email, :password, :password_confirmation)
    end
  
    def correct_momotaro
      @momotaro = momotaro.find(params[:id])
      redirect_to(root_path) unless current_momotaro?(@momotaro)
    end
    
    def admin_momotaro
      redirect_to(root_path) unless current_momotaro.admin?
    end
    
end
