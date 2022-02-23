package org.jonatjano.mclang;

import com.intellij.psi.tree.IElementType;
import com.intellij.psi.TokenType;
import com.intellij.lexer.FlexLexer;
import org.jonatjano.mclang.psi.McFunctionTypes;

%%

%class McFunctionLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

CRLF=\R
WSPACE=[ ]
COMMENT="#"[^\r\n]*

INTEGER_ONE=1
INTEGER_NOT_ONE=(1[0-9]+|[02-9][0-9]*)
U_FLOAT=\d+(\.\d+)?
INTEGER=[+-]?\d+
FLOAT=[+-]?{U_FLOAT}

PLAYER_PSEUDO=[a-zA-Z0-9_]{3,16}
UUID=\d{8}-\d{4}-\d{4}-\d{4}-\d{12}
RESOURCE_LOCATION=(\w+:)?[\w/]+

%state COMMAND

%%

<YYINITIAL> {COMMENT} { return McFunctionTypes.COMMENT; }

true|false|0b|1b  { return McFunctionTypes.BOOLEAN; }
{INTEGER_ONE}     { return McFunctionTypes.INTEGER_ONE; }
{INTEGER_NOT_ONE} { return McFunctionTypes.INTEGER_NOT_ONE; }
{INTEGER}         { return McFunctionTypes.INTEGER_SIGNED; }
{U_FLOAT}         { return McFunctionTypes.U_FLOAT_RULE; }
{FLOAT}           { return McFunctionTypes.FLOAT_RULE; }

\[   { return McFunctionTypes.TOK_OPEN_SQUARE; }
\]   { return McFunctionTypes.TOK_CLOSE_SQUARE; }
\{   { return McFunctionTypes.TOK_OPEN_CURLY; }
\}   { return McFunctionTypes.TOK_CLOSE_CURLY; }
=    { return McFunctionTypes.TOK_EQUAL; }
,    { return McFunctionTypes.TOK_COMMA; }
\.\. { return McFunctionTypes.TOK_RANGE; }
\!   { return McFunctionTypes.TOK_NEGATE; }

entity { return McFunctionTypes.TOK_ENTITY; }
facing { return McFunctionTypes.TOK_FACING; }

x|y|z          { return McFunctionTypes.SELECTOR_ARGUMENT_XYZ; }
distance       { return McFunctionTypes.SELECTOR_ARGUMENT_DISTANCE; }
d(x|y|z)       { return McFunctionTypes.SELECTOR_ARGUMENT_DXYZ; }
scores         { return McFunctionTypes.SELECTOR_ARGUMENT_SCORES; }
tag            { return McFunctionTypes.SELECTOR_ARGUMENT_TAG; }
team           { return McFunctionTypes.SELECTOR_ARGUMENT_TEAM; }
limit          { return McFunctionTypes.SELECTOR_ARGUMENT_LIMIT; }
sort           { return McFunctionTypes.SELECTOR_ARGUMENT_SORT; }
level          { return McFunctionTypes.SELECTOR_ARGUMENT_LEVEL; }
gamemode       { return McFunctionTypes.SELECTOR_ARGUMENT_GAMEMODE; }
name           { return McFunctionTypes.SELECTOR_ARGUMENT_NAME; }
(x|y)_rotation { return McFunctionTypes.SELECTOR_ARGUMENT_XY_ROTATION; }
type           { return McFunctionTypes.SELECTOR_ARGUMENT_TYPE; }
nbt            { return McFunctionTypes.SELECTOR_ARGUMENT_NBT; }
advancements   { return McFunctionTypes.SELECTOR_ARGUMENT_ADVANCEMENTS; }
predicate      { return McFunctionTypes.SELECTOR_ARGUMENT_PREDICATE; }

@p { return McFunctionTypes.TOK_AT_P; }
@r { return McFunctionTypes.TOK_AT_R; }
@a { return McFunctionTypes.TOK_AT_A; }
@e { return McFunctionTypes.TOK_AT_E; }
@s { return McFunctionTypes.TOK_AT_S; }

eyes|feet                             { return McFunctionTypes.ENTITY_ANCHOR; }
spectator|survival|creative|adventure { return McFunctionTypes.GAMEMODE_KEYWORDS; }

<YYINITIAL> tp|teleport { yybegin(COMMAND); return McFunctionTypes.COMMAND_TELEPORT; }
<YYINITIAL> kill        { yybegin(COMMAND); return McFunctionTypes.COMMAND_KILL; }

{UUID}              { return McFunctionTypes.UUID; }
{PLAYER_PSEUDO}     { return McFunctionTypes.PLAYER_PSEUDO; }
\w+                 { return McFunctionTypes.WORD_RULE; }
{RESOURCE_LOCATION} { return McFunctionTypes.RESOURCE_LOCATION_RULE; }

{CRLF}   { yybegin(YYINITIAL); return McFunctionTypes.CRLF; }
{WSPACE} { return TokenType.WHITE_SPACE; }
[^]      { return TokenType.BAD_CHARACTER; }