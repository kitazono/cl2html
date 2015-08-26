# rex  cl.rex --stub
# ruby cl.rex.rb  ../test_data/CL_SAMPLE.txt

class ClLexer

inner

  RESERVED = {
    'IF'     => :IF,
    'THEN'   => :THEN,
    'CMD'    => :CMD,
    'COND'   => :COND,
    '%SST'   => :SST
  }

rule

# コメント
                \/\*           { @state = :COMMENT; return }
  :COMMENT      [^\*]+         { return }
  :COMMENT      \*+[^\*\/\n]+  { return }
  :COMMENT      \*\/           { @state = nil; return }

# 継続行
  \+\s+

# 改行
  \n            { [:EOL, [lineno, nil]] }

# 空白
  \s+?

# コメント
#  \/\*(.+)\*\/

# 予約語
  \*CHAR        { [:RESERVED, [lineno, text]] }

# 数値
  \d+           { [:NUMBER, [lineno, text.to_i]] }

# 識別子
  [&%]\w+       { [(RESERVED[text] || :IDENT), [lineno, text]] }
  \w+           { [(RESERVED[text] || :IDENT), [lineno, text]] }

# 文字列
  \'[^']*\'     { [:STRING, [lineno, text]] }

# 記号
  \|\|          { [text, [lineno, text]] }
  .             { [text, [lineno, text]] }

end