class Wiki < ActiveRecord::Base
  belongs_to :user
  #has_and_belongs_to_many :collaborators, join_table: 'users_wikis', foreign_key: :user_id
end