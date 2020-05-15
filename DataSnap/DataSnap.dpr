program DataSnap;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uFInvestigacion in 'uFInvestigacion.pas' {FInvestigacion},
  uMetodosServidor in 'uMetodosServidor.pas' {Investigacion: TDataModule},
  Servidor in 'Servidor.pas' {ServerContainer1: TDataModule},
  ModuloWebInvestigacion in 'ModuloWebInvestigacion.pas' {WebModule1: TWebModule},
  uFErrores in 'uFErrores.pas' {FErrores},
  Teclado in '..\..\..\..\Dropbox\MIS_PROYECTOS\7000_Librerias\Windows\Teclado.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFInvestigacion, FInvestigacion);
  Application.CreateForm(TFErrores, FErrores);
  Application.Run;
end.
