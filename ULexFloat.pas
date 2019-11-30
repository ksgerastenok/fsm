unit
  ULexFloat;

interface

uses
  ULexCommon;

type
  TLexFloat = class(TLexCommon)
  protected
    function autoState(const State: Integer; const lex: Char): Integer; override;
    function finalState(const State: Integer): Boolean; override;
    function lexType(const lex: Char): Integer; override;
    function lexDesc(): Integer; override;
  end;

implementation

function TLexFloat.lexType;
begin
 Result := -1;
 case(UpCase(lex)) of
  '+', '-': Result := 0;
  '0'..'9': Result := 1;
       '.': Result := 2;
       'E': Result := 3;
 end;
end;

function TLexFloat.autoState;
const
  tabAutoState: array[-1..6] of array[-1..3] of Integer =
  (
   (-1, -1, -1, -1, -1),
   (-1, -1,  1, -1, -1),
   (-1, -1,  1,  2,  4),
   (-1, -1,  3, -1, -1),
   (-1, -1,  3, -1,  4),
   (-1,  5,  6, -1, -1),
   (-1, -1,  6, -1, -1),
   (-1, -1,  6, -1, -1)
  );
begin
  Result := tabAutoState[State][Self.lexType(lex)];
end;

function TLexFloat.finalState;
const
  tabFinalState: array[-1..6] of Boolean =
  (
   False, False, True, False, True, False, False, True
  );
begin
  Result := tabFinalState[State];
end;

function TLexFloat.lexDesc;
begin
  Result := LEX_FLOAT;
end;

begin
end.
