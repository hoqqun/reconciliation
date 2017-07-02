class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :title
      t.text :datas # => array of datas
      t.text :results # => array of results

      t.timestamps null: false
    end
  end
end
