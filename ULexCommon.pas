unit
  ULexCommon;

interface

const
  LEX_UNKNOWN =  -1;
  LEX_SYMBOL  =   1;
  LEX_ID      =   2;
  LEX_STRING  =   3;
  LEX_FLOAT   =   4;
  LEX_HEX     =   5;
                   
type
  TLexeme = record
    lexReady: Boolean;
    lexType: Integer;
  end;

type
  TLexCommon = class(TObject)
  private
    FState: Integer;
    FLexeme: TLexeme;
    function lexClear(): TLexeme;
    function getLexeme(): TLexeme;
    procedure Reset();
  protected
    function lexDesc(): Integer; virtual; abstract;
    function lexType(const lex: Char): Integer; virtual; abstract;
    function finalState(const State: Integer): Boolean; virtual; abstract;
    function autoState(const State: Integer; const lex: Char): Integer; virtual; abstract;
  public
    constructor Create();
    function Correct(const lex: string): Boolean;
    property Lexeme: TLexeme read getLexeme;
    destructor Destroy();
  end;

type
  TLexClass = class of TLexCommon;

implementation

function TLexCommon.lexClear(): TLexeme;
begin
  Result.lexReady := False;
  Result.lexType := LEX_UNKNOWN;
end;

constructor TLexCommon.Create;
begin
  inherited;
  Self.FState := 0;
  Self.FLexeme := Self.lexClear();
end;

destructor TLexCommon.Destroy;
begin
  Self.FState := 0;
  Self.FLexeme := Self.lexClear();
  inherited;
end;

function TLexCommon.Correct;
var
  i: Integer;
begin
  Self.Reset();
  for i := 1 to Length(lex) do begin
    Self.FState := Self.autoState(Self.FState, lex[i]);
    if((Self.FState = -1) or (Self.FState = 0)) then begin
      Self.FLexeme := Self.lexClear();
    end                                         else begin
      Self.FLexeme.lexType := Self.lexDesc();
      Self.FLexeme.lexReady := Self.finalState(Self.FState);
    end;
  end;
  Result := Self.FLexeme.lexReady;
end;

procedure TLexCommon.Reset;
begin
  Self.FState := 0;
  Self.FLexeme := Self.lexClear();
end;

function TLexCommon.getLexeme;
begin
  Result := Self.FLexeme;
end;

begin
end.
