%%���ݿ�����
-record(msg,{msgid,toid,fromid,content,un,dt}).
-record(users,{uid,ssid,tm}).
-define(IntervalTimer, 3600).%1h 3600000
-define(delTimer, 5400).%1 h 30 m
-define(redis,Redis).



-define(UNDEFINED, undefined).
%%%-----------------------------------------
%%%  ｅｔｓ表
%%%-----------------------------------------
%% ｉｄ表
-define(ID_TABLE, id_table).

%% 房间索引
-define(RoomIdIndex,room_id_index).

%%-define(ETS_READ_CONCURRENCY, {read_concurrency, true}).
-define(ETS_READ_CONCURRENCY, {read_concurrency, false}).
%%-define(ETS_WRITE_CONCURRENCY, {write_concurrency, true}).
-define(ETS_WRITE_CONCURRENCY, {write_concurrency, false}).