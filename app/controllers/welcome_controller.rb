class WelcomeController < ApplicationController
  def index
    @page = Page.new
  end

  def about
  end
end
