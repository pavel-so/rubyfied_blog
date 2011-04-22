class CommentsController < ApplicationController
  respond_to :html

  #TODO:allow model validation errors showing
  def index
    missing_action
  end

  def new
    missing_action
  end

  def create
    @post=Post.find(params[:post_id])
    @comment=Comment.new(params[:comment])
    @post.comments<<@comment
    if @comment.save
      redirect_to @post, :notice=> "Comment was successfully added"
    else
      redirect_to @post, :error=> "Error while commenting"
    end
  end

  def edit
    @comment=Comment.find(params[:id])
    @post=@comment.post
    respond_with(@comment)
  end

  def update
    @comment=Comment.find(params[:id])
    @post=@comment.post
    if @comment.update_attributes(params[:comment])
      redirect_to @post, :notice=> "Comment was successfully updated"
    else
      redirect_to @post, :error=> "Error while updating comment"
    end
  end

  def show
    missing_action
  end

  def destroy
    @comment=Comment.find(params[:id])
    @post=@comment.post
    @comment.destroy
    redirect_to @post,:notice=>"Comment deleted"
  end
  def publish
    @comment=Comment.find(params[:id])
    @comment.publish
    redirect_to @comment.post,:notice =>"Comment was published"
  end
  protected
  def missing_action
    redirect_to posts_path, :error=> "This action is missing"
  end
end

