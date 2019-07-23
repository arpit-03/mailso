class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :userid
      t.string :from
      t.text :body

      t.datetime :uploaded_at
    end
  end
end
