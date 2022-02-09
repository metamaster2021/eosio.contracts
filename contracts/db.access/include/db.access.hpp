#pragma once

#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>

#include <string>


namespace eosio {

   using std::string;

   class [[eosio::contract("db.access")]] db_access : public contract {
      public:
         using contract::contract;

         [[eosio::action]]
         void getstats();
 

   };

}
