class UserSessionsController < ApplicationController

  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    redirect_to current_user if signed_in?
    @user_session = UserSession.new
  end

  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @user_session = UserSession.new(params[:user_session])
    @user = User.find_by_username(params[:user_session][:username])
     if @user.active?	
      if @user_session.save
        redirect_to @user , :notice => 'Login Successful'
      else
        render :action => "new" 
      end
     else 
	render :action => "new", :notice => "Your Account is not active"
	
     end	
    
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(:users, :notice => 'Goodbye!') }
      format.xml  { head :ok }
    end
  end
end