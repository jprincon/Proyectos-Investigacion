unit uFInvestigacion;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, uFErrores;

type
  TFInvestigacion = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    MenuPrincipal: TPageControl;
    TabConexion: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ButtonStart: TSpeedButton;
    Label2: TLabel;
    Panel4: TPanel;
    ButtonStop: TSpeedButton;
    Label3: TLabel;
    Panel5: TPanel;
    ButtonOpenBrowser: TSpeedButton;
    Label4: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    EditPort: TEdit;
    LvConsola: TListView;
    TvJson: TTreeView;
    TrayIcon1: TTrayIcon;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    sbVerErrores: TSpeedButton;
    Label1: TLabel;

    procedure FormCreate(Sender: TObject);

    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure sbVerErroresClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    letras: array [1 .. 36] of string;
    tokenServidor: string;

    procedure StartServer;
    { Private declarations }
  public
    function obtenerToken: string;
    procedure generarNuevoToken;
    procedure escribirMensaje(procedimiento, objetoJson: string);

    function generarId: string;
  end;

var
  FInvestigacion: TFInvestigacion;

implementation

{$R *.dfm}

uses
  Winapi.Windows, Winapi.ShellApi, Datasnap.DSSession;

procedure TFInvestigacion.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TFInvestigacion.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFInvestigacion.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TFInvestigacion.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TFInvestigacion.escribirMensaje(procedimiento, objetoJson: string);
begin
  with LvConsola.Items.Add.SubItems do
  begin
    Add(IntToStr(LvConsola.Items.Count));
    Add(DateToStr(now));
    Add(procedimiento);
    Add(objetoJson);
  end;
end;

procedure TFInvestigacion.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);

  Height := 768;
  Width := round(1.618 * Height);

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

  generarNuevoToken;

  TrayIcon1.Visible := True;
end;

procedure TFInvestigacion.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

function TFInvestigacion.obtenerToken: string;
begin
  Result := tokenServidor;
end;

procedure TFInvestigacion.sbVerErroresClick(Sender: TObject);
begin
  ferrores.show;
end;

function TFInvestigacion.generarId: string;
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

procedure TFInvestigacion.generarNuevoToken;
var
  token: string;
  i, n: Integer;
begin
  token := '';
  for i := 1 to 32 do
  begin
    n := round(Random(36)) + 1;
    token := token + letras[n];
  end;

  tokenServidor := token;
end;

end.
