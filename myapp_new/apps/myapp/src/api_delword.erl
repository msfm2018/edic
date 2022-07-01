%% coding: utf-8
-module(api_delword).

-compile(export_all).

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
  {[<<"POST">>], Req, State}.

content_types_accepted(Req, State) ->
  Handlers =
    [{<<"application/x-www-form-urlencoded">>, json_post}, %%web æ¥å£
     {<<"application/json">>, json_post},
     {<<"application/json;charset=utf-8">>, json_post}],                  %%api æ¥å£
  {Handlers, Req, State}.

json_post(Req, State) ->
  %% post解析
  {ok, A, _} = cowboy_req:read_body(Req),
  Map = jsx:decode(A, [return_maps]),
  %
  TableId = maps:get(<<"table_id">>, Map),
  Id = maps:get(<<"id">>, Map),

  Sql31 =
    lists:flatten(
      io_lib:format("delete from  ~s where wordname='~s'",
                    [binary_to_list(TableId), binary_to_list(Id)])),
  io:format("~p~n", [Sql31]),
  VVX =
    try
      mysql_poolboy:query(pool1, Sql31),
      "ok"
    catch
      _:_ ->
        "no"
    end,
  Req11 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<$*>>, Req),

  Req21 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"POST">>, Req11),

  Req31 =
    cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req21),
  NewReq11 = cowboy_req:set_resp_body(VVX, Req31),
  {true, NewReq11, State}.
