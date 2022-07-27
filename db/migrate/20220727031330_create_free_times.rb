class CreateFreeTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :free_times do |t|
      t.datetime :start_time, index: true, comment: '会面时间'
      # todo 15 分钟固定，暂不选择结束时间
      t.boolean :disabled, default: false, comment: '是否占用'
      t.bigint :partner_id

      t.index [:start_time, :partner_id], unique: true
      t.timestamps
    end
  end
end
