class VersionsController < ApplicationController

  def show
    @page = Page.find(params[:page_id])
    @version = @page.versions.find(params[:id])
    @version = @version.reify
  end
  
end
