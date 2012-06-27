class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def percent_of(x, y)
    x.to_f / y.to_f * 100.0
  end

end
