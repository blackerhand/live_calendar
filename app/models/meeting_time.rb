# == Schema Information
#
# Table name: meeting_times
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  entrepreneur_id :bigint
#  free_time_id    :bigint
#
class MeetingTime < ApplicationRecord
  belongs_to :free_time
  belongs_to :entrepreneur
end
