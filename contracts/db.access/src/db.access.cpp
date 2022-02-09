#include <db.access.hpp>
#include <eosio.token/eosio.token.hpp>

namespace eosio {

static const name token_contract = "eosio.token"_n;
static const symbol_code MGP = symbol_code("MGP");

void db_access::getstats()
{
    token::stats tbl(token_contract, MGP.raw());
    print("get stats of MGP=", MGP, "\n");
    
    for (auto itr = tbl.begin(); itr != tbl.end(); itr++)
    {
        print("item: ", *itr);
    }
    
}



} /// namespace eosio
