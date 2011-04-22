class PostsController < ApplicationController
  respond_to :html
  before_filter :require_login,:except=>%w'index show'

  rescue_from ActiveRecord::RecordNotFound, :with => ''
  def index
    offset=params[:page] ||= 0
    posts_per_page=10
    @has_more=Post.count > (offset+1)*posts_per_page
    @posts= Post.order("created_at DESC").limit(posts_per_page).offset(posts_per_page*offset).all
    respond_with(@posts)
  end

  def new
    @post= Post.new
    respond_with(@post)
  end

  def create
    @post=Post.new(params[:post])
    @post.user=current_user
    if @post.save
      redirect_to @post, :notice=> "Post was successfully created"
    else
      render :action=>"new"
    end
  end

  def edit
    @post=Post.find(params[:id])
    respond_with(@post)
  end

  def update
    @post=Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post,:notice=>"Post was successfully updated"
    else
      render :action=>"edit"
    end
  end

  def show
    @post=Post.find(params[:id])
    #TODO: change according to role when roles will be
    @comments=if logged_in?
      @post.comments
    else
      @post.comments.where(:published=>true)
    end
    @comment=Comment.new
    respond_with(@post)
  end

  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  protected
  def record_not_found
    raise "Record not Found"
  end

end

