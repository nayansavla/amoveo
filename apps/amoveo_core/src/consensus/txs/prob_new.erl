-module(prob_new).
-export([go/4, make_dict/4]).
-record(create_prob_tx, {from, nonce, fee, pubkey, amount}).
-include("../../records.hrl").
make_dict(Pub, Amount, Fee, From) ->
    PS = size(Pub),
    PS = size(From),
    PS = constants:pubkey_size(),
    Account = trees:get(accounts, From),
    #create_prob_tx{from = From,
		   nonce = Account#acc.nonce + 1,
		   pubkey = Pub,
		   amount = Amount,
		   fee = Fee}.
go(Tx, Dict, NewHeight, NonceCheck) ->
    From = Tx#create_acc_tx.from,
    %txs:developer_lock(From, NewHeight, Dict),
    Pub = Tx#create_acc_tx.pubkey,
    Amount = Tx#create_acc_tx.amount,
    true = (Amount > (-1)),
    Nonce = if
		NonceCheck -> Tx#create_acc_tx.nonce;
		true -> none
	    end,
    AccountFee = Tx#create_acc_tx.fee,
    empty = prob_accounts:dict_get(Pub, Dict),
    Account = accounts:dict_update(From, Dict, -Amount - AccountFee, Nonce),
    NewAccount = accounts:new(Pub, Amount),
    Dict2 = accounts:dict_write(Account, Dict),
    prob_accounts:dict_write(NewAccount, Dict2).
