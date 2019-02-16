class Story < ApplicationRecord
  belongs_to :user
  has_many :interactives
  has_many :chapters
  has_many :liked, as: :likeable
  has_and_belongs_to_many :categories
  scope :newest, ->{order created_at: :desc}
  mount_uploader :cover_image, PictureUploader

  def current_user_liked user
    self.interactives.find_by user_id: user.id,
                              interactive_type: Interactive::LIKE
  end

  def count_like
    interactives.type_like.size
  end

  def chapter_newest
    chapters.newest.first
  end

  def category_info
    categories.map(&:name).join ", "
  end

  def progress_info
    progress == Settings.progress_done ? I18n.t("done") : I18n.t("writing")
  end
end
