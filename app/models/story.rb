class Story < ApplicationRecord
  before_create :init_liked
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_and_belongs_to_many :categories
  scope :newest, ->{order created_at: :desc}
  mount_uploader :cover_image, PictureUploader

  def init_liked
    self.liked = 0
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
