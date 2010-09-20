module ApplicationHelper
  
  SITE_TITLE = "Image-A-Day"
  
  def site_title()
    SITE_TITLE
  end
  
  def edit_subject_path(subject)
    if subject.is_a? Image
      # FIXME: images cannot yet be edited
      #return edit_image_path(subject)
      return nil
    elsif subject.is_a? Comment
      return edit_comment_path(subject)
    else
      # FIXME: this should return something more erroneous
      return nil
    end
  end
end
