class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.belongs_to :user
      t.string :youtube_id
      t.string :title
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
