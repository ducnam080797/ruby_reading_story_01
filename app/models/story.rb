class Story < ApplicationRecord
  belongs_to :user
  has_many :chapters
  has_many :liked, as: :likeable
  has_and_belongs_to_many :categories
  scope :newest, ->{order created_at: :desc}
  mount_uploader :cover_image, PictureUploader

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
