class UsersController < ApplicationController

before_filter :require_admin, :only => [:index, :create, :new]

def require_admin
  if session[:user_id] != "admin"
    flash[:notice] = "you must be administrator to view that page"
    redirect_to :controller => "site", :action => "index"
  end
end

  
    def login 
     if request.post? and params[:user]
       @user = User.new(params[:user])
       if @user.email == "admin" && @user.password =="utest123"
         session[:user_id] = "admin"
         flash[:notice] = "Administrator has logged in"
         redirect_to :controller => "users", :action => "index"
       else
         user = User.find_by_email_and_password(@user.email, @user.password) 
         if user 
           session[:user_id] = user.id 
           flash[:notice] = "User #{user.name} logged in!" 
           redirect_to :controller => "site", :action => "index" 
         else 
           # Don't show the password in the view. 
           @user.password = nil 
           flash[:notice] = "Invalid screen name/password combination" 
         end 
       end 
     end
   end
   
    def logout
      session[:user_id] = nil
      redirect_to :action => "login"
    end
    
  
  # GET /users
  # GET /users.xml
  def index    
    
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
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

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
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
