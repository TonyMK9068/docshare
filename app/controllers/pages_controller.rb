class PagesController < ApplicationController
  def index
    @pages = current_user.pages.all
  end

  def new
    @page = Page.new
    authorize! :create, Page, message: "You need to be registered!"
  end

  def create
    @page = current_user.pages.build(params[:page])
    authorize! :create, Page, message: "You need to be signed up to do that."
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
    authorize! :read, Page
  end

  def destroy
  end

end
