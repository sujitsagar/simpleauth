class UsersController < ApplicationController
  
  before_filter :authenticate, :except => [ :new, :create, :confirm , :confirmation ]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy, :index]
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @client_ip = request.remote_ip  
    redirect_to current_user if signed_in?
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.confirmation = String.random_alphanumeric(10)
    
    if @user.save
	UserMailer.welcome_email(@user).deliver
        redirect_to  login_path, :notice => "Please Check you mail and actvae you account"
        
      else
        render :action => "new"
        
      end
    
  end

  def confirmation
     @user = User.new(params[:user])
  end

  def confirm
    #@user = User.new(params[:user])
    @user = User.find_by_confirmation(params[:user][:confirmation])
    if @user.toggle!(:active)
        flash[:success] = "Registration successful, Please login to continue"
        redirect_to root_path
    else 
        render 'confirmation'
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  private
    def String.random_alphanumeric(size=16)
  	s = ""
  	size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
  	s
    end
end
