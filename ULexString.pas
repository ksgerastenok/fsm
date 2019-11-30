unit
  ULexString;

interface

uses
  ULexCommon;

type
  TLexString = class(TLexCommon)
  protected
    function autoState(const State: Integer; const lex: Char): Integer; override;
    function finalState(const State: Integer): Boolean; override;
    function lexType(const lex: Char): Integer; override;
    function lexDesc(): Integer; override;
  end;

implementation

function TLexString.lexType;
begin
  Result := -1;
  case(UpCase(lex)) of
    '"': Result := 0;
    #10: Result := 1;
    '\': Result := 2;
  end;
end;

function TLexString.autoState;
const
  tabAutoState: array[-1..4] of array[-1..2] of Integer =
  (
   (-1, -1, -1, -1),
   (-1,  1, -1, -1),
   ( 2,  4, -1,  3),
   ( 2,  4, -1,  3),
   ( 2,  2,  2,  2),
   (-1, -1, -1, -1)
  );
begin
  Result := tabAutoState[State][Self.lexType(lex)];
end;

function TLexString.finalState;
const
  tabFinalState: array[-1..4] of Boolean =
  (
   False, False, False, False, False, True
  );
begin
  Result := tabFinalState[State];
end;

function TLexString.lexDesc;
begin
  Result := LEX_STRING;
end;

begin
end.
