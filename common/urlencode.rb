#! /usr/bin/env ruby

# urlencode.ps1
#
# 引数で受け取った文字列を URL エンコードする。
#
# 引数 : URL エンコードしたい文字列

require 'uri'

puts URI.escape(ARGV[0].encode("UTF-8"))

