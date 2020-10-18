class ExtratosController < ApplicationController
  before_action :authorize
  before_action :set_extrato, only: [:show, :edit, :update, :destroy]

  # GET /extratos
  # GET /extratos.json
  def index
    @extrato = params[:dados]
    @extratoId = @extrato[0]['id']
    if !params[:filtro].present?
      @extratos = Extrato.where(id_user:  @extratoId).order('created_at DESC')
    else
      @extratoId = params[:extratoId]
      if params[:filtro]['dInicio'].present?
          @dinicio = params[:filtro]['dInicio']
          @ano = Date.parse( @dinicio).year
          @mes = Date.parse( @dinicio).mon
          @dia = Date.parse( @dinicio).day.to_i - 1
          @dinicio = @ano.to_s+"-"+@mes.to_s+"-"+@dia.to_s
        else
          @dinicio = Time.now - 86400
      end
      if params[:filtro]['dFinal'].present?
          @dfinal = params[:filtro]['dFinal']
        else
          @dfinal = Time.now
      end
        @extratos = Extrato.where('created_at BETWEEN ? AND ?', "#{@dinicio}%", "#{@dfinal}%").where('id_user = ?',  @extratoId).order('created_at DESC')
    end
  end

  
end
