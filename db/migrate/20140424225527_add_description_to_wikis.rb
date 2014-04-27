class AddDescriptionToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :description, :text
  end
end
