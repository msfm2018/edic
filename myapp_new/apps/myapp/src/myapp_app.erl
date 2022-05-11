%%%-------------------------------------------------------------------
%% @doc myapp public API
%% @end
%%%-------------------------------------------------------------------

-module(myapp_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% APIapi_user_rooms
%%====================================================================
%%面向企业 api
start(_StartType, _StartArgs) ->
  Dispatch = cowboy_router:compile([
    {'_', [

      {"/api_group", api_group, []},                                  %%组
      {"/api_word", api_word, []},                                  %%取得单词
      {"/api_qrcode", api_qrcode, []}                                  %%二维码


    ]}
  ]),
  {ok, _} = cowboy:start_clear(http, [{port, 9011}, {max_connections, infinity}], #{env => #{dispatch => Dispatch}}),


  myapp_sup:start_link().


%%--------------------------------------------------------------------
stop(_State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================
