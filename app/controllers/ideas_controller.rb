class IdeasController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = current_user.ideas.create(idea_params)

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
      redirect_to ideas_path
    else
      render :edit
    end
  end

  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy
    redirect_to ideas_path
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
