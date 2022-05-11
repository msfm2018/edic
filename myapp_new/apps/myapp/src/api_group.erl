%% coding: utf-8
-module(api_group).
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
qrcode(Req, State) ->

  P0 = cowboy_req:qs(Req),
    io:format("P0::::~p~n", [P0]),
  Http_decode = http_uri:decode(P0),
  io:format("Http_decode::::~p~n", [Http_decode]),
  try
    Map = jsx:decode(Http_decode, [return_maps]),
    io:format("~p~n", [Map]),

    TableId = maps:get(<<"table_id">>, Map),
    Dy = maps:get(<<"dy">>, Map),
    io:format("~p~n", [{TableId, Dy}]),

    % Sql3 = lists:flatten(io_lib:format("SELECT *  from ~s where dy='~s' ", [TableId, Dy])),
    Sql3 = lists:flatten(io_lib:format("SELECT *  from ~s  ", [TableId])),
%%    io:format("~p~n", [Sql3]),
    try
      {ok, FieldList, DataList} = mysql_poolboy:query(pool1, Sql3),
%%      io:format(":::::::::::~p~n", [{FieldList, DataList}]),
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
io:format("~s~n",[Vv]),
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
%%      io:format("errpr----------------"),
      Vv3 = jsx:encode([
        {<<"code">>, 1}, {<<"msg">>, <<"参数错误"/utf8>>},
        {<<"data">>, ""}
      ]),
      Req13 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<$*>>, Req),

      Req23 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"POST">>, Req13),

      Req33 = cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req23),

      {Vv3, Req33, State}
  end.




