-module(log_example).
-compile(export_all).
-include("ejabberd_logger.hrl").

start() ->
    ejabberd_loglevel:set(5),
    error_logger:add_report_handler(ejabberd_logger_h, "logfile.log"),
    ?DEBUG("Hello ~p", ["World!"]).

myinfo(MSG)->
	?DEBUG("DEBUG ~p~n",[MSG]),
	?INFO_MSG("INFO_MSG ~p~n",[MSG]),
	?WARNING_MSG("WARNING_MSG ~p~n",[MSG]),
	?ERROR_MSG("ERROR_MSG ~p~n",[MSG]),
	?CRITICAL_MSG("CRITICAL_MSG ~p~n",[MSG]).




myaa(Index)->
ejabberd_loglevel:set(Index).

