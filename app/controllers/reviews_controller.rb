class ReviewsController < ApplicationController
  before_action :authenticate_user!

      def create
        @idea = Idea.find(params[:idea_id])
        @review = Review.new review_params
        @review.user = current_user
        @review.idea = @idea
        if @review.save
            # AnswerMailer.new_answer(@answer).deliver_later
            redirect_to idea_path(@idea)
        else
          # For the list of reviews
          @reviews = @idea.reviews.order(created_at: :desc)
          render 'ideas/show'
        end
    end

    def destroy
        @idea = Idea.find params[:idea_id]
        @review = Review.find params[:id]
        if can? :crud, @review
          @review.destroy
          redirect_to idea_path(@idea),
          notice: 'Idea Deleted'
        else
          # head will send an empty HTTP response with
          # a particular response code, in this case
          # Unauthorized - 401
          # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
          head :unauthorized
          # redirect_to root_path, alert: 'Not Authorized'
        end
    end


    private

    def review_params
        params.require(:review).permit(:body)
    end

end
