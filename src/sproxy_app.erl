-module(sproxy_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-export([start/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    io:format("start application ~p~n", [?MODULE]),
    sproxy_sup:start_link().

stop(_State) ->
    ok.


start() ->
  application:start(?MODULE).