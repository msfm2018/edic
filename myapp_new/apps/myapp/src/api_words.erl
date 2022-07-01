%% coding: utf-8
-module(api_words).

-compile(export_all).

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.

content_types_provided(Req, State) ->
  {[{<<"application/json">>, qrcode}], Req, State}.

qrcode(Req, State) ->
  %% get è¿æ ·è§£æ
  P0 = cowboy_req:qs(Req),
  Http_decode = http_uri:decode(P0),

  Result =
    try
      Map = jsx:decode(Http_decode, [return_maps]),

      TableId = maps:get(<<"table_id">>, Map),
      StartId = maps:get(<<"start_id">>, Map),
      Max = maps:get(<<"max">>, Map),

      Sql3 =
        lists:flatten(
          io_lib:format("select *  from ~s  order by id desc LIMIT ~p,~p",
                        [TableId, binary_to_integer(StartId), binary_to_integer(Max)])),
      io:format("~p~n", [Sql3]),

      try
        {ok, FieldList, DataList} = mysql_poolboy:query(pool1, Sql3),
        V = case DataList of
              [] ->
                jsx:encode([{<<"code">>, -1}, {<<"msg">>, <<"no data"/utf8>>}, {<<"data">>, []}]);
              _ ->
                [lists:zip(FieldList, D_DATA) || D_DATA <- DataList]
            end,

        jsx:encode([{<<"code">>, 0}, {<<"msg">>, <<"succ"/utf8>>}, {<<"data">>, V}])
      catch
        _:_ ->
          jsx:encode([{<<"code">>, 1}, {<<"msg">>, <<"error"/utf8>>}, {<<"data">>, ""}])
      end
    catch
      _:_ ->
        jsx:encode([{<<"code">>, 1}, {<<"msg">>, <<"error param"/utf8>>}, {<<"data">>, ""}])
    end,
  Req1x = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<$*>>, Req),

  Req2x = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"POST">>, Req1x),

  Req3x =
    cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req2x),
  {Result, Req3x, State}.
