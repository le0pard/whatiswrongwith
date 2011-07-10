class Admin::UserSessionsController < ApplicationController
  layout 'sign'
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = I18n.t("flash.user_session.create")
      redirect_back_or_default admin_root_path
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = I18n.t("flash.user_session.destroy")
    redirect_back_or_default new_admin_user_session_path
  end
  
end
