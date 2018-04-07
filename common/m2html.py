# -*- coding: utf8 -*-

u""" m2html.py
pandoc で、 markdown から html に変換する際にリンクを変換するフィルタです。

リンクの拡張子を `md` から `html` に変換します。

Useage:
    pandoc --filter /PATH/TO/m2html.py -f markdown -t html5 --atx-headers test.md -o test.html

Requiments:
    あらかじめ、 pip 等で pandocfilters がインポート可能な状態にしておいてください。

"""

import os
from urlparse import urlparse
from pandocfilters import toJSONFilter, Link

def m2html_filter(key, value, form, meta):
    if key == 'Link':

        org_path = value[2][0]

        scheme, netloc, path, params, query, fragment = urlparse(org_path)
        root, ext = os.path.splitext(path)

        replaced_path = ''
        if not root == "":
            replaced_path = root + ".html"

        value[2][0] = replaced_path + "#" + fragment

        return Link(*value)


if __name__ == "__main__":
    toJSONFilter(m2html_filter)


