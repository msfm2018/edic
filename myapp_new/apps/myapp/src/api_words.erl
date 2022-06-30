%% coding: utf-8
-module(api_words).
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
%%  #{table_id := TableId, dy := Dy} = cowboy_req:match_qs([table_id, dy], Req),
%%%%  #{lang := Lang} = cowboy_req:match_qs([{lang, [], <<"en-US">>}], Req),
  P0 = cowboy_req:qs(Req),
  Http_decode = http_uri:decode(P0),
  try
    Map = jsx:decode(Http_decode, [return_maps]),

    TableId = maps:get(<<"table_id">>, Map),
    StartId = maps:get(<<"start_id">>, Map),
    Max = maps:get(<<"max">>, Map),

     Sql3 = lists:flatten(io_lib:format("select *  from ~s  order by id desc LIMIT ~p,~p", [TableId,binary_to_integer( StartId),binary_to_integer(Max)])),
    io:format("~p~n", [Sql3]),
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




