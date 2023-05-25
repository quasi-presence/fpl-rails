class CreateUserLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :user_leagues do |t|
      t.references :owner, index: true, references: :users
      t.string :name, null: false
      t.text :image_url
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
