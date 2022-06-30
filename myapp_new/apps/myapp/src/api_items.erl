%% coding: utf-8
-module(api_items).
-compile(export_all).
init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.
allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.


content_types_provided(Req, State) ->
  {[

    {<<"application/json">>, qrcode}

  ], Req, State}.

%%http://127.0.0.1:9011/api_wendu?table_id=1&dy=0
%% select * from cg1 GROUP BY id desc LIMIT 5,4
qrcode(Req, State) ->

  P0 = cowboy_req:qs(Req),
  Uri_string = http_uri:decode(P0),
  try
    Map = jsx:decode(Uri_string, [return_maps]),

    TableId = maps:get(<<"table_id">>, Map),


    Sql3 = lists:flatten(io_lib:format("select *  from ~s ", [TableId])),
    io:format("~p~n",[Sql3]),
    try
      {ok, FieldList, DataList} = mysql_poolboy:query(pool1, Sql3),
      TToken = case DataList of
                 [] -> jsx:encode([{<<"code">>, -1},
                   {<<"msg">>, <<"没有数据"/utf8>>},
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
      {Vv, Req3, State}
    catch
      _:_ ->
        Vv2 = jsx:encode([
          {<<"code">>, 1}, {<<"msg">>, <<"查询错误"/utf8>>},
          {<<"data">>, ""}
        ]),
        Req12 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<$*>>, Req),

        Req22 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"POST">>, Req12),

        Req32 = cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req22),

        {Vv2, Req32, State}
    end


  catch
    _:_ ->
      Vv3 = jsx:encode([
        {<<"code">>, 1}, {<<"msg">>, <<"参数错误"/utf8>>},
        {<<"data">>, ""}
      ]),
      Req13 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<$*>>, Req),

      Req23 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"POST">>, Req13),

      Req33 = cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req23),

      {Vv3, Req33, State}
  end.




