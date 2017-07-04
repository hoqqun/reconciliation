class AdduserIdToData < ActiveRecord::Migration
  def change
    add_column :data, :user_id, :integer
  end
end
