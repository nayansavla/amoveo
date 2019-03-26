-module(prob_spend).
-export([go/4, make_dict/5]).
-include("../../records.hrl").
-record(prob_spend_tx, {from, nonce, fee, prob_payment, reveal}).
-record(prob_payment, {from, to, entropy, commit, amount}).
make_dict(ProbPayment, Reveal, Amount, Fee, From) ->
    Acc = trees:get(accounts, From),
    #prob_spend_tx{from = From, nonce = Acc#acc.nonce + 1, fee = Fee, prob_payment = ProbPayment, reveal = Reveal}.

go(Tx, Dict, NewHeight, _) ->
    %verify the reveal is for a valid prob-account and is signed.
    %verify that the commit in the prob_payment matches the reveal.
    %xor the reveal with prob_payment.entropy, and use this randomness with the odds of a payment.
    % r = randomness in range 0, 10^8
    %true = (amount * 10^8 div balance) > r
    From = Tx#prob_spend_tx.from,
    FromAccount = accounts:dict_get(From, Dict),
    SPP = Tx#prob_spend_tx.prob_payment,
    PP = testnet_signed:data(SPP),
    %To = Tx#prob_spend_tx.to,
    To = PP#prob_payment.to,
    %A = FromAccount#prob_acc.balance,
    A = prob_acc:balance(FromAccount),
    Nonce = Tx#prob_spend_tx.nonce,

    %check if the prob-account is already locked. if it is, then delete 90% of the money from it, and check that the fee is equal to 1/10th , send the last 10% to From, who paid the fee equal to this, and delete the prob-account.

    %if prob-account isn't locked, then lock it.

    prob_accounts:dict_lock(From, To, Dict).
