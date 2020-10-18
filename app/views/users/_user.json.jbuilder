json.extract! user, :id, :nome, :cpf, :agencia, :conta, :saldo, :usuario, :created_at, :updated_at
json.url user_url(user, format: :json)
