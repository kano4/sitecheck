class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.login_field = :user_id
		c.validate_email_field = false  # メールアドレス関連の懸賞を無効化
	end
	validates_confirmation_of :password

	has_many :site_user, :dependent => :destroy
 	has_many :sites, :through => :site_user

  validates_presence_of :user_id, :name, :host

  protected
  def after_initialize
    self.host = 'その他' if self.host.nil?
    self.usertype = 'normal' if self.usertype.nil?
		self.summary_mail = false if self.summary_mail.nil?
  end
end
