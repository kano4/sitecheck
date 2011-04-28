require 'rubygems'
require 'mechanize'
require 'kconv'
require 'base64'
#require 'yaml'
require 'json'
require 'stomp'
require 'whois'
require 'diff/lcs'

class SitesController < ApplicationController
	before_filter :require_user
	before_filter :require_admin, :except => [:index, :show]

	def index
    @sites = Site.all
  end

  def show
    @site = Site.find(params[:id])
		@users = User.find(@site.users)
  end

  def new
    @site = Site.new
    @site.attributes = params[:site] if request.post?
    @c_date = Time.now.to_s
  end

  def edit
    @site = Site.find(params[:id])
    @site.attributes = params[:site] if request.put?
    @c_date = @site.created_date
  end

  def create
    @site = Site.new(params[:site])
		@site.site_url = @site.site_url.strip
		@site.check_url = @site.check_url.strip
		@site.domain_name = @site.domain_name.strip
		@site.ssl_check_name = @site.ssl_check_name.strip
    if @site.save
      render :action => 'inform'
    else
      render :action => 'new'
    end
  end

  def infrom
    @site = Site.new(params[:site])
  end

  def confirm
    if request.post?
      @site = Site.new(params[:site])
    else
      @site = Site.find(params[:id])
      @site.attributes = params[:site]
    end
    if @site.valid?
      render :action => 'confirm'
    else
      render :action => request.post? ? 'new' : 'edit'
    end
  end

  def update
    @site = Site.find(params[:id])
    @site.attributes = params[:site]
		@site.site_url = @site.site_url.strip
		@site.check_url = @site.check_url.strip
		@site.domain_name = @site.domain_name.strip
		@site.ssl_check_name = @site.ssl_check_name.strip
    if @site.save
      redirect_to :sites
    else
      render :action => 'edit'
    end
  end

  def check
		site = Site.find(params[:id])
		site.attributes = params[:site] if request.put?

		# モデルのeach_checkを呼び出す。引数はsite
		Site.each_check site
	end

  def send_summary
#    @sites = Site.send_summary
  end

  def all_check
    @sites = Site.all_check

    redirect_to :sites
  end

	def check_domain
    @site = Site.find(params[:id])

		client = Whois.query @site.domain_name
		@site.domain_deadline = client.expires_on

    # 忘れずに保存
    @site.save
	end

  def show_html
    @site = Site.find(params[:id])
  end

  def check_log
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to :sites
  end

end
