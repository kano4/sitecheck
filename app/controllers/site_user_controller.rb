class SiteUserController < ApplicationController
#	before_filter :require_user
	before_filter :require_admin

  def index
    @sites = Site.all
  end

  def show
    @site = Site.find(params[:id])
#    @users = User.find(:all)
    @users = User.find(@site.users)
  end

  def edit
    @site = Site.find(params[:id])
    @users = User.find(:all)

		@site_user = User.find(@site.users)
		@user_ids  = []
    @site_user.each do | site_user |
      @user_ids.push(site_user.id)
    end
  end

  def update
#    @users = params[:users].join(",")

    site = Site.find(params[:id])

    site.site_user.clear
 
    if params[:users] != nil
    then
      params[:users].each do |user|
        site.site_user.build( :user_id => user )
      end
    end
 
    site.save
    redirect_to :controller => :sites, :action => 'show', :id => site.id
#    render :controller => :sites
  end

end
