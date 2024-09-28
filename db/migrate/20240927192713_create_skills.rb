class CreateSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :skills do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :users, :skills do |t|
      t.index :user_id
      t.index :skill_id
    end
  end
end
