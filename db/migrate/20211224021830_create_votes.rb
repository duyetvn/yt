class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :movie
      t.string :state

      t.timestamps
    end
  end
end
