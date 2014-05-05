class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations



  #has_and_belongs_to_many :collaborators, join_table: 'users_wikis', foreign_key: :user_id
  def title
    self['title'].titleize if self['title'].present?
  end

  def self.alphabetical
    order("LOWER(title)")
  end
  
  #scope :recent, order("created_at desc")
  def self.recent
    order("created_at desc")
  end

  def self.search(search)
    where('title LIKE ?', "%#{search}%")
  end

  validates :title, length: { maximum: 60 }, presence: true
  validates :description, length: { maximum: 200, minimum: 3 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true
end