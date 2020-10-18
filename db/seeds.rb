# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(nome: 'gerente 1', cpf: '11111111111', agencia: '111', conta: '111', saldo: 500, usuario: 0, password_digest: 'bbb')
User.create(nome: 'gerente 2', cpf: '22222222222', agencia: '222', conta: '222', saldo: 1100, usuario: 0, password_digest: 'bbb')
User.create(nome: 'correntista 1', cpf: '33333333333', agencia: '333', conta: '333', saldo: 1500, usuario: 1, password_digest: 'bbb')
User.create(nome: 'correntista 2', cpf: '44444444444', agencia: '444', conta: '444', saldo: 2500, usuario: 1, password_digest: 'bbb')
