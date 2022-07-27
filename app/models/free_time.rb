# == Schema Information
#
# Table name: free_times
#
#  id         :integer          not null, primary key
#  disabled   :boolean          default(FALSE)
#  start_time :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partner_id :bigint
#
# Indexes
#
#  index_free_times_on_start_time                 (start_time)
#  index_free_times_on_start_time_and_partner_id  (start_time,partner_id) UNIQUE
#
class FreeTime < ApplicationRecord
  scope :enabled, -> { where(disabled: false).order(start_time: :asc) }

  belongs_to :partner
end
