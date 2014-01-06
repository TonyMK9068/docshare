class RolesController < ApplicationController
  respond_to :html, :js

  def create
    @page = Page.find(params[:page_id])
    @status = Role.status_value(params)
    
    @user = User.find_user(params[:collaborator] || params[:viewer] || '') # if no user found assign value yhat will raise exception on #save
    
    if @user.blank?
      flash[:error] = 'User not found'
      render 'pages/index'
    else 
      @role = @user.roles.build(page_id: @page.id, status: @status)
      if @role.save
        redirect_to edit_page_path(@page), notice: 'User granted access.'
      else
        flash[:error] = 'Error granting access. Please try again later.'
        render 'pages/index'
      end
    end
  end

  def destroy
    @role = Page.find(params[:id])
    if @role.delete
      redirect_to :back, notice: 'Access revoked successfully.'
    else
      flash[:error] = 'Error revoking access. Please try again.'
      render 'pages/index'
    end
  end
end
