class PagesController < ApplicationController

  def index
    @pages = current_user.pages
    authorize! :read, Page, message: 'You must be the account owner to view page index'
  end

  def new
    @page = Page.new
    authorize! :create, Page, message: 'Please register to create a page'
  end

  def create
    @user = current_user
    @page = @user.pages.build(params[:page])
    authorize! :create, Page, message: 'You need to be signed up to do that'
    if @page.save
      @page.set_owner(current_user)
      flash[:notice] = 'Page created successfully'
      redirect_to pages_path
    else
      flash[:error] = 'Error saving page. Try again later'
      render :new
    end
  end

  def edit
    @page = Page.find(params[:id])
    authorize! :update, @page, message: 'Not authorized to edit this page'

  end

  def update
    @page = Page.find(params[:id])
    authorize! :update, @page, message: 'Not authorized to edit this page'
    if @page.update_attributes(params[:page])
      flash[:notice] = 'Update saved successfully'
      redirect_to edit_page_path(@page)
    else
      flash[:error] = 'Error updating. Try again later'
      render :index
    end
  end

  def show
    @page = Page.find(params[:id])
    authorize! :read, @page, message: 'Not authorized to view page.'
  end

  def destroy
    @page = Page.find(params[:id])
    authorize! :destroy, @page, message: 'Must be page creator to do that'
    if @page.delete
      flash[:notice] = 'Page successfully deleted.'
      redirect_to pages_path
    else
      flash[:error] = 'Error deleting page. Try again later'
      render :index
    end
  end


end
