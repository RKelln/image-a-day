module ApplicationHelper

  SITE_TITLE = "Image-A-Day"

  def site_title()
    SITE_TITLE
  end

  def site_title_haml()
    #capture_haml do
      haml_tag :h1, {:id => "title"} do
        haml_tag :a, {:href => root_path} do
          haml_concat site_title
        end
      end
    #end
  end

  def edit_subject_path(subject)
    if subject.is_a? Image
      return edit_image_path(subject)
    elsif subject.is_a? Comment
      return edit_comment_path(subject)
    else
      # FIXME: this should return something more erroneous
      return nil
    end
  end

  # returns a string that is the model name and id of the instance passed in
  # this should be used to create the html id attribute for things that need to
  # have unobtrusive javascript attached to them
  # NOTE: this function returns identical output to HAML's [object] notation!!!
  # TODO: actually use HAMLs mehtod, since this is a simplified version of it
  # example:       div[instance] = <div id="classname_idnum">
  #          unique_id(instance) = "classname_idnum"
  def unique_id(instance, prepend="")
    prepend = prepend.to_s + '_' unless prepend.empty?
    return "#{prepend}#{instance.class.to_s.downcase}_#{instance.id}"
  end

  # TODO: DRY up with models/image.rb
  def short_date(date)
    date.strftime('%b %d')
  end

  def long_date(date)
    date.strftime('%d %B %Y')
  end

    # Returns true if the date passed in is within the current month
  def current_month?(date)
    return (Date.today.month == date.month and Date.today.year == date.year)
  end

  # returns true if the date is equal to the current day
  def current_day?(date)
    return (current_month?(date) and Date.today.day == date.day)
  end
end
