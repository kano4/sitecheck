class UsersController < ApplicationController
	before_filter :require_user
	before_filter :require_admin, :only => [:new, :create]

  def index
    @users = User.all(:order => 'user_id')
  end
  
  def show
    @user = User.find(params[:id])
    @sites = Site.find(@user.sites)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
			render :action => 'inform'
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @user = current_user
    @user = User.find(params[:id])
		if current_user == @user || current_user.usertype == 'admin'
    	@sites = Site.find(:all)

    	@user_site = Site.find(@user.sites)
    	@site_ids = []
    	@user_site.each do | user_site |
    	  @site_ids.push(user_site.id)
    	end
		else
			redirect_to :users
  	end
  end
  
  def update
    @user = User.find(params[:id])

   	@sites = Site.find(:all)
   	@user_site = Site.find(@user.sites)
   	@site_ids = []
   	@user_site.each do | user_site |
   	  @site_ids.push(user_site.id)
   	end

    @user.attributes = params[:user]
    if @user.save
			@user.site_user.clear
	
			if params[:sites] != nil
				params[:sites].each do |site|
					@user.site_user.build( :site_id => site )
      	end
    	end

			@user.save
      redirect_to :users
		else
      render :action => 'edit'
    end
  end

  def chgpass
    @user = User.find(params[:id])
		if current_user == @user || current_user.usertype == 'admin'
    	@sites = Site.find(@user.sites)

    	@user_site = Site.find(@user.sites)
    	@site_ids = []
    	@user_site.each do | user_site |
    	  @site_ids.push(user_site.id)
    	end
		else
			redirect_to :users
  	end
	end

	def update_chgpass
    @user = User.find(params[:id])

    @user.attributes = params[:user]
    if @user.save
      redirect_to :users
		else
      render :action => 'chgpass'
#			redirect_to :action => 'chgpass'
    end
	end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :users
  end
end
