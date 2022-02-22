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

BOOLEAN=(true)|(false)
INTEGER=[+-]?\d+
U_FLOAT=\d+(\.\d+)?
FLOAT=[+-]?{U_FLOAT}

INTEGER_RANGE=({INTEGER}\.\.{INTEGER}|{INTEGER}\.\.|\.\.{INTEGER})
U_FLOAT_RANGE=({U_FLOAT}\.\.{U_FLOAT}|{U_FLOAT}\.\.|\.\.{U_FLOAT})
FLOAT_RANGE=({FLOAT}\.\.{FLOAT}|{FLOAT}\.\.|\.\.{FLOAT})
FRACTIONAL={FLOAT}\/{FLOAT}

PLAYER_PSEUDO=[a-zA-Z0-9_]{3,16}
UUID=\d{8}-\d{4}-\d{4}-\d{4}-\d{12}
RESOURCE_LOCATION=(\w+:)?[\w/]+

// ------------------------------------------------------------------
// entity selectors
// ------------------------------------------------------------------

// positional
POSITION_ARGUMENT=[xyz]={FLOAT}
DISTANCE_ARGUMENT=distance={U_FLOAT}|{U_FLOAT_RANGE}
VOLUME_ARGUMENT=d[xyz]={FLOAT}|{FRACTIONAL}

// scoreboard value
SCORE_ARGUMENT=score=\{\w+={INTEGER}|{INTEGER_RANGE}(,\w+={INTEGER}|{INTEGER_RANGE})*\}
TAG_ARGUMENT=tag=\!?\w*
TEAM_ARGUMENT=team=\!?\w*

// traits
SORT_ARGUMENT=sort=(nearest)|(furthest)|(random)|(arbitrary)
LEVEL_ARGUMENT=level={INTEGER}|{INTEGER_RANGE}
GAMEMODE_ARGUMENT=gamemode=\!?(spectator)|(survival)|(creative)|(adventure)
NAME_ARGUMENT=name=\!?\w+
ROTATION_ARGUMENT=[xy]_rotation={FLOAT}|{FLOAT_RANGE}
TYPE_ARGUMENT=type=\!?{RESOURCE_LOCATION}
// TODO write it really
NBT_ARGUMENT=nbt=\{.*\}
ADVANCEMENTS_ARGUMENT=advancements=\{{RESOURCE_LOCATION}={BOOLEAN}|(\{\w+={BOOLEAN}\})\}
PREDICATE_ARGUMENT=predicate=\!?{RESOURCE_LOCATION}

// compound
ENTITY_SELECTOR_ARGUMENT=
    {POSITION_ARGUMENT}|{DISTANCE_ARGUMENT}|{VOLUME_ARGUMENT}|
    {SCORE_ARGUMENT}|{TAG_ARGUMENT}|{TEAM_ARGUMENT}|
    {SORT_ARGUMENT}|{LEVEL_ARGUMENT}|{GAMEMODE_ARGUMENT}|{NAME_ARGUMENT}|{ROTATION_ARGUMENT}|{TYPE_ARGUMENT}|{NBT_ARGUMENT}|{ADVANCEMENTS_ARGUMENT}|{PREDICATE_ARGUMENT}

LIMIT_1_ARGUMENT=limit=1
LIMIT_NOT_1_ARGUMENT=limit=([02-9]|\d\d+)

NO_LIMIT_ENTITY_SELECTOR_ARGUMENT=\[{ENTITY_SELECTOR_ARGUMENT}(,{ENTITY_SELECTOR_ARGUMENT})*\]
LIMIT_1_ENTITY_SELECTOR_ARGUMENT=\[{ENTITY_SELECTOR_ARGUMENT}(,({ENTITY_SELECTOR_ARGUMENT}|{LIMIT_1_ARGUMENT}))*\]
LIMIT_NOT_1_ENTITY_SELECTOR_ARGUMENT=\[{ENTITY_SELECTOR_ARGUMENT}(,({ENTITY_SELECTOR_ARGUMENT}|{LIMIT_NOT_1_ARGUMENT}))*\]

BASE_LIMIT_1_SELECTOR=(@p)|(@r)
BASE_LIMIT_NOT_1_SELECTOR=(@a)|(@e)
FORCED_LIMIT_1_SELECTOR=@s

LIMIT_1_SELECTOR=
    ({BASE_LIMIT_1_SELECTOR}{NO_LIMIT_ENTITY_SELECTOR_ARGUMENT}?)|
    ({BASE_LIMIT_1_SELECTOR}{LIMIT_1_ENTITY_SELECTOR_ARGUMENT}?)|

    ({BASE_LIMIT_NOT_1_SELECTOR}{LIMIT_1_ENTITY_SELECTOR_ARGUMENT}?)|

    ({FORCED_LIMIT_1_SELECTOR}{NO_LIMIT_ENTITY_SELECTOR_ARGUMENT}?)|
    ({FORCED_LIMIT_1_SELECTOR}{LIMIT_1_ENTITY_SELECTOR_ARGUMENT}?)

LIMIT_NOT_1_SELECTOR=
    ({BASE_LIMIT_1_SELECTOR}{LIMIT_NOT_1_ENTITY_SELECTOR_ARGUMENT}?)|
    ({BASE_LIMIT_NOT_1_SELECTOR}{LIMIT_1_ENTITY_SELECTOR_ARGUMENT}?)|
    ({BASE_LIMIT_NOT_1_SELECTOR}{LIMIT_NOT_1_ENTITY_SELECTOR_ARGUMENT}?)

%state COMMAND

%%

<YYINITIAL> {COMMENT}                                       { return McFunctionTypes.COMMENT; }

<YYINITIAL> "tp"|"teleport"                                 { yybegin(COMMAND); return McFunctionTypes.TELEPORT; }
<YYINITIAL> "kill"                                          { yybegin(COMMAND); return McFunctionTypes.KILL; }

<COMMAND> "eyes"|"feet"                                     { return McFunctionTypes.ENTITY_ANCHOR; }
<COMMAND> "entity"                                          { return McFunctionTypes.TOK_ENTITY; }
<COMMAND> "facing"                                          { return McFunctionTypes.TOK_FACING; }

<COMMAND> {FLOAT}{WSPACE}{FLOAT}{WSPACE}{FLOAT}             { return McFunctionTypes.VEC3; }
<COMMAND> \^{FLOAT}?{WSPACE}\^{FLOAT}?{WSPACE}\^{FLOAT}?    { return McFunctionTypes.VEC3; }
<COMMAND> \~{FLOAT}?{WSPACE}\~{FLOAT}?{WSPACE}\~{FLOAT}?    { return McFunctionTypes.VEC3; }
<COMMAND> {FLOAT}                                           { return McFunctionTypes.ROTATION; }

<COMMAND> {LIMIT_NOT_1_SELECTOR}                            { return McFunctionTypes.MULTI_ENTITY; }
<COMMAND> {LIMIT_1_SELECTOR}|{PLAYER_PSEUDO}|{UUID}         { return McFunctionTypes.ENTITY; }

<YYINITIAL> {CRLF}                                          { return McFunctionTypes.CRLF; }
<COMMAND> {CRLF}                                            { yybegin(YYINITIAL); return McFunctionTypes.CRLF; }

{WSPACE}                                                    { return TokenType.WHITE_SPACE; }
[^]                                                         { return TokenType.BAD_CHARACTER; }