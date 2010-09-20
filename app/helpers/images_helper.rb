module ImagesHelper
  def upload_path(date=nil)
    if date
      return "/images/upload/#{date.year}/#{date.month}/#{date.day}"
    else
      return upload_images_path
    end
  end
end
