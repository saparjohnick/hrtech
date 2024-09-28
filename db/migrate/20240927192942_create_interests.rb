class CreateInterests < ActiveRecord::Migration[7.2]
  def change
    create_table :interests do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :users, :interests do |t|
      t.index :user_id
      t.index :interest_id
    end
  end
end
