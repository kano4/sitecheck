class GroupsController < ApplicationController
#	before_filter :require_user
	before_filter :require_admin

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @sites = Site.find(:all, :conditions => {:group => @group.name})
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to :groups
    else
      render :action => 'new'
    end
  end

  def update
    @group = Group.find(params[:id])
    @group.attributes = params[:group]
    if @group.save
      redirect_to :groups
    else
      render :action => 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to :groups
  end

end
