class AddMetaToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :meta_content, :text
  end
end
