class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def my_recent
    session[:username] = params[:username] if params[:username]
    @user = User.find_by_name(session[:username])
  if !@user
    redirect_to("/a2", :notice => "You must log in to use the API!")
    else
      @last_10 = Location.find_all_by_user_id(@user.id, :limit => 10)

      respond_to do |format|
        format.xml { render :xml => @last_10 }
        format.json { render :json => @last_10 }
      end
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    
    unless (request.remote_ip == "127.0.0.1")
      @ip = request.remote_ip
    else @ip = "130.64.22.2" end

    @user_location = Geokit::Geocoders::MultiGeocoder.geocode(@ip)

    # add user to session
    session[:user]     = @user.id
    session[:username] = @user.name
    session[:ip]       = @ip

    respond_to do |format|
      if @user.save
        format.html { redirect_to(map_path, :notice => "Welcome, #{session[:username]}, IP of #{@ip} and location of (#{@user_location.lat}, #{@user_location.lng})") }
      else
        format.html { redirect_to(map_path, :notice => "Welcome back, #{session[:username]}, IP of #{@ip} and location of (#{@user_location.lat}, #{@user_location.lng})") }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
