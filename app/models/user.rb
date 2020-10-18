class User < ApplicationRecord
	has_secure_password
	
	validates_presence_of :nome, :cpf, :agencia, :conta, :saldo, :usuario
	validates_numericality_of :cpf, :agencia, :conta, :saldo, :usuario
	validates_uniqueness_of :cpf, :conta
	validates :cpf, length: { in: 10..11 }
end
