# -*- coding: utf-8 -*-

# xpath.rb
#
# 指定された XML ファイルを XPath 文字列で検索します。
#
# Example1:
#     xpath.rb --xpath //user test.xml
#
# Example2:
#     xpath.rb --xpath //ns1:user/ns2:id --namespace ns1,uri1 --namespace ns2,uri2 test.xml
#
# Example3:
#     xpath.rb --current /xml/user[1] --xpath ./id test.xml
#
require "optparse"
require "rexml/document"

def parse_option(argv)
  options = {
    :namespaces => {}
  }

  op = OptionParser.new

  op.banner += " XML_FILE"

  op.on("--xpath EVALUATE_XPATH", String, "検索に使用する XPath 文字列"){|v| options[:xpath] = v }
  op.on("--current CURRENT_XPATH", String, "EVALUATE_XPATH の検索を行う際に使用するカレント要素の XPath 文字列"){|v| options[:current] = v }
  op.on("--namespace PREFIX,URI", String, "検索に使用する namespace と uri。カンマ区切りで指定"){|v|
    prefix, uri = v.split(',')
    options[:namespaces][prefix] = uri
  }

  begin
    op.parse!(argv)
  rescue
    STDERR.puts "コマンドライン引数のパースに失敗しました。 Usage を確認してください。"
    STDERR.puts op.to_s
    exit
  end

  # パース失敗なら Usage 出力して終了
  if argv.size == 0
    STDERR.puts "コマンドライン引数のパースに失敗しました。 Usage を確認してください。"
    STDERR.puts op.to_s
    exit
  end

  return options, argv
end


if __FILE__ == $0

  # オプションパース
  opts, argv = parse_option(ARGV)

  # xmL ファイル読み込み
  current_element = REXML::Document.new(File.open(argv[0]))

  # カレントエレメント検索
  if opts[:current]
    current_element =REXML::XPath.match(current_element, opts[:current], opts[:namespaces])
  end

  match_nodes = REXML::XPath.match(current_element, opts[:xpath], opts[:namespaces])

  # マッチしたノードを走査しながらノード情報を出力
  match_nodes.each { |current_node|
    if current_node.parent? and current_node.elements.select {|e| e.node_type == :element }.size > 0 then
      # 子要素のあるノードの場合

      # マッチしたエレメント直下のエレメントを `タグ名:値` のカンマ区切りで列挙
      # 入れ子は値が空になるが、
      # XPath 文字列の確認をする程度であればこれで十分なはず
      children_str = current_node.elements.map { |e|
        "#{e.name}: #{e.text}"
      }.join(", ")

      # 取得したエレメントを出力
      puts "#{current_node.name} : { #{children_str} }"
    else
      # 子要素のないノードの場合

      # 取得したノードの名前と値を出力
      if current_node.node_type == :element then
        puts "#{current_node.name} : { #{current_node.text} }"
      else
        puts "#{current_node.node_type} : { #{current_node.value} }"
      end
    end
  }

end

