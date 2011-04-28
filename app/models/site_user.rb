class SiteUser < ActiveRecord::Base
  belongs_to :site
  belongs_to :user

#  def after_save
#    site_uses = SiteUser.find(:all, :conditions => " site_id = 0 AND user_id = 0 ")
#    unless site_uses.nil?
#      site_uses.each do | s |
#        s.destroy
#      end
#    end
#  end

end
