  #!/bin/bash


# token of eosio.contracts

contract="db.access"
contract_dir="./build/contracts/db.access"

# export PATH="$HOME/eosio/2.0/bin:$PATH"
ssh -L 8888:127.0.0.1:18888 -C -N sh-misc &

# Deploy the Contract
# When you deploy a contract, it is deployed to an account, and the account becomes the interface for the contract. As mentioned earlier these tutorials use the same public key for all of the accounts to keep things simple.

## unlock wallet
eos.wallet.sh

cleos wallet keys | grep EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

# Create an account for the contract using cleos create account:

cleos create account eosio ${contract} EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV -p eosio@active
# executed transaction: c5630db97e0e732a8298061fe2e7410f095ed82c3ca509744e52cb9d1aebe371  200 bytes  2918 us
# #         eosio <= eosio::newaccount            {"creator":"eosio","name":"eosio.token","owner":{"threshold":1,"keys":[{"key":"EOS6MRyAjQq8ud7hVNYcf...
# warning: transaction executed locally, but may not be confirmed by the network yet         ]

cleos get account ${contract}

# Deploy the compiled wasm to the blockchain with cleos set contract.

# In previous steps you should have created a `contracts` directory and obtained the absolute path and then saved it into a cookie. Replace "CONTRACTS_DIR" in the command below with the absolute path to your `contracts` directory.
cleos set contract ${contract} ${contract_dir} -p ${contract}@active
# Publishing contract...
# executed transaction: c52a069f398507ee1b1117a42a12eff72c293ea29874b18f03ed24cfa3a1fee4  7952 bytes  1381 us
#         eosio <= eosio::setcode               {"account":"eosio.token","vmtype":0,"vmversion":0,"code":"0061736d0100000001a0011b60000060017e006002...
#         eosio <= eosio::setabi                {"account":"eosio.token","abi":"0e656f73696f3a3a6162692f312e310008076163636f756e7400010762616c616e63...
# warning: transaction executed locally, but may not be confirmed by the network yet         ]

cleos get code ${contract}
cleos get abi ${contract}

cleos get transaction c52a069f398507ee1b1117a42a12eff72c293ea29874b18f03ed24cfa3a1fee4


# Execute the Contract
# Great! Now the contract is set. Push an action to it.

## void create( const name&   issuer, const asset&  maximum_supply);
cleos -v push action ${contract} getstats '[]' -p eosio@active
# executed transaction: 868dbefbeaa5775d7f27cd238d38274076a598ee449af86f85c8bb17cb1f7604  96 bytes  127 us
# #     db.access <= db.access::getstats          ""
# warning: transaction executed locally, but may not be confirmed by the network yet         ]

cleos -v get transaction 868dbefbeaa5775d7f27cd238d38274076a598ee449af86f85c8bb17cb1f7604

cleos get actions ${contract}

cleos get scope eosio.token
{
  "rows": [{
      "code": "eosio.token",
      "scope": "........e13oh",
      "table": "stat",
      "payer": "eosio.token",
      "count": 1
    }
  ],
  "more": ""
}

cleos get table eosio.token "........e13oh" stat
