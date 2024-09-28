class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :email, index: { unique: true }
      t.integer :age
      t.string :nationality
      t.string :country
      t.string :gender
      t.string :full_name

      t.timestamps
    end
  end
end
