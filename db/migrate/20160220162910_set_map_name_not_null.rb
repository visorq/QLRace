class SetMapNameNotNull < ActiveRecord::Migration
  def change
    change_column_null :maps, :name, false
  end
end
