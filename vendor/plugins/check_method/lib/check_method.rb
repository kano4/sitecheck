# CheckMethod
class CheckMethod
	def check_html(site)
		# とりあえずtype1だけ。サイトのカラムにチェック方法を追加したら、ここをいじる。
		# site.check_type
		check_type = 1

		case check_type
		when 1
			self.check_all_html site
		else
			puts "ERROR"
		end
	end

	def check_all_html(site)

		# mail_statusが0なら何もしない。1ならメールで通知。
		@mail_status = 0

		site.check_status = "" if site.check_status.nil?
		if site.site_status == "メンテナンス中"
 			site_status = "メンテナンス中"
 			site.check_status = "メンテナンス中"
		elsif site.check_url == ""
			@site_status = "URL未登録"
			site.check_status = "URL未登録"
		else
			agent = Mechanize.new

			# リトライ回数を指定できるようにする
			retry_count = 0

			# 例外処理
			begin
				uri = URI.parse(site.check_url)
				retry_count += 1
				agent.get(uri)
			rescue TimeoutError
				if retry_count < 3
					retry
				end

				@site_status = "Timeout"
				site.check_status = "Timeout"
				@mail_status = 1

			rescue Mechanize::ResponseCodeError => ex
				if retry_count < 3
					retry
				end

				case ex.response_code
				when '400'
					@site_status = "400"
					site.check_status = "400"
				when '401'
					@site_status = "401"
					site.check_status = "401"
				when '402'
					@site_status = "402"
					site.check_status = "402"
				when '403'
					@site_status = "403"
					site.check_status = "403"
				when '404'
					@site_status = "404"
					site.check_status = "404"
				when '405'
					@site_status = "405"
					site.check_status = "405"
				when '406'
					@site_status = "406"
					site.check_status = "406"
				when '407'
					@site_status = "407"
					site.check_status = "407"
				when '408'
					@site_status = "408"
					site.check_status = "408"
				when '409'
					@site_status = "409"
					site.check_status = "409"
				when '410'
					@site_status = "410"
					site.check_status = "410"
				when '411'
					@site_status = "411"
					site.check_status = "411"
				when '412'
					@site_status = "412"
					site.check_status = "412"
				when '413'
					@site_status = "413"
					site.check_status = "413"
				when '414'
					@site_status = "414"
					site.check_status = "414"
				when '415'
					@site_status = "415"
					site.check_status = "415"
				when '416'
					@site_status = "416"
					site.check_status = "416"
				when '417'
					@site_status = "417"
					site.check_status = "417"
				when '500'
					@site_status = "500"
					site.check_status = "500"
				when '501'
					@site_status = "501"
					site.check_status = "501"
				when '502'
					@site_status = "502"
					site.check_status = "502"
				when '503'
					@site_status = "503"
					site.check_status = "503"
				when '504'
					@site_status = "504"
					site.check_status = "504"
				when '505'
					@site_status = "505"
					site.check_status = "505"
				else
					@site_status = "unknown"
					site.check_status = "unknown"
				end
				@mail_status = 1
			rescue
				# chekc_urlが不正な場合はここ
				@site_status = "無効URL"
				site.check_status = "無効URL"
				@mail_status = 1
			else
			
				# 正常な場合の処理

				######################
				# htmlを全てチェック #
				######################

				# base64で取得したhtmlをエンコード
				get_html = Base64.encode64(agent.page.parser)
	
				site.check_html = "" if site.check_html.nil?
				if site.check_html.gsub("\r", '').strip == get_html.gsub("\r", '').strip
					@site_status = "変更なし"
					site.check_status = "ok"
				else
					if site.check_html == ""
						@site_status = "新規登録"
						@mail_status = 1
						site.check_status = "新規登録"
					else
						@site_status = "html変更"
						@mail_status = 1
						site.check_status = "html変更"
	
						# 差分を取得
						a = Base64.decode64(site.check_html.gsub("\r", '').strip)
						b = Base64.decode64(get_html.gsub("\r", '').strip)
						diffs = Diff::LCS.sdiff(a.split(/\n/),b.split(/\n/))
	
						diff_html = "差分\n"
						diffs.each { |d|
							if d.old_element == d.new_element
								#puts " #{d.old_element}"
							else
								diff_html << "-#{d.old_element}\n" if d.old_element
								diff_html << "+#{d.new_element}\n" if d.new_element
							end
						}
						# ここまで差分を取得
	
					end
					# if
				end
				# if

				# 取得したhtmlをDBに保存
				site.check_html = get_html

				########################
				# / htmlを全てチェック #
				########################
			
			end
			# begin
		end
		# if

		# 変更、もしくはエラーがあった場合、担当者にメールを送信
		if @mail_status == 1
			# Msend.deliver_alertmailの引数の関係で、diff_htmlがnilの場合は空の値を入れておく
			diff_html = "" if diff_html.nil?

			users = User.find(site.users)
			users.each do |user| 
				user_name = user.name
				user_email = user.email
				Msend.deliver_alertmail(user_name, user_email, site.check_url, site.site_name, site.check_status, site.id, diff_html)
			end

		end

		# 最終データ取得日を記録
		site.last_check = Time.now.to_s

		# メールの送信
		if @mail_status == 1
			# 画面に表示する内容
			@show_message = "#{@site_status} 担当者にメールで通知しました。"

			# ログを残す
			log = Log.new
			log.date = Time.now
			log.status = @site_status
			log.site_name = site.site_name
			log.site_url = site.site_url
			log.diff = diff_html
#			log.webimage = 
			log.save
			


			begin
				#check_log << "(http://10.0.1.28/webimage/images/#{site.id.to_s[0, 1]}/#{site.id.to_s[1, 1]}/#{site.id}.png)"

				# ActiveMQ
				begin
					conn = Stomp::Client.new("test", "", "localhost", 61613)
				rescue
					#check_log << " Stomp Error"
				else
					dest = "/queue/convert-flash2img"
					msg = {'id' => site.id, 'url' => site.check_url, 'width' => '1024', 'height' => '768'}
					conn.send(dest, msg.to_yaml)
					conn.close
				end

			rescue => e
				p e
 			end

		else
			@show_message = @site_status
		end

		# 最後DBに保存
		site.save
	end

end
