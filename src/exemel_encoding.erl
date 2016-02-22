-module(exemel_encoding).

-include("exemel_encoding.hrl").

%% API
-export([detect/2, detect/1]).

-define(ENCONING_RE, "^\\<\\?xml.+?encoding=\"([^\"]+)\".*?\\?\\>").

detect(Data, Default) ->
  case re:run(Data, ?ENCONING_RE) of
    nomatch ->
      #encoding_info{name = Default};
    {match, [{0,Offset},{Pos, Length}]} ->
      #encoding_info{name = string:substr(Data, Pos + 1, Length), offset = Offset}
  end.

detect(Data) ->
  detect(Data, ?DEFAULT_ENCONDING).


-include_lib("eunit/include/eunit.hrl").

re_test() ->
  Header = "<?xml encoding=\"windows-1251\" ?>",
  ?assertMatch({match, [{0, 32}, {16, 12}]}, re:run(Header, ?ENCONING_RE)),
  ?assertEqual("windows-1251", string:substr(Header, 17, 12)).

detection_test_() ->
  [
    ?_assertEqual(#encoding_info{name = "utf-8", offset = 0}, detect("", "utf-8")),
    ?_assertEqual(#encoding_info{name = "windows-1251", offset = 32}, detect("<?xml encoding=\"windows-1251\" ?>", "utf-8")),
    ?_assertEqual(#encoding_info{name = "koi8r", offset = 25}, detect("<?xml encoding=\"koi8r\" ?>")),
    ?_assertMatch(#encoding_info{name = "koi8r"}, detect("<?xml version=\"1.0\" encoding=\"koi8r\" ?>")),
    ?_assertMatch(#encoding_info{name = "koi8r"}, detect("<?xml encoding=\"koi8r\" version=\"1.0\"?>"))
  ].
