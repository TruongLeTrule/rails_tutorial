class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display,
                       resize_to_limit: [Settings.img_resize_limit,
Settings.img_resize_limit]
  end

  CREATE_PARAMS = %i(content image).freeze

  scope :newest, ->{order created_at: :desc}
  scope :relate_post, ->(user_ids){where user_id: user_ids}

  validates :user_id, :content, presence: true
  validates :content, length: {maximum: Settings.content_max_length}
  validates :image,
            content_type: {in: Settings.img_accept_format.split(",")},
            size:         {less_than: Settings.max_upload_img_size.megabytes}
end
