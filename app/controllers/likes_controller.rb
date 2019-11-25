class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    idea = Idea.find(params[:idea_id])
    like = Like.new(user: current_user, idea: idea)
    if !can?(:like, idea)
      redirect_to idea, alert: "can't like your own idea"
    elsif like.save
      # flash[:success] = "Question Liked"
      redirect_to idea_path(idea)
    else
      # flash[:danger] = like.errors.full_messages.join(", ")
      redirect_to idea_path(idea)
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    if can? :destroy, like
      like.destroy
      # flash[:success] = "Question unliked"
      redirect_to idea_path(like.idea)
    else
      # flash[:danger] = "Can't delete like"
      redirect_to idea_path(like.idea)
    end
  end  
end
