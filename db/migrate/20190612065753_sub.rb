class Sub < ActiveRecord::Migration[5.2]
  def change
  	create_table :subs do |t|
      t.string :page_name
      t.text :title
      t.text :sh_desc
      t.text :lg_desc
      t.integer :status
      t.text :meta_title
      t.text :meta_property
 end
  end
end
