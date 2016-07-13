class CreateJoinTableUserLabel < ActiveRecord::Migration
  def change
    create_table :user_labels do |t|
      t.belongs_to :user, index: true
      t.belongs_to :label, index: true
      t.index [:user_id, :label_id], unique: true
      t.index [:label_id, :user_id], unique: true
    end
  end
end
