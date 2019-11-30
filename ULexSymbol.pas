unit
  ULexSymbol;

interface

uses
  ULexCommon;

type
  TLexSymbol = class(TLexCommon)
  protected
    function autoState(const State: Integer; const lex: Char): Integer; override;
    function finalState(const State: Integer): Boolean; override;
    function lexType(const lex: Char): Integer; override;
    function lexDesc(): Integer; override;
  end;

implementation

function TLexSymbol.lexType;
begin
  Result := -1;
  case(UpCase(lex)) of
    '+': Result := 0;
    '-': Result := 1;
    '=': Result := 2;
    '>': Result := 3;
    '<': Result := 4;
    '&': Result := 5;
    '|': Result := 6;
    '*', '/', '%', '!', '^': Result := 7;
    '~', '(', ')', '[', ']', '{': Result := 8;
    '}', ',', '.', ':', '?', ';': Result := 8;
  end;
end;

function TLexSymbol.autoState;
const
  tabAutoState: array[-1..8] of array[-1..8] of Integer =
  (
   (-1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
   (-1,  1,  2,  3,  4,  5,  6,  7,  3,  8),
   (-1,  8, -1,  8, -1, -1, -1, -1, -1, -1),
   (-1, -1,  8,  8, -1, -1, -1, -1, -1, -1),
   (-1, -1, -1,  8, -1, -1, -1, -1, -1, -1),
   (-1, -1, -1,  8,  3, -1, -1, -1, -1, -1),
   (-1, -1, -1,  8, -1,  3, -1, -1, -1, -1),
   (-1, -1, -1,  8, -1, -1,  3, -1, -1, -1),
   (-1, -1, -1,  8, -1, -1, -1,  3, -1, -1),
   (-1, -1, -1, -1, -1, -1, -1, -1, -1, -1)
  );
begin
  Result := tabAutoState[State][Self.lexType(lex)];
end;

function TLexSymbol.finalState;
const
  tabFinalState: array[-1..8] of Boolean =
  (
   False, False, True, True, True, True, True, True, True, True
  );
begin
  Result := tabFinalState[State];
end;

function TLexSymbol.lexDesc;
begin
  Result := LEX_SYMBOL;
end;

begin
end.
