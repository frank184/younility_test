class SetDefaultRoleAsDbDefault < ActiveRecord::Migration
  def up
    change_column_default :users, :role, 0
  end

  def down
    change_column_default :users, :role, nil
  end
end
