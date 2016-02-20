class DeleteMapColumn < ActiveRecord::Migration
  def change
    remove_column :scores, :map
    remove_column :world_records, :map
  end
end
