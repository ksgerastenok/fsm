program
  Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ULexHex,
  ULexFloat,
  ULexSymbol,
  ULexString,
  ULexIdentifier,
  ULexCommon;

function Correct(const Auto: TLexCommon; const lex: string): TLexeme;
begin
  Auto.Correct(lex);
  Result := Auto.Lexeme;
end;

var
  A: array[1..5] of TLexCommon;
  S: string;
  Buf: string;
  Res: Boolean;
  Lex: Tlexeme;
  i: Integer;
  j: Integer;
const
  lexName: array[-1..5] of string =
  (
   'LEX_UNKNOWN',
   'LEX_START',
   'LEX_SYMBOL',
   'LEX_ID',
   'LEX_STRING',
   'LEX_FLOAT',
   'LEX_HEX'
  );
begin
  { TODO -oUser -cConsole Main : Insert code here }
  A[1] := TLexSymbol.Create();
  A[2] := TLexIdentifier.Create();
  A[3] := TLexString.Create();
  A[4] := TLexFloat.Create();
  A[5] := TLexHex.Create();
  S := 'void main(int argc, char** argv) { int S; S = 0xFF; printf("%d", S << 3); }';
  Buf := '';
  for j := 1 to Length(S) do begin
    Buf := Buf + S[j];
    Res := True;
    for i := 1 to 5 do begin
      Lex := Correct(A[i], Buf + S[j+1]);
      Res := Res and (Lex.lexType = LEX_UNKNOWN);
    end;
    if(Res) then begin
      for i := 1 to 5 do begin
        Lex := Correct(A[i], Buf);
        if(Lex.lexType <> LEX_UNKNOWN) then begin
          if(Lex.lexReady) then WriteLn(Format('%s - OK', [Buf])) else WriteLn(Format('%s - Error', [Buf]));
        end;
      end;
      Buf := '';
    end;
  end;
  A[1].Destroy();
  A[2].Destroy();
  A[3].Destroy();
  A[4].Destroy();
  A[5].Destroy();
  ReadLn;
end.
