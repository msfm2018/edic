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

      {"/api_items", api_items, []},                                  %%组
      {"/api_words", api_words, []} ,                                 %%取得单词
      {"/api_delword", api_delword, []}                                  %%删除单词


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
