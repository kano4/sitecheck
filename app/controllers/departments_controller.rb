class DepartmentsController < ApplicationController
#	before_filter :require_user
	before_filter :require_admin

  def index
    @departments = Department.all
  end

  def show
    @department = Department.find(params[:id])
#    @sites = Site.find(:all, :conditions => {:department => @department.name})
  end

  def new
    @department = Department.new
  end

  def edit
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      redirect_to :departments
    else
      render :action => 'new'
    end
  end

  def update
    @department = Department.find(params[:id])
    @department.attributes = params[:department]
    if @department.save
      redirect_to :departments
    else
      render :action => 'edit'
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to :departments
  end
end
