class SessionsController < ApplicationController
  def new
    if user_signed_in?
        redirect_to user_path(@current_user)
      end
  end
  def create
      user = User.find_by(cpf: params[:sessions][:cpf])
  	if user.present? && user.authenticate(params[:sessions][:password])
  		sign_in(user)
  		  redirect_to user_path(user)
  	else
  		flash.now[:danger] = "CPF ou Senha inválidos"
  		render 'new'
  	end
  end
  def destroy
  	sign_out
  	flash[:success] = "Sessao Encerrada!"
  	redirect_to entrar_path
  end

end
