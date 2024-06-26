
`dfx deploy`

Em seguida, vamos chamar o canister Subscriber para criar e se inscrever no tópico 'Astronauts'. Você pode fazer isso com o comando:

`dfx canister call sub init '("Astronauts")'`

Agora, você pode publicar um valor para ser associado ao tópico 'Astronauts'. Lembre-se de que o tipo de dado 'value' é definido como tipo Nat, então esse valor deve ser um número.

`dfx canister call pub publish '(record { "topic" = "Astronauts"; "value" = 5 })'`

Para verificar se os dados para 'Astronauts' foram criados e atualizados corretamente, vamos chamar o canister Subscriber e pedir para ele recuperar o 'value' do canister Publisher:

`dfx canister call sub getCount`






