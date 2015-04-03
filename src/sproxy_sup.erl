-module(sproxy_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
  RestartStrategy = one_for_one,
  MaxRestarts = 1000,
  MaxSecondsBetweenRestarts = 3600,

  SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

  Restart = permanent,
  Shutdown = 2000,
  Type = worker,

  ListenSup = {tcp_listener_sup, {tcp_listener_sup, start_link, []},
    Restart, Shutdown, Type, [tcp_listener_sup]},
  AccepSup = {tcp_acceptor_sup, {tcp_acceptor_sup, start_link, []},
    Restart, Shutdown, Type, [tcp_acceptor_sup]},

  {ok, {SupFlags, [ListenSup, AccepSup]}}.