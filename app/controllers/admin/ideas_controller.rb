class Admin::IdeasController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = current_user.ideas.build
  end

  def create
    @idea = current_user.ideas.build(idea_params)

    if @idea.save
      redirect_to ideas_path
    else
      render :new
    end
  end

  def edit
    @idea = current_user.ideas.find(params[:id])
  end

  def update
    @idea = current_user.ideas.find(params[:id])
    if @idea.update(idea_params)
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to :back
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

end
