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
    @page = Page.find(params[:id])
    authorize! :update, @page, message: "You must have created the page in order to edit it"

  end

  def update
    @page = Page.find(params[:id])
    authorize! :update, @page, message: "You must have created the page in order to edit it"
    if @page.update_attributes(params[:page])
      flash[:notice] = "Update successful"
      redirect_to @page
    else
      flash[:error] = "Error updating. Please try again later"
      render :index
  end
end

  def show
    @page = Page.find(params[:id])
    authorize! :read, @page, message: 'You must be registered and approved to view this page'
  end

  def destroy
    @page = Page.find(params[:id])
    authorize! :destroy, @page, message: 'Must be page creator to delete'
    if @page.destroy
      flash[:notice] = "Page successfully deleted."
      redirect_to pages_path
    else
      flash[:error] = 'Error deleting page, check permissions'
      render :index
    end
  end
end
