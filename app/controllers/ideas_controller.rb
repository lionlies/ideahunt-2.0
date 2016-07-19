class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @ideas = Idea.order("votes_count desc")
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

  def upvote
    @idea= Idea.find(params[:id])
    @idea.votes.create(user_id: current_user.id)

    if @idea.save
      flash[:notice] = "Thank you for upvoting!"
      redirect_to :back
    else
      flash[:warning] =  "You have already upvoted this!"
      redirect_to :back
    end
  end

  def cancel_upvote
    @idea = Idea.find(params[:id])
    @vote = Vote.find_by(user_id: current_user.id, idea_id: @idea.id)

    if @vote
      @vote.destroy
      flash[:notice] = "You've cancelled your upvote."
      redirect_to :back
    else
      flash[:warning] = "You have no upvotes to cancel."
      redirect_to :back
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
