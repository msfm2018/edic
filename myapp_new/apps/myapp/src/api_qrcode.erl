%% coding: utf-8
-module(api_qrcode).
-compile(export_all).
init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.
allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.


content_types_provided(Req, State) ->
  {[

    {<<"application/json">>, qrcode}

  ], Req, State}.


qrcode(Req, State) ->
%%  PrivateKey = uuid:to_string(uuid:uuid1()),


  Sql3 = lists:flatten(io_lib:format("SELECT *  from sd30 where dy=~p ", ['0'])),

  {ok, FieldList, DataList} = mysql_poolboy:query(pool1, Sql3),
  TToken = case DataList of
             [] -> jsx:encode([{<<"code">>, -1},
               {<<"msg">>, <<"查询错误"/utf8>>},
               {<<"data">>, []}
             ]);
             _ ->

               [lists:zip(FieldList, D_DATA) || D_DATA <- DataList]
           end,


  Vv = jsx:encode([
    {<<"code">>, 0}, {<<"msg">>, <<"succ"/utf8>>},
    {<<"data">>, TToken}
  ]),


  Req1 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<$*>>, Req),

  Req2 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"POST">>, Req1),

  Req3 = cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req2),

  {Vv, Req3, State}.

