eXeMeL
======

eXeMeL is Erlang library which allows to process XML documents in non-utf8 encodings.

If you get bad_character_code exception when use xmerl
```erlang
try
  xmerl_scan:string(XMLDoc)
catch
  exit:{bad_character_code, _, _} ->
    oh_no
end.
```

try exemel
```erlang
xmerl_scan:string(exemel:prepare(XMLDoc)).
```

It will read xml header, determine the encoding and convert it to utf-8 using iconv.

Sample code could be found in exemel/test/xmerl_integration_test.erl.
