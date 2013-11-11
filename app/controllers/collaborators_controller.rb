class CollaboratorsController < ApplicationController
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
    input = params[:collaborator]
    @user_attribute
    @user_attribute = input[:user]
  end


  def create
    @page = Page.find(params[:page_id])
    form_input
    find_user(@user_attribute)
    if @user
    authorize! :create, Collaborator, message: "Not authorized to add collaborators to this page"
    @collaborator = @user.collaborators.build(page: @page)
      if @collaborator.save 
        flash[:notice] = "User added successfully"
        redirect_to edit_page_path(@page)
      else
        flash[:error] = "Error adding user."
        render edit_page_path(@page)
      end
    else
      flash[:error] = "User does not exist"
      redirect_to request.referrer
    end
  end

  def destroy
    @page = Page.find(params[:page_id])
    @collaborator = Collaborator.find(params[:id])
    authorize! :destroy, Collaborator, message: "You are not authorized to edit permissions."
    if @collaborator.delete
      flash[:notice] = "Collaborator access successfully revoked."
      redirect_to edit_page_path(@page)
    else
      flash[:error] = "Error revoking access. Please try again."
      render edit_page_path(@page)
    end
  end

end
