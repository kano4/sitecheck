module ApplicationHelper
  def document_title
    if @document_title.present?
      h(@document_title) + ' - サイト監視'
    else
      'サイト監視'
    end
  end

  def copyright
    text = '&copy; 2011 itokuro.inc., All Rights Reserved &reg'
  end
end
