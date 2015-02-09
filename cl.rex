#  rex  cl.rex --stub
#  ruby cl.rex.rb  sample.txt

class ClLexer

rule

# 改行
  \n            { [:EOL, nil] }

# 空白
  \s+?

# コメント
  \/\*(.+)\*\/

# 予約語
  \*CHAR        { [:RESERVED, text] }
  ENDPGM        { [:ENDPGM, text] } 
  PGM\s         { [:PGM, text.strip] } 

# 命令
  CALL          { [:COMMAND, text] } 
  CHGDTAARA     { [:COMMAND, text] } 
  CHGVAR        { [:COMMAND, text] } 
  CLROUTQ       { [:COMMAND, text] } 
  CRTDTAARA     { [:COMMAND, text] } 
  DCL           { [:COMMAND, text] }
  DLTDTAARA     { [:COMMAND, text] }
  MONMSG        { [:COMMAND, text] } 
  RGZPFM        { [:COMMAND, text] } 
  RTVJOBA       { [:COMMAND, text] } 
  SBMJOB        { [:COMMAND, text] } 

# パラメータ
  CMD           { [:PARM, text] } 
  CYMDDATE      { [:PARM, text] }
  DTAARA        { [:PARM, text] }
  FILE          { [:PARM, text] } 
  LEN           { [:PARM, text] }
  MSGID         { [:PARM, text] } 
  OUTQ          { [:PARM, text] } 
  SCDTIME       { [:PARM, text] } 
  TYPE          { [:PARM, text] } 
  VALUE         { [:PARM, text] } 
  VAR           { [:PARM, text] } 

# 識別子
  &\w+          { [:IDENT, text] }
  \w+           { [:IDENT, text] }

# 数値
  \d+           { [:NUMBER, text.to_i] }

# 括弧
  .             { [text, text] }

end