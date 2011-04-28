class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details


  # Scrub sensitive parameters from your log
	filter_parameter_logging :password

	helper_method :current_user
	
	private

	def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.record
	end

	# ログインしていない場合 
	def require_no_user
		if current_user
			redirect_to root_url
			return false
		end
	end

	# ログインしている場合
	def require_user
		unless current_user
			redirect_to root_url
			return false
		end
	end

	# 管理者としてログインされている必要がある場合
	def require_admin
		unless current_user && current_user.usertype == 'admin' # request.env['REMOTE_HOST']
			redirect_to root_url
			return false
		end
	end

end
