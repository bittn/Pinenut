#------------------------------
#|main.rb|
#|PinenutProgrammingLanguage|
#|Main|
#------------------------------
require'pp'

require_relative 'compiler.rb'
require_relative 'runner.rb'
#エラー関数（メッセージをだして，終了）
def error(s=nil)
  if s==nil
    puts"SyntaxError"
  else
    puts s
  end
  exit
end
#ファイルが指定されていなかったら，エラー。
if ARGV.size==0
  error("Nofile!")
end
#ファイルの中身をsrcに読み込む
src=ARGF.read
if src.size==0
  error("")
end
#改行を<br>に置き換え，<br>かスペースでソースコードを区切る
@split_result=src.gsub("\n","<br>").split(/\s|(<br>)/)
#何も入っていない配列を消す
@split_result.delete("")
#debug
#print"#"
#p@split_result
#中間言語にする
@comple_result=Compiler.new(@split_result).run
#debug
#print"#"
#p@comple_result
Runner.new(@comple_result).run(0,@comple_result.size)
