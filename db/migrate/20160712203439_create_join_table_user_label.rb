class CreateJoinTableUserLabel < ActiveRecord::Migration
  def change
    create_join_table :users, :labels do |t|
      t.index [:user_id, :label_id], :unique => true
      t.index [:label_id, :user_id], :unique => true
    end
  end
end
