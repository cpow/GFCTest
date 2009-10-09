class CommentsController < ApplicationController
  
  before_filter :require_admin, :only => [:index, :show, :edit, :update, :destroy]
  
  def require_admin
     if session[:user_id] != "admin"
       flash[:notice] = "you must be administrator to view that page"
       redirect_to :controller => "site", :action => "index"
     end
   end
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
   @comment = Comment.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
      
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @post = Post.find(params[:post_id])
    
    if session[:user_id] == 18796
      @comment = @post.comments.new(params[:comment])
    else
      @user = User.find(session[:user_id])
      @comment = @post.comments.new(params[:comment].merge :user_id => @user.id)
  end
    
    #@comment = current_user.comments.create(params[:comment])
    
  #@comment.user_id = session[:user_id]
  #@comment.user.name = @user.name
  
    if @comment.save
      flash[:notice] = 'Thank you for the comment'
      redirect_to @post
    else
      flash[:notice] = "You can't post nothing!"
      redirect_to @post
    end
 end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
