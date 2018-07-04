class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  default_scope do
    order(created_at: :desc)
  end

  belongs_to :user
end
