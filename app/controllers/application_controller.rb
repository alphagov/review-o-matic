class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  helper :all

  def gds_user?
    if !current_user.gds_user? 
      redirect_to root_path
    end
  end

  def explorer_path
    Plek.current.find("explore-reviewomatic") +  explore_path
  end

end
