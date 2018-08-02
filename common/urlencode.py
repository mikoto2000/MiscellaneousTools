#! /usr/bin/env python
# -*- encoding: utf-8 -*-

# urlencode.py
#
# 引数で受け取った文字列を URL エンコードする。
#
# 引数 : URL エンコードしたい文字列

import sys
try:
    import urllib.parse as urlparse
except ImportError:
    import urllib as urlparse


print(urlparse.quote(sys.argv[1]))

