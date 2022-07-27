class CreateEntrepreneurs < ActiveRecord::Migration[6.1]
  def change
    create_table :entrepreneurs do |t|
      t.string :name, comment: '姓名'

      t.timestamps
    end
  end
end
