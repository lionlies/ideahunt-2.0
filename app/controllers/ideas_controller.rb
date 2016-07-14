class IdeasController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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

  # def upvote
  #   @idea= Idea.find(params[:id])
  #
  #   if @idea.votes.create(user_id: current_user.id)
  #     flash[:notice] = "Thank you for voting!"
  #     redirect_to :back
  #   else
  #     flash[:notice] =  "You have already voted this!"
  #     redirect_to :back
  #   end
  # end


  def upvote
    @idea= Idea.find(params[:id])

    if @idea.votes.create(user_id: current_user.id)
      flash[:notice] = "Thank you for upvoting!"
      redirect_to :back
    else
      flash[:notice] =  "You have already upvoted this!"
      redirect_to :back
    end
  end

  def cancel_upvote
    @idea = Idea.find(params[:id])
    @vote = @idea.votes(user_id: current_user.id)

    if @vote
      @vote.destroy
      redirect_to :back
    else
      flash[:warning] = "你沒有投過票，無法取消投票喔！"
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
