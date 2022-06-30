%% coding: utf-8
-module(api_delword).
-compile(export_all).

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.
allowed_methods(Req, State) ->
  {[<<"POST">>], Req, State}.


content_types_accepted(Req, State) ->
  Handlers = [
    {<<"application/x-www-form-urlencoded">>, json_post}, %%web 接口
    {<<"application/json">>, json_post}
  ],
  {Handlers, Req, State}.

json_post(Req, State) ->
io:format("ddddddddddddd~n"),
  {PeerAddr, _Port} = cowboy_req:peer(Req),
  Peer = list_to_binary(inet_parse:ntoa(PeerAddr)),
%%  {ok, A, _} = cowboy_req:read_body(Req, #{length => infinity}),
  {ok, A, _} = cowboy_req:read_body(Req),
%%  A= <<"{\"user_id\": \"myuid_001@123!\", \"nickname\": \"\\u96ea\\u83b2\\u82b1\", \"pwd\": \"123456\", \"email\": \"1055582062@qq.com\", \"department_id\": \"1\"}">>,
  Map = jsx:decode(A, [return_maps]),
%%  #{<<"department_id">> => <<"1">>,<<"email">> => <<"1055582062@qq.com">>, <<"nickname">> => <<233,155,170,232,142,178,232,138,177>>, <<"pwd">> => <<"123456">>,<<"user_id">> => <<"myuid_001@123!">>}
%%  # user_id,nickname,avatar,email,phone,rights,department_id,sign,duty
TableId = maps:get(<<"table_id">>, Map),
  Id = maps:get(<<"id">>, Map),
  
io:format("~p~n",[{TableId,Id}]),

Sql31 = lists:flatten(io_lib:format("delete from  ~s where wordname='~s'", [binary_to_list(TableId),binary_to_list(Id)])),
%  mysql:query(Pid, Sql31),
io:format("~p~n",[Sql31]),
 mysql_poolboy:query(pool1, Sql31),

  VV_VALUE_1="ok",
                  
           

           
  Req1 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<$*>>, Req),

  Req2 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"POST">>, Req1),

  Req3 = cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req2),
  NewReq1 = cowboy_req:set_resp_body(VV_VALUE_1, Req3),
  {true, NewReq1, State}.