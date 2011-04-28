class TopController < ApplicationController
	skip_before_filter :verify_authenticity_token ,:only=>[:action_name]
  def index
    @user_session = UserSession.new

    @last_check_sites = Site.all(:order => 'last_check')
    @status_sites = Site.find(:all, :conditions => ['check_status <> ? and check_status <> ? and check_status <> ? and check_status <> ?', "ok", "URL未登録", "メンテナンス中", "新規登録"])
    @domain_sites = Site.find(:all, :conditions => ['domain_deadline < ?', Date.today + 30], :order => 'domain_deadline')
    @ssl_sites = Site.find(:all, :conditions => ['ssl_deadline < ?', Date.today + 30], :order => 'ssl_deadline')
		
#		@processing_time = @last_check_sites[-1].last_check - @site_check_sites[0].last_check
#		@processing_time = @last_check_sites[-1].last_check - 1
  end

end
