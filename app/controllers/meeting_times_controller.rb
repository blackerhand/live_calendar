class MeetingTimesController < ApplicationController
  before_action :set_entrepreneur, only: [:index]
  before_action :set_meeting_time, only: [:destroy]

  def index
    @meeting_times = MeetingTime.where(entrepreneur: @entrepreneur)
    render json: { status: 0, list: @meeting_times.map { |meeting_time| { id: meeting_time.id, start_time: meeting_time.free_time.start_time.strftime('%F %T') } } }
  end

  def destroy
    @meeting_time.destroy
    render json: { status: 0, message: '删除成功' }
  end

  private

  def set_entrepreneur
    @entrepreneur = Entrepreneur.find_by(id: params[:entrepreneur_id])
    render json: { status: 1, message: '创业者不存在' } if @entrepreneur.nil?
  end

  def set_meeting_time
    @meeting_time = MeetingTime.find_by(id: params[:entrepreneur_id])
    render json: { status: 1, message: '会议不存在' } if @meeting_time.nil?
  end
end
