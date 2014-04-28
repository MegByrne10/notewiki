class Wiki < ActiveRecord::Base
  belongs_to :user
  #has_and_belongs_to_many :collaborators, join_table: 'users_wikis', foreign_key: :user_id

  validates :title, length: { maximum: 60 }, presence: true
  validates :description, length: { maximum: 200, minimum: 3 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true
end