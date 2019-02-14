class LikedsController < ApplicationController
    def create
      @story = Story.find_by id: params[:story_id]
      @likeable = @story.liked.new user_id: params[:user_id]
  
      if @likeable.save
        respond_to do |format|
          format.html{redirect_to @story}
          format.js
        end
      else
        redirect_to @story
      end
    end
  
    def destroy
      @story = Story.find_by id: params[:story_id]
      @likeable = @story.liked.find_by user_id: params[:user_id]
  
      if @likeable.destroy
        respond_to do |format|
          format.html{redirect_to @story}
          format.js
        end
      else
        redirect_to @story
      end
    end
  end