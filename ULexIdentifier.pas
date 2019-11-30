unit
  ULexIdentifier;

interface

uses
  ULexCommon;

type
  TLexIdentifier = class(TLexCommon)
  protected
    function autoState(const State: Integer; const lex: Char): Integer; override;
    function finalState(const State: Integer): Boolean; override;
    function lexType(const lex: Char): Integer; override;
    function lexDesc(): Integer; override;
  end;

implementation

function TLexIdentifier.lexType;
begin
  Result := -1;
  case(UpCase(lex)) of
    '_': Result := 0;
    'A'..'Z': Result := 0;
    '0'..'9': Result := 1;
  end;
end;

function TLexIdentifier.autoState;
const
  tabAutoState: array[-1..1] of array[-1..1] of Integer =
  (
   (-1, -1, -1),
   (-1,  1, -1),
   (-1,  1,  1)
  );
begin
  Result := tabAutoState[State][Self.lexType(lex)];
end;

function TLexIdentifier.finalState;
const
  tabFinalState: array[-1..1] of Boolean =
  (
   False, False, True
  );
begin
  Result := tabFinalState[State];
end;

function TLexIdentifier.lexDesc;
begin
  Result := LEX_ID;
end;

begin
end.
