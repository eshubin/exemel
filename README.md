exemel
======

eXeMeL is Erlang library which allows to process XML documents in non-utf8 encodings.

If you get bad_character_code exception when use xmerl

xmerl_scan:string(XMLDoc).

try exemel

xmerl_scan:string(exemel:prepare(XMLDoc)).

It will read xml header, determine the encoding and convert it to utf-8 using iconv.
