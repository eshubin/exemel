-module(exemel).


%% API
-export([prepare/1, start/0]).

-include("exemel_encoding.hrl").


start() ->
  application:start(iconv),
  application:start(exemel).

prepare(XML) ->
  #encoding_info{name = Encoding, offset = Offset} = exemel_encoding:detect(XML),
  exemel_conv:convert(string:substr(XML, Offset + 1), Encoding).

-include_lib("eunit/include/eunit.hrl").

prepare_test_() ->
  {
    setup,
    fun() ->
      start()
    end,
    fun(_) ->
      application:stop(iconv)
    end,
    [
      ?_test(
        begin
          XML = "<a>122</a>",
          ?assertEqual(XML, prepare(XML))
        end
      ),
      ?_test(
        begin
          XML = "<a>122</a>",
          ?assertEqual(XML, prepare("<?xml encoding=\"windows-1251\" ?>"++XML))
        end
      ),
      ?_test(
        begin
          {ok, Data} = file:read_file("../priv/rus.xml"),
          ?assertEqual(binary_to_list(unicode:characters_to_binary("\r\n<Name>Австралийский доллар</Name>\r\n")), prepare(binary_to_list(Data)))
        end
      )
    ]
  }.
