Iota Review
======

Iota descripton from their team: https://assets.ctfassets.net/r1dr6vzfxhev/2t4uxvsIqk0EUau6g2sw0g/45eae33637ca92f85dd9f4a3a218e1ec/iota1_4_3.pdf

This review is applying the techniques from this paper: https://github.com/zack-bitcoin/amoveo/blob/master/docs/other_blockchains/proof_of_stake.md

The pow half of Iota's pow/pos hybrid model is not being used for consensus. It is cheap to get >50% hashpower, but having >50% hashpower wont matter. It is just an anti-spam feature so that the total number of valid messages that a full node would have to consider has some reasonable bounds.

In IOTA there are some rich people who keep spending their money to themselves over and over. This is how their asynchronous PoS algorithm works.

If you control more than 50% of the IOTAs on nodes that are spamming these txs sending money to themselves, then you can push through soft forks to update the consensus rules and take over the network permanently. 

There is no cost to making txs that later get orphaned, so there is no cost to making txs to support the attacker.
So it is very cheap to pay the bribes and take over IOTA.
