-module(ext_file_handler).

-export([init/3, handle/2, terminate/3]).
%example of talking to this handler:
%httpc:request(post, {"http://127.0.0.1:3011/", [], "application/octet-stream", "echo"}, [], []).
%curl -i -d '[-6,"test"]' http://localhost:3011
handle(Req, _) ->
    {F, _} = cowboy_req:path(Req),
    PrivDir0 = 
	case application:get_env(amoveo_core, kind) of
	    {ok, "production"} ->
		"../../../../_build/prod/lib/light_node/src/js";
	    {ok, "local"} ->
		"../../../../_build/local/lib/light_node/src/js";
	    {ok, "integration"} ->
		"../../../../_build/dev1/lib/light_node/src/js"
	end,
    PrivDir = list_to_binary(PrivDir0),
    true = case F of
	       <<"/peer_scan.html">> -> true;
	       <<"/peer_scan.js">> -> true;
	       <<"/channels_interface.js">> -> true;
	       <<"/channels_lookup.js">> -> true;
	       <<"/governance.js">> -> true;
	       <<"/glossary.js">> -> true;
	       <<"/home.html">> -> true;
	       <<"/txs.html">> -> true;
	       <<"/encryption.html">> -> true;
	       <<"/lookup.html">> -> true;
	       <<"/channel_with_server.html">> -> true;
	       <<"/new_oracle.html">> -> true;
	       <<"/new_oracle.js">> -> true;
	       <<"/oracle_bet.html">> -> true;
	       <<"/oracle_bet.js">> -> true;
	       <<"/oracle_winnings.html">> -> true;
	       <<"/oracle_winnings.js">> -> true;
	       <<"/oracle_close.html">> -> true;
	       <<"/oracle_close.js">> -> true;
	       <<"/messenger.js">> -> true;
	       <<"/otc_finisher.html">> -> true;
	       <<"/otc_finisher_old.html">> -> true;
	       <<"/otc_finisher_old.js">> -> true;
	       <<"/otc_finisher.js">> -> true;
	       <<"/otc_listener.js">> -> true;
	       <<"/otc_listener.html">> -> true;
	       <<"/otc_derivatives.html">> -> true;
	       <<"/otc_derivatives.js">> -> true;
	       <<"/sign_tx.js">> -> true;
               <<"/secrets.js">> -> true;
               <<"/js_loader.js">> -> true;
               <<"/explorer_title.js">> -> true;
               <<"/lightning.js">> -> true;
               <<"/encryption.js">> -> true;
               <<"/encryption_interface.js">> -> true;
               <<"/encryption_library.js">> -> true;
               <<"/encryption.html">> -> true;
               <<"/finance_game.html">> -> true;
               <<"/finance_game.js">> -> true;
               <<"/human_language.js">> -> true;
               <<"/title.js">> -> true;
               <<"/bets.js">> -> true;
               <<"/miner.js">> -> true;
               <<"/chalang.js">> -> true;
               <<"/spk.js">> -> true;
               <<"/format.js">> -> true;
               <<"/files.js">> -> true;
               <<"/rpc.js">> -> true;
               <<"/oracles.js">> -> true;
               <<"/channels.js">> -> true;
               <<"/headers.js">> -> true;
               <<"/server.js">> -> true;
               <<"/codecBytes.js">> -> true;
               <<"/height.js">> -> true;
               <<"/sha256.js">> -> true;
               <<"/combine_cancel_assets.js">> -> true;
               <<"/hexbase64.js">> -> true;
               <<"/signing.js">> -> true;
               <<"/create_account.js">> -> true;
               <<"/delete_account.js">> -> true;
               <<"/keys.js">> -> true;
               <<"/sjcl.js">> -> true;
               <<"/crypto.js">> -> true;
               <<"/lookup_account.js">> -> true;
               <<"/create_account_tx.js">> -> true;
               <<"/delete_account_tx.js">> -> true;
               <<"/spend_tx.js">> -> true;
               <<"/elliptic.min.js">> -> true;
               <<"/lookup_block.js">> -> true;
               <<"/explorer.html">> -> true;
               <<"/lookup_oracle.js">> -> true;
               <<"/total_coins.js">> -> true;
               <<"/favicon.ico">> -> true;
               <<"/market.js">> -> true;
               <<"/unused.js">> -> true;
               <<"/merkle_proofs.js">> -> true;
               <<"/wallet.html">> -> true;
               <<"/BigInteger.js">> -> true;
               <<"/big_int_test.js">> -> true;
               X -> 
                   %io:fwrite("ext file handler block access to: "),
                   %io:fwrite(X),
                   %io:fwrite("\n"),
                   false
           end,
    %File = << PrivDir/binary, <<"/external_web">>/binary, F/binary>>,
    File = << PrivDir/binary, F/binary>>,
    {ok, _Data, _} = cowboy_req:body(Req),
    Headers = [{<<"content-type">>, <<"text/html">>},
    {<<"Access-Control-Allow-Origin">>, <<"*">>}],
    Text = read_file(File),
    {ok, Req2} = cowboy_req:reply(200, Headers, Text, Req),
    {ok, Req2, File}.
read_file(F) ->
    {ok, File } = file:open(F, [read, binary, raw]),
    {ok, O} =file:pread(File, 0, filelib:file_size(F)),
    file:close(File),
    O.
init(_Type, Req, _Opts) -> {ok, Req, []}.
terminate(_Reason, _Req, _State) -> ok.
