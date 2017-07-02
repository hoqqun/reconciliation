class AddfromToDatum < ActiveRecord::Migration
  def change
      add_column :data, :from, :string
      add_column :data, :to,   :string
  end
end
