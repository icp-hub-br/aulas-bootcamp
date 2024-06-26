Deploy backend:

`dfx deploy memoria_backend`

Parar canister:

`dfx canister stop memoria_backend`

Atualizar o canister:

`dfx build`
`dfx canister install memoria_backend --mode upgrade`

Interagir com o canister:
`dfx canister call memoria_backend nomeDoMetodo`
