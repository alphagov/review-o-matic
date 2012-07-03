class RootController < ApplicationController

  layout "browser"

  def index
    @sections = MigratoratorApi::Tag.all_by_group("section")
  end

end
