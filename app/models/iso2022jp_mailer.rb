require 'nkf'
class Iso2022jpMailer < ActionMailer::Base
  @@default_charset = 'iso-2022-jp'  # これがないと "Content-Type: charset=utf-8" になる
  @@encode_subject  = false          # デフォルトのエンコード処理は行わない(自分でやる)

  def base64(text, charset="iso-2022-jp", convert=true)
    if convert
      if charset == "iso-2022-jp"
        text = NKF.nkf('-Wxm0 --oc=ISO-2022-JP-1', text)
      end
    end
    text = [text].pack('m').delete("\r\n")
    "=?#{charset}?B?#{text}?="
  end

  def create! (*)
    super
    @mail.body = NKF::nkf('-Wxm0 --oc=ISO-2022-JP-1', @mail.body)
    return @mail
  end
end

