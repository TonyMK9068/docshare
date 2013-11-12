class ViewersController < ApplicationController
  respond_to :html, :js

  def find_user(input)
    if  User.find_by_email(input)
      @user = User.find_by_email(input)
    elsif User.find_by_username(input)
      @user = User.find_by_username(input)
    else
      @user = nil
    end
    @user
  end

  def form_input
    input = {}
    input = params[:viewer]
    @user_attribute
    @user_attribute = input[:user]
  end

  def create
    @page = Page.find(params[:page_id])
    form_input
    find_user(@user_attribute)
    if @user
    authorize! :create, Viewer, message: "You are not authorized to add viewers to this page."
    @viewer = @user.viewers.build(page: @page)
      if @viewer.save 
        flash[:notice] = "Permission granted successfully."
        redirect_to edit_page_path(@page)
      else
        flash[:error] = "Error adding user."
        render edit_page_path(@page)
      end
    else
      flash[:error] = "User does not exist."
      redirect_to request.referrer
    end
  end

  def destroy
    @page = Page.find(params[:page_id])
    @viewer = Viewer.find(params[:id])
    authorize! :destroy, Viewer, message: "You are not authorized to edit permissions."
    if @viewer.delete
      flash[:notice] = "Viewer access successfully revoked."
      redirect_to edit_page_path(@page)
    else
      flash[:error] = "Error revoking access. Please try again."
      render edit_page_path(@page)
    end
  end

end
