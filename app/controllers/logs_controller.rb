class LogsController < ApplicationController
	before_filter :require_user

  def index
    @logs = Log.all(:order => 'date DESC')
  end
end
