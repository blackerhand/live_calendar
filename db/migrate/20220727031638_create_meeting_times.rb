class CreateMeetingTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :meeting_times do |t|
      t.bigint :free_time_id
      t.bigint :entrepreneur_id

      t.timestamps
    end
  end
end
