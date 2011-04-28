class Msend < Iso2022jpMailer
	def summarymail(user_name, user_email, domain_sites, ssl_sites)
    subject    base64('【サイト監視】サマリー' + Time.now.strftime('%Y/%m/%d'))
    recipients user_email
    from       'dev-null@itokuro.jp'
    sent_on    Time.now

		body :user_name => user_name,
				 :user_email => user_email,
				 :domain_sites => domain_sites,
				 :ssl_sites => ssl_sites,
         :rest_date => Time.now
	end

  def alertmail(user_name, user_email, check_url, site_name, site_status, site_id, diff_html)
    subject    base64('【サイト監視】' + site_status + ':' + site_name)
    recipients user_email
    from       'dev-null@itokuro.jp'
    sent_on    Time.now
    
    body       :user_name => user_name,
               :user_email => user_email,
               :site_name => site_name,
               :check_url => check_url,
               :site_status => site_status,
               :site_id => site_id,
               :diff_html => diff_html,
               :date => Time.now.strftime('%Y/%m/%d %H:%M:%S')

  end

end
