class LinksController < ApplicationController
  before_filter :require_login
  respond_to :html
  def index
    @links= Link.order("position").all
    respond_with(@links)
  end

  def new
    @link= Link.new
    respond_with(@link)
  end

  def create
    @link=Link.new(params[:link])
    if @link.save
      redirect_to @link, :notice=> "link was successfully created"
    else
      render :action=>"new"
    end
  end

  def edit
    @link=Link.find(params[:id])
    respond_with(@link)
  end

  def update
    @link=Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to @link,:notice=>"link was successfully updated"
    else
      render :action=>"edit"
    end
  end

  def show
    @link=Link.find(params[:id])
  end

  def destroy
    @link=Link.find(params[:id])
    @link.destroy
    redirect_to links_path
  end

  def move_up
    @link=Link.find(params[:id])
    @link.move_up
    redirect_to links_path
  end
  def move_down
    @link=Link.find(params[:id])
    @link.move_down
    redirect_to links_path
  end
end

