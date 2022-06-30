%%%-------------------------------------------------------------------
%% @doc myapp top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(myapp_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================


init([]) ->

%% sys.config  取得配置数据
  {ok, Pools} = application:get_env(myapp, mysql_poolboy),

  Name = proplists:get_value(name, Pools),
  PoolOptions = proplists:get_value(poolConf, Pools),
  MySqlOptions = proplists:get_value(sqlConf, Pools),


  {ok, {{one_for_one, 5, 10},
    [
      mysql_poolboy:child_spec(pool1, PoolOptions, MySqlOptions)
    ]
  }}.


%%====================================================================
%% Internal functions
%%====================================================================
