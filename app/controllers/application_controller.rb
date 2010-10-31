class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :specify_layout
  after_filter :flash_to_headers

  # RK: this is fun
  # After each request, if it is an ajax request then discard the flash msg
  # and instead pack it into the response headers to be displayed using js.
  # See application.js#flash()
  def flash_to_headers
    return unless request.xhr?
    flash.each_pair {|type, msg|
      response.headers["X-Flash"] = "[#{type}]#{msg}" unless msg.blank?
    }
    flash.discard  # don't want the flash to appear when you reload page
  end

  # Safely find an object (that has a user_id) and handle errors with flash messages
  # id may also be a params hash containing :id
  # TODO: add to all models so that we can do Model.safe_find(id)
  def safe_find(model, id)
    id = id[:id] if id.is_a? Hash
    begin
      object = model.find(params[:id])
      flash[:warn] = "WARNING: You do not have permission for this action" unless current_user.admin? or object.user_id == current_user.id
    rescue => e
      flash[:error] = "ERROR: #{e.message}"
    end
    object
  end

  def helper
    #Helper.instance.params = self.params
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::TextHelper
    include ApplicationHelper
  end

  protected

    def specify_layout
      # http://groups.google.com/group/plataformatec-devise/browse_thread/thread/80306c96985feca5
      # change layout for devise (login, etc) to a public facing page
      # TODO: add any other public facing controllers
      devise_controller? ? "public" : "comments"
    end
end
