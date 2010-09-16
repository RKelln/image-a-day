class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :specify_layout

  protected

    def specify_layout
      # http://groups.google.com/group/plataformatec-devise/browse_thread/thread/80306c96985feca5
      # change layout for devise (login, etc) to a public facing page
      # TODO: add any other public facing controllers
      devise_controller? ? "public" : "application"
    end 
end
