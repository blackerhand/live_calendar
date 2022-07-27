class FreeTimesController < ApplicationController
  before_action :set_partner, only: [:index, :create, :destroy]
  before_action :set_entrepreneur, only: [:reserve]

  # 显示该合伙人所有的空闲时间
  def index
    query_date = Date.parse(params[:query_date]) rescue nil
    render json: { status: 1, message: '请选择日期' } and return if query_date.nil?

    @free_times = @partner.free_times.enabled.where(start_time: query_date.all_day)
    render json: { status: 0, list: @free_times.map { |free_time| { id: free_time.id, start_time: free_time.start_time.strftime('%F %T') } } }
  end

  # --- 合伙人
  # 添加能够会面时间
  def create
    start_time = Time.zone.parse(params[:start_time]) rescue nil
    render json: { status: 1, message: '开始时间不正确' } and return unless start_time.present? && start_time.min % 15 == 0 && start_time.sec == 0
    render json: { status: 1, message: '时间段重复' } and return if @partner.free_times.exists?(start_time: start_time)

    @partner.free_times.create(start_time: start_time, partner: @partner)
    render json: { status: 0, message: '创建成功' }
  end

  # 删除会面时间
  def destroy
    @free_time = @partner.free_times.find_by(id: params[:id])
    render json: { status: 1, message: '时间段不存在' } and return if @free_time.nil?

    @free_time.destroy
    render json: { status: 0, message: '删除成功' }
  end

  # 预定会议
  # 也可以放 meeting_time#create
  def reserve
    @free_time = FreeTime.enabled.find_by(id: params[:id])
    render json: { status: 1, message: '时间段不存在' } and return if @free_time.nil?

    ActiveRecord::Base.transaction do
      MeetingTime.create(free_time: @free_time, entrepreneur: @entrepreneur)
      @free_time.update!(disabled: true)
    end
    render json: { status: 0, message: '预订成功' }
  end

  private

  def set_partner
    @partner = Partner.find_by(id: params[:partner_id])
    render json: { status: 1, message: '合伙人不存在' } if @partner.nil?
  end

  def set_entrepreneur
    @entrepreneur = Entrepreneur.find_by(id: params[:entrepreneur_id])
    render json: { status: 1, message: '创业者不存在' } if @entrepreneur.nil?
  end
end
