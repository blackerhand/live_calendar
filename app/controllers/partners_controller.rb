class PartnersController < ApplicationController
  before_action :set_entrepreneur, only: [:index]

  # 显示所有的合伙人
  def index
    render json: { status: 0, list: Partner.all.map { |partner| partner.slice(:id, :name) } }
  end

  private

  # 这里未做登录, 不使用 current_entrepreneur 通过传入 entrepreneur_id 实现
  def set_entrepreneur
    @entrepreneur = Entrepreneur.find_by(id: params[:entrepreneur_id])
    render json: { status: 1, message: '创业者不存在' } if @entrepreneur.nil?
  end
end
