%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. 六月 2015 18:03
%%%-------------------------------------------------------------------
-module(lib_id).
-author("Administrator").
-include("common.hrl").
%% API
-export([
  add/1,
  add/2,
  add/3,
  del/1,
  del/2,
  get/1,
  new_type/1,
  new_type/2,
  del_type/1,
  init/0,
  set/2
]).

%% @doc 初始化统计表
init() ->
  catch ets:new(?ID_TABLE, [public, named_table, set, ?ETS_READ_CONCURRENCY, ?ETS_WRITE_CONCURRENCY]),
  ok.

%% @doc 获取对应类型的对应计数
get(Type) ->
  case catch ets:lookup_element(?ID_TABLE, Type, 2) of
    {'EXIT', _} ->
      ?UNDEFINED;
    Val ->
      Val
  end.
%%@doc 设置计数器开始值
set(Type, Start_index) ->
  add(Type, Start_index).

%% @doc 增加计数
add(Type) ->
  add(Type, 1).
add(Type, Num) ->
  case catch ets:update_counter(?ID_TABLE, Type, Num) of
    {'EXIT', {badarg, _}} ->
      new_type(Type, Num),
      Num;
    New_Max_Num when is_integer(New_Max_Num) ->
      New_Max_Num;
    R ->
      io:format("~p~n", [R])
%%      ?ERROR_MSG("new id 失败 reason ~w~n", [R])
  end.
%% @doc 循环加   设置了最大值   超过变为0
add(Type, Num, Max) ->
  case catch ets:update_counter(?ID_TABLE, Type, {2, Num, Max, 0}) of
    {'EXIT', {badarg, _}} ->
      new_type(Type, Num),
      Num;
    New_Max_Num when is_integer(New_Max_Num) ->
      New_Max_Num;
    R ->
      io:format("~p~n", [R])
%%      ?ERROR_MSG("new id 失败 reason ~w~n", [R])
  end.


%% @doc 减少计数
del(Type) ->
  del(Type, 1).
del(Type, Num) when is_integer(Num) ->
  case catch ets:update_counter(?ID_TABLE, Type, -Num) of
    {'EXIT', {badarg, _}} ->
      new_type(Type, -Num),
      -Num;
    New_Max_Num when is_integer(New_Max_Num) ->
      New_Max_Num;
    R ->
      io:format("~p~n", [R])
%%      ?ERROR_MSG("new id 失败 reason ~w~n", [R])
  end.


%% @doc 创建统计类型
new_type(Type) ->
  new_type(Type, 0).
new_type(Type, Num) when is_integer(Num) ->
  ets:insert(?ID_TABLE, {Type, Num}).

del_type(Type) ->
  ets:delete(?ID_TABLE, Type).
