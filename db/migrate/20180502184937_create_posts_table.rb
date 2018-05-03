class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.string :content
      t.integer :user_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
