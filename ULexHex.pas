unit
  ULexHex;

interface

uses
  ULexCommon;

type
  TLexHex = class(TLexCommon)
  protected
    function autoState(const State: Integer; const lex: Char): Integer; override;
    function finalState(const State: Integer): Boolean; override;
    function lexType(const lex: Char): Integer; override;
    function lexDesc(): Integer; override;
  end;

implementation

function TLexHex.lexType;
begin
  Result := -1;
  case(UpCase(lex)) of
    '0': Result := 0;
    'X': Result := 1;
    '1'..'9': Result := 2;
    'A'..'F': Result := 2;
  end;
end;

function TLexHex.autoState;
const
  tabAutoState: array[-1..3] of array[-1..2] of Integer =
  (
   (-1, -1, -1, -1),
   (-1,  1, -1, -1),
   (-1, -1,  2, -1),
   (-1,  3, -1,  3),
   (-1,  3, -1,  3)
  );
begin
  Result := tabAutoState[State][Self.lexType(lex)];
end;

function TLexHex.finalState;
const
  tabFinalState: array[-1..3] of Boolean =
  (
   False, False, False, False, True
  );
begin
  Result := tabFinalState[State];
end;

function TLexHex.lexDesc;
begin
  Result := LEX_HEX;
end;

begin
end.
