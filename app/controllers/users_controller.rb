class UsersController < ApplicationController
  before_action :authorize
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :conn, only: [:calculo, :calculoDeposito, :calculoTransferencia, :efetuaTransferencia]

  # GET /users
  # GET /users.json
  def index
    @users = User.find(@current_user.id)   
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if user_path(@user) != user_path(@current_user.id)
      redirect_to root_path
    end
  end

  # GET /users/new
  def new
    if @current_user.usuario == 0
    @user = User.new
    else
      redirect_to root_path
    end
  end

  # GET /users/1/edit
  def edit
    if @current_user.usuario == 0
    else
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#===========================================================================================
  def saque
    @valorEmConta = User.find(@current_user.id)
    @valor_saque = params[:saque]
  end
  
  def saldo
    @id = @current_user.id
    if params[:saldoFinal].present?     
      @saldoFinal = params[:saldoFinal]
      @codigo = params[:codigo]
      if @codigo == 'saque'
        @valorSaque = params[:valor]

        User.update(@id, saldo: @saldoFinal)

        saque = Extrato.new
        string_historico = "Saque de #{@valorSaque} Reais. Saldo Atual é de #{@saldoFinal} Reais"
        saque.historico = string_historico
        saque.id_user = @id
        saque.created_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        saque.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        saque.save
        
      end
      if @codigo == 'deposito'
        
        @valorDeposito = params[:valor]

        User.update(@id, saldo: @saldoFinal)

        deposito = Extrato.new
        string_historico = "Deposito de #{@valorSaque} Reais. Saldo Atual é de #{@saldoFinal} Reais"
        deposito.historico = string_historico
        deposito.id_user = @id
        deposito.created_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        deposito.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        deposito.save 
      end
    end
    
    @saldo = User.find(@id)

  end

  def calculo
    @saldoTotal = @current_user
    @valor_saque = params[:calculo]
  end
  def deposito
    @valorEmConta = User.find(@current_user.id)
  end
  def calculoDeposito
    @saldoTotal = @current_user
    @valor_deposito = params[:calculo]
  end
  def transferencia
    @dados = @current_user
    @horaAtual = Time.now.to_s(:time)
  end
  
  def calculoTransferencia
    if @horaAtual.to_i < 9 or @horaAtual.to_i >18
      @taxa = 5
    else
      @taxa = 7
    end
    @user_id = @current_user.id
    @contaBeneficiario = params[:transferencia]
    @saldo = params[:saldo]
    @saldoDisponivel = User.find(@user_id)
    @conta = User.where("agencia = ? AND conta = ? AND id != ?" , @contaBeneficiario['agencia'], @contaBeneficiario['conta'], @user_id)
  end
  
  def efetuaTransferencia
    @id_usuario = @current_user.id
    @id_beneficiario = params[:beneficiario]
    @valorTransferido = params[:valorTransferido]
    if @horaAtual.to_i < 9 or @horaAtual.to_i >18
      @taxa = 5
    else
      @taxa = 7
    end
    if @valorTransferido.to_i > 1000
      @taxa = @taxa.to_i + 10
    end

    @beneficiarioDados = User.find(@id_beneficiario)
    @usuarioSaldo = User.find(@id_usuario)

    @valorSomado = @beneficiarioDados['saldo'].to_i + @valorTransferido.to_i
    @valorSubtraido = @usuarioSaldo['saldo'].to_i - @valorTransferido.to_i - @taxa.to_i

    User.update(@id_beneficiario, saldo: @valorSomado)
    User.update(@id_usuario, saldo: @valorSubtraido)

        transferencia_beneficiario = Extrato.new
        string_historico = "Transferência de #{@valorTransferido} Reais. Saldo Atual é de #{@valorSubtraido} Reais"
        transferencia_beneficiario.historico = string_historico
        transferencia_beneficiario.id_user = @id_beneficiario
        transferencia_beneficiario.created_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        transferencia_beneficiario.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        transferencia_beneficiario.save

        transferencia_usuario = Extrato.new
        string_historico = "Transferência de #{@valorTransferido} Reais + taxas de #{@taxa} Reais. Saldo Atual é de #{@valorSubtraido} Reais"
        transferencia_usuario.historico = string_historico
        transferencia_usuario.id_user = @id_usuario
        transferencia_usuario.created_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        transferencia_usuario.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        transferencia_usuario.save
    

  end
  def clientes
    @usuario = params[:usuario]
    @clientes = User.where('usuario = ?', @usuario)
      

  end
#===========================================================================================
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def conn
      conn = ActiveRecord::Base.connection
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:nome, :cpf, :agencia, :conta, :saldo, :usuario, :password, :password_confirmation)
    end
end
