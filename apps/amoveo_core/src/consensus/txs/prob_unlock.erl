-module(prob_unlock).
-export([make_dict/4, go/4]).
-include("../../records.hrl").
-record(prob_unlock_tx, {to, nonce, fee, from}).
make_dict(To, Amount, Fee, From) ->
    Acc = trees:get(accounts, From),
    #prob_unlock_tx{to = From, nonce = Acc#acc.nonce + 1, from = To, fee = Fee}.
go(Tx, Dict, NewHeight, _) ->
    %verify that the prob account exists, is locked, has been locked long enough, and spend the money to the person it was locked for.
    %take the fee from the person who make this tx.
    %delete the prob_Account

    %Tacc = accounts:dict_update(To, Dict, A, none),
    %Dict2 = prob_accounts:dict_delete(From, Dict),
    %accounts:dict_write(Tacc, Dict).
    Dict.
