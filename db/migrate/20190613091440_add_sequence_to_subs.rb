class AddSequenceToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :sequence, :integer
  end
end
