unit uFErrores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Teclado, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef;

type
  TFErrores = class(TForm)
    LvErrores: TListView;
    Query: TFDQuery;
    Conexion: TFDConnection;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LvErroresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    letras: array [1 .. 36] of string;
  public
    procedure leerErrores;

    procedure registrarError(hora, fecha, procedimiento, mensaje: string);

    function generarId: string;
  end;

var
  FErrores: TFErrores;

implementation

{$R *.dfm}

procedure TFErrores.FormCreate(Sender: TObject);
begin
  Height := 768;
  Width := round(1.618 * Height);

  Conexion.Params.Database := ExtractFilePath(ParamStr(0)) +
    'BDErrores/BDErrores.mdb';
  Conexion.Connected := True;

  letras[1] := 'a';
  letras[2] := 'b';
  letras[3] := 'c';
  letras[4] := 'd';
  letras[5] := 'e';
  letras[6] := 'f';
  letras[7] := 'g';
  letras[8] := 'h';
  letras[9] := 'i';
  letras[10] := 'j';
  letras[11] := 'k';
  letras[12] := 'l';
  letras[13] := 'm';
  letras[14] := 'n';
  letras[15] := 'o';
  letras[16] := 'p';
  letras[17] := 'q';
  letras[18] := 'r';
  letras[19] := 's';
  letras[20] := 't';
  letras[21] := 'u';
  letras[22] := 'v';
  letras[23] := 'w';
  letras[24] := 'x';
  letras[25] := 'y';
  letras[26] := 'z';
  letras[27] := '0';
  letras[28] := '1';
  letras[29] := '2';
  letras[30] := '3';
  letras[31] := '4';
  letras[32] := '5';
  letras[33] := '6';
  letras[34] := '7';
  letras[35] := '8';
  letras[36] := '9';
end;

procedure TFErrores.FormShow(Sender: TObject);
begin
  leerErrores;
end;

function TFErrores.generarId: string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to 16 do
  begin
    Result := Result + letras[Random(36)];

    if ((i mod 4) = 0) and (i < 16) then
    begin
      Result := Result + '-';
    end;
  end;
end;

procedure TFErrores.leerErrores;
var
  i: Integer;
begin
  Query.Close;
  Query.SQL.Text := 'SELECT * FROM error';
  Query.Open;

  for i := 1 to Query.RecordCount do
  begin
    with LvErrores.Items.Add.SubItems do
    begin
      Add(IntToStr(i));
      Add(Query.FieldByName('iderror').AsString);
      Add(Query.FieldByName('hora').AsString);
      Add(Query.FieldByName('fecha').AsString);
      Add(Query.FieldByName('procedimiento').AsString);
      Add(Query.FieldByName('mensaje').AsString);
    end;
  end;
end;

procedure TFErrores.LvErroresKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = TECLA_SUPR then
  begin
    Query.Close;
    Query.SQL.Text := 'DELETE FROM error WHERE iderror=' + #39 +
      LvErrores.Selected.SubItems[1] + #13;
    Query.ExecSQL;

    leerErrores;
  end;
end;

procedure TFErrores.registrarError(hora, fecha, procedimiento, mensaje: string);
begin

  Query.Close;
  Query.SQL.Text := 'INERT INTO error (iderror,hora,fecha,procedimiento,' +
    'mensaje) VALUES (:iderror,:hora,:fecha,:procedimiento,:mensaje)';

  Query.Params.ParamByName('iderror').Value := generarId;
  Query.Params.ParamByName('hora').Value := hora;
  Query.Params.ParamByName('fecha').Value := fecha;
  Query.Params.ParamByName('procedimiento').Value := procedimiento;
  Query.Params.ParamByName('mensaje').Value := mensaje;

  Query.ExecSQL;
  Query.Free;
end;

end.
