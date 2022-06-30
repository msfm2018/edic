%%   ݿ     
-record(msg,{msgid,toid,fromid,content,un,dt}).
-record(users,{uid,ssid,tm}).
-define(IntervalTimer, 3600).%1h 3600000
-define(delTimer, 5400).%1 h 30 m

-define(UNDEFINED, undefined).