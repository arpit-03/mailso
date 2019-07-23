class CreateEmailstatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :emailstatuses do |t|
      t.integer :request_id
      t.string :to
      t.boolean :sent
      t.boolean :delivered
      t.boolean :bounced
      t.boolean :opened
      t.boolean :clicked
      t.datetime :sent_at
      t.datetime :delivered_at
      t.datetime :bounced_at
      t.datetime :opened_at
      t.datetime :clicked_at

    
    end
  end
end
