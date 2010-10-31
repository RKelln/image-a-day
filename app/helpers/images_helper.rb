module ImagesHelper
  def upload_path(date=nil)
    if date
      return "/images/upload/#{date.year}/#{date.month}/#{date.day}"
    else
      return upload_images_path
    end
  end

  # Returns an array of classes to be added to image based on the images date
  # If the image is within the current day, week, month or year
  def get_image_classes(image, date=nil)
    date ||= Date.today
    classes = [date.to_s]
    if image.date.year == date.year
      classes << "tyear"
      if image.date.month == date.month
        classes << "tmonth"
        # RK: note only mark as tweek and tday if the day is within the current month
        #     we always mark tyear and tmonth because they can be passed in to
        #     set the current year and month, whereas tweek and tday should only be
        #     used as compared to the actual current week and day
        if image.date.cweek == date.cweek and current_month?(date)
          classes << "tweek"
          if image.date.day == date.day
            classes << "tday"
          end
        end
      end
    end
    classes
  end

end
