class StoriesController < ApplicationController
  before_action :find_story, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(new create edit update destroy)

  def index
    @categories = Category.all
    @stories = Story.all
    category_id = params[:category_id]
    category = Category.find_by id: category_id
    @stories = category.stories if category
    @stories = @stories.page(params[:page]).per Settings.stories_per_page
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.build story_params

    if @story.save
      flash[:success] = t "add_story_successful"
      redirect_to edit_story_path @story
    else
      flash.now[:danger] = t "add_story_failure"
    end
  end

  def show
    @story = Story.find_by id: params[:id]
    @chapters = @story.chapters
    @liked = @story.liked.find_by user_id: current_user.id if current_user
  end

  def edit
    @chapters = @story.chapters
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @story.update story_params
      flash.now[:success] = t "story_update_successful"
    else
      flash.now[:danger] = t "story_update_failure"
    end
    @chapters = @story.chapters
    respond_to do |format|
      format.html{redirect_to edit_story_path @story}
      format.js
    end
  end

  def destroy
    if @story.destroy
      flash[:success] = t "story_deleted_successful"
      redirect_to root_path
    else
      flash.new[:danger] = t "story_delete_failed"
      render :show
    end
  end

  private

  def story_params
    params.require(:story).permit :name, :author_name,
      :description, :cover_image,
      :progress, category_ids: []
  end

  def find_story
    @story = Story.find_by id: params[:id]

    return if @story
    flash[:danger] = t "story_not_found"
    redirect_to root_path
  end
end
