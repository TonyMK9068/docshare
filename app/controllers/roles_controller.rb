class RolesController < ApplicationController

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


  def create
    @page = Page.find(params[:page_id])

  if params[:collaborator]
    find_user(params[:collaborator])
    @user
    @status = 'collaborator'
  else
    find_user(params[:viewer])
    @user
    @status = 'viewer'
  end

  @role = @user.roles.build(:page_id => @page.id, :status => @status)
  if @role.save
      flash[:notice] = "User granted access"
      redirect_to @page
    else
      flash[:error] = "Error granting access. Please try again later"
      render :index
    end
  end

  def destroy
    @role = Page.find(params[:id])
    if @role.destroy
      flash[:notice] = "Access revoked successfully."
      redirect_to :back
    else
      flash[:error] = "Error revoking access. Please try again."
      render pages_path
    end
  end
end
