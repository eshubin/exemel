-module(exemel_encoding).

-include("exemel_encoding.hrl").

%% API
-export([detect/2, detect/1]).

detect(_Data, Default) ->
  #encoding_info{name = Default}.

detect(Data) ->
  detect(Data, ?DEFAULT_ENCONDING).


-include_lib("eunit/include/eunit.hrl").
detection_test_() ->
  [
    ?_assertEqual(#encoding_info{name = "utf-8", offset = 0}, detect("", "utf-8")),
    ?_assertEqual(#encoding_info{name = "windows-1251", offset = 34}, detect("<?xml encoding=\"windows-1251\" ?>", "utf-8"))
  ].