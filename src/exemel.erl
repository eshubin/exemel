-module(exemel).


%% API
-export([]).

-include("exemel_encoding.hrl").

prepare(XML) ->
  #encoding_info{name = Encoding, offset = Offset} = exemel_encoding:detect(XML),
  exemel_conv:convert(string:substr(XML, Offset + 1), Encoding).

-include_lib("eunit/include/eunit.hrl").

prepare_test() ->
  application:start(iconv),
  XML = "<a>122</a>",
  ?assertEqual(XML, prepare(XML)).

