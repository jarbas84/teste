class MoveController < ApplicationController
	before_action :authorize
	def saque
		@valorEmConta = params[:valor_total]
		@valor_saque = params[:saque]
	end
	def saldo
		conn = ActiveRecord::Base.connection
		@id = params[:user_id]
		@saldo = conn.execute "SELECT * FROM users WHERE id = " + @id
		if params[:saldoFinal].present?
			@valorSaque = params[:valor]
			@codigo = params[:codigo]
			conn.execute "UPDATE users SET saldo = " + params[:saldoFinal] +" WHERE id = " + params[:user_id]
			@saldo = conn.execute "SELECT * FROM users WHERE id = " + params[:user_id]
			if @codigo == 'saque'
				conn.execute "INSERT INTO extratos (historico, id_user, created_at, updated_at) VALUES ('Saque de "+ @valorSaque +" Reais. Saldo Atual é de  "+ params[:saldoFinal] +" Reais', " + params[:user_id] + ", '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "', '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "')"
			end
			if @codigo == 'deposito'
				conn.execute "INSERT INTO extratos (historico, id_user, created_at, updated_at) VALUES ('Deposito de "+ @valorSaque +" Reais. Saldo Atual é de  "+ params[:saldoFinal] +" Reais', " + params[:user_id] + ", '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "', '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "')"
			end
		end
	end
	def calculo
		conn = ActiveRecord::Base.connection
		@saldoTotal = conn.execute "SELECT saldo, id FROM users WHERE id = " + params[:post_id]
		@valor_saque = params[:calculo]
	end
	def deposito
		@valorEmConta = params[:valor_total]
	end
	def calculoDeposito
		conn = ActiveRecord::Base.connection
		@saldoTotal = conn.execute "SELECT saldo, id FROM users WHERE id = " + params[:post_id]
		@valor_deposito = params[:calculo]
	end
	def transferencia
		@dados = params[:dados]
		@horaAtual = Time.now.to_s(:time)
	end
	def calculoTransferencia
		conn = ActiveRecord::Base.connection
		if @horaAtual.to_i < 9 or @horaAtual.to_i >18
			@taxa = 7
		else
			@taxa = 5
		end
		@calculoTransferencia = params[:transferencia]
		@user_id = params[:id_usuario]
		@saldo = params[:saldo]
		@conta = conn.execute "SELECT * FROM users WHERE agencia = " + params[:transferencia][:agencia] + " AND conta = " + params[:transferencia][:conta] + " AND id != " + params[:id_usuario]
	end
	def efetuaTransferencia
		conn = ActiveRecord::Base.connection
		@taxa = ''
		@beneficiario = params[:beneficiario]
		@usuario = params[:usuario]
		@valorTransferido = params[:valorTransferido]
		if @horaAtual.to_i < 9 or @horaAtual.to_i >18
			@taxa = 7
		else
			@taxa = 5
		end
		if @valorTransferido.to_i > 1000
			@taxa = @taxa.to_i + 10
		end
		@beneficiarioSaldo = conn.execute "SELECT saldo FROM users WHERE id = " + @beneficiario[0]['id']
		@usuarioSaldo = conn.execute "SELECT saldo FROM users WHERE id = " + @usuario

		@valorSomado = @beneficiarioSaldo[0]['saldo'].to_i + @valorTransferido.to_i
		@valorSubtraido =  @usuarioSaldo[0]['saldo'].to_i - @valorTransferido.to_i - @taxa.to_i

		conn.execute "UPDATE users SET saldo = " + @valorSomado.to_s + " WHERE id = " + @beneficiario[0]['id']
		conn.execute "UPDATE users SET saldo = " + @valorSubtraido.to_s + " WHERE id = " + @usuario
		conn.execute "INSERT INTO extratos (historico, id_user, created_at, updated_at) VALUES ('Transferencia recebida de " + @valorTransferido.to_s + " Reais. Saldo Atual é de  " + @valorSomado.to_s + " Reais', " + @beneficiario[0]['id'] + ", '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "', '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "')"
		conn.execute "INSERT INTO extratos (historico, id_user, created_at, updated_at) VALUES ('Transferencia feita de " + @valorTransferido.to_s + " Reais. Saldo Atual é de  " + @valorSubtraido.to_s + " Reais', " + @usuario + ", '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "', '" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + "')"

	end
end
