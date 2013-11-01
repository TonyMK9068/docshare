class PagesController < ApplicationController
  def index
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Page created successfully"
      redirect_to @page
    else
      flash[:error] = "Error saving page. Please try again"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @page = Page.find(params[:id])
  end

  def destroy
  end

end
