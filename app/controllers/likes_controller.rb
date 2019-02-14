class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    return if current_user.interactives.find_by story_id: params[:story_id]
    @story = Story.find_by id: params[:story_id]
    @like = current_user.interactives.build
    @like.story_id = @story.id
    @like.interactive_type = Interactive::LIKE
    
    if @like.save
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to @story
    end
  end

  def destroy
    @story = Story.find_by id: params[:id]
    @interactive = Interactive.find_by story_id: @story.id,
                                       user_id: current_user.id,
                                       interactive_type: Interactive::LIKE
    if @interactive.destroy
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to @story
    end
  end
end
