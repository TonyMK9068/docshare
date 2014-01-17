class RolesController < ApplicationController
  respond_to :html, :js

  def create
    @project = Page.find(params[:page_id])
    @status = Role.status_value(params)
    
    @user = User.find_user(params[:collaborator] || params[:viewer] || '') # if no user found assign value that will raise exception on #save

    @role = @user.roles.build(status: @status)
    @role.page_id = @project.id
    if @role.save
      redirect_to edit_page_path(@project), notice: 'User granted access.'
    else
      flash[:error] = 'Error granting access. Please try again later.'
      render 'pages/index'
    end
  end

  def destroy
    @role = Page.find(params[:id])
    if @role.destroy
      redirect_to :back, notice: 'Access revoked successfully.'
    else
      flash[:error] = 'Error revoking access. Please try again.'
      render 'pages/index'
    end
  end
end
