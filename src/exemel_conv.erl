-module(exemel_conv).

-export([convert/2]).

-include("exemel_encoding.hrl").

convert(Data, Encoding) ->
  iconv:convert(Encoding, ?DEFAULT_ENCONDING, Data).