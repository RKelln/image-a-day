Paperclip.interpolates :year_month_day do |attachment, style|
  inst = attachment.instance
  return "#{inst.date.year}/#{Date::MONTHNAMES[inst.date.month]}/#{inst.date.day}"
end
# TODO: metaprogramming and DRYness!
Paperclip.interpolates :year do |attachment, style|
  attachment.instance.date.year
end
Paperclip.interpolates :month do |attachment, style|
  attachment.instance.date.month
end
Paperclip.interpolates :day do |attachment, style|
  attachment.instance.date.day
end
Paperclip.interpolates :yday do |attachment, style|
  attachment.instance.date.yday - 1
end

Paperclip.interpolates :nickname do |attachment, style|
  attachment.instance.user.nickname
end
Paperclip.interpolates :user_id do |attachment, style|
  attachment.instance.user.id
end

Paperclip.interpolates :opt_style do |attachment, style|
  if style.to_sym == :original
    ''
  else
    "/#{style}"
  end
end
