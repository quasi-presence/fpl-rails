class AddUserImageUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :image_url, :text
  end
end
