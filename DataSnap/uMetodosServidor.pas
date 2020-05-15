unit uMetodosServidor;

interface

uses System.SysUtils, System.Classes, System.Json,
  Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, uFInvestigacion, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, uFErrores;

type
{$METHODINFO ON}
  TInvestigacion = class(TDataModule)
    Conexion: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FParametros: TStringList;
    FTipo: TStringList;
  public

    procedure escribirMensaje(procedimiento, objetoJson: string);

    procedure limpiarConsulta(Query: TFDQuery);
    procedure SELECT(nombreTabla, OrdenarPor: string; Query: TFDQuery);
    procedure SelectWhere(nombreTabla, Identificador, ID: string;
      Query: TFDQuery);
    procedure SelectWhereOrder(nombreTabla, Identificador, OrdenarPor,
      ID: string; Query: TFDQuery);
    procedure InnerJoin(Tabla1, Tabla2, Parametro, IdBusqueda, Valor: string;
      Query: TFDQuery);
    procedure InnerJoin3(Tabla1, Tabla2, Tabla3, Parametro1, Parametro2,
      IdBusqueda, Valor: string; Query: TFDQuery);
    procedure INSERT(nombreTabla: string; Query: TFDQuery);
    procedure DELETE(nombreTabla, Identificador, ID: string; Query: TFDQuery);
    procedure UPDATE(nombreTabla, Identificador, ID: string; Query: TFDQuery);
    procedure limpiarParametros;
    procedure agregarParametro(Param: string; Tipo: string);
    function crearJSON(Query: TFDQuery): TJSONObject;
    procedure asignarDatos(datos: TJSONObject; Query: TFDQuery);
    function Texto(ss: string): string;
    function JsonRespuesta: string;
    function JsonError: string;

    function AccesoDenegado: string;

    function generarId: string;

    procedure enviarError(hora, fecha, procedimiento, mensaje: string);

    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function updateToken(const datos: TJSONObject): TJSONObject;

    { Rol }
    function updateRol(const token: string; const datos: TJSONObject)
      : TJSONObject;
    function Rol(const ID: string): TJSONObject;
    function Roles: TJSONObject;
    function cancelRol(const token: string; const ID: string): TJSONObject;
    function acceptRol(const token: string; const datos: TJSONObject)
      : TJSONObject;

    { Usuario }
    function updateUsuario(const token: string; const datos: TJSONObject)
      : TJSONObject;
    function Usuario(const ID: string): TJSONObject;
    function Usuarios: TJSONObject;
    function cancelUsuario(const token: string; const ID: string): TJSONObject;
    function acceptUsuario(const token: string; const datos: TJSONObject)
      : TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses System.StrUtils;

{ Método INSERT - Rol }
function TInvestigacion.updateRol(const token: string; const datos: TJSONObject)
  : TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
begin
  try
    Query := TFDQuery.create(nil);
    Query.Connection := Conexion;
    Json := TJSONObject.create;

    if token = FInvestigacion.obtenerToken then
    begin

      limpiarConsulta(Query);

      limpiarParametros;

      agregarParametro('idrol', 'String');
      agregarParametro('rol', 'String');

      INSERT('rol', Query);

      asignarDatos(datos, Query);

      Json.AddPair(JsonRespuesta, 'El rol se creo correctamente');
    end
    else
    begin
      Json.AddPair(JsonRespuesta, AccesoDenegado);
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'updateRol',
        E.Message + datos.toString);
    end;
  end;

  Result := Json;
  escribirMensaje('updateRol', Json.toString);
  Query.Free;
end;

{ Método GET - Rol }
function TInvestigacion.Rol(const ID: string): TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
  i: Integer;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;

    limpiarConsulta(Query);
    SelectWhere('rol', 'idrol', Texto(ID), Query);

    limpiarParametros;
    agregarParametro('idrol', 'String');
    agregarParametro('rol', 'String');

    Json := crearJSON(Query);

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'getRol',
        E.Message + '=>' + ID);
    end;
  end;

  Result := Json;
  escribirMensaje('Rol', Json.toString);
  Query.Free;
end;

{ Método GET-ALL - Rol }
function TInvestigacion.Roles: TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
  ArrayJson: TJSONArray;
  JsonLinea: TJSONObject;
  i: Integer;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;
    ArrayJson := TJSONArray.create;
    Json.AddPair('Roles', ArrayJson);

    limpiarConsulta(Query);
    SELECT('rol', 'rol', Query);

    limpiarParametros;
    agregarParametro('idrol', 'String');
    agregarParametro('rol', 'String');

    for i := 1 to Query.RecordCount do
    begin
      ArrayJson.AddElement(crearJSON(Query));
      Query.Next;
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'getAllRol',
        E.Message + '-no data-');
    end;
  end;

  Result := Json;
  escribirMensaje('Roles', Json.toString);
  Query.Free;
end;

{ Método DELETE - Rol }
function TInvestigacion.cancelRol(const token, ID: string): TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;

    if token = FInvestigacion.obtenerToken then
    begin
      limpiarConsulta(Query);
      DELETE('rol', 'idrol', Texto(ID), Query);

      Json.AddPair(JsonRespuesta, 'El rol se eliminó correctamente');
    end
    else
    begin
      Json.AddPair(JsonRespuesta, AccesoDenegado);
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'deleteRol',
        E.Message + '=> ' + ID);
    end;
  end;

  Result := Json;
  escribirMensaje('cancelRol', Json.toString);
  Query.Free;
end;

{ Método UPDATE - Rol }
function TInvestigacion.acceptRol(const token: string; const datos: TJSONObject)
  : TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
  ID: string;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;

    if token = FInvestigacion.obtenerToken then
    begin
      limpiarConsulta(Query);

      limpiarParametros;

      agregarParametro('idrol', 'String');
      agregarParametro('rol', 'String');

      ID := datos.GetValue('idrol').Value;
      UPDATE('rol', 'idrol', Texto(ID), Query);

      asignarDatos(datos, Query);

      Json.AddPair(JsonRespuesta, 'El rol se actualizó correctamente');
    end
    else
    begin
      Json.AddPair(JsonRespuesta, AccesoDenegado);
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'acceptRol',
        E.Message + datos.toString);
    end;
  end;

  Result := Json;
  escribirMensaje('updateRol', Json.toString);
  Query.Free;
end;

{ Método INSERT - Usuario }
function TInvestigacion.updateUsuario(const token: string;
  const datos: TJSONObject): TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
begin
  try
    Query := TFDQuery.create(nil);
    Query.Connection := Conexion;
    Json := TJSONObject.create;

    if token = FInvestigacion.obtenerToken then
    begin

      limpiarConsulta(Query);

      limpiarParametros;

      agregarParametro('idusuario', 'String');
      agregarParametro('nombre', 'String');
      agregarParametro('correo', 'String');
      agregarParametro('contra', 'String');
      agregarParametro('idrol', 'String');

      INSERT('usuario', Query);

      asignarDatos(datos, Query);

      Json.AddPair(JsonRespuesta, 'El usuario se creo correctamente');
    end
    else
    begin
      Json.AddPair(JsonRespuesta, AccesoDenegado);
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'updateUsuario',
        E.Message + datos.toString);
    end;
  end;

  Result := Json;
  escribirMensaje('updateUsuario', Json.toString);
  Query.Free;
end;

{ Método GET - Usuario }
function TInvestigacion.Usuario(const ID: string): TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
  i: Integer;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;

    limpiarConsulta(Query);
    SelectWhere('usuario', 'idusuario', Texto(ID), Query);

    limpiarParametros;
    agregarParametro('idusuario', 'String');
    agregarParametro('nombre', 'String');
    agregarParametro('correo', 'String');
    agregarParametro('contra', 'String');
    agregarParametro('idrol', 'String');

    Json := crearJSON(Query);

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'getUsuario',
        E.Message + '=>' + ID);
    end;
  end;

  Result := Json;
  escribirMensaje('Usuario', Json.toString);
  Query.Free;
end;

{ Método GET-ALL - Usuario }
function TInvestigacion.Usuarios: TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
  ArrayJson: TJSONArray;
  JsonLinea: TJSONObject;
  i: Integer;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;
    ArrayJson := TJSONArray.create;
    Json.AddPair('Usuarios', ArrayJson);

    limpiarConsulta(Query);
    SELECT('usuario', 'nombre', Query);

    limpiarParametros;
    agregarParametro('idusuario', 'String');
    agregarParametro('nombre', 'String');
    agregarParametro('correo', 'String');
    agregarParametro('contra', 'String');
    agregarParametro('idrol', 'String');

    for i := 1 to Query.RecordCount do
    begin
      ArrayJson.AddElement(crearJSON(Query));
      Query.Next;
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'getAllUsuario',
        E.Message + '-no data-');
    end;
  end;

  Result := Json;
  escribirMensaje('Usuarios', Json.toString);
  Query.Free;
end;

{ Método DELETE - Usuario }
function TInvestigacion.cancelUsuario(const token, ID: string): TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;

    if token = FInvestigacion.obtenerToken then
    begin
      limpiarConsulta(Query);
      DELETE('usuario', 'idusuario', Texto(ID), Query);

      Json.AddPair(JsonRespuesta, 'El usuario se eliminó correctamente');
    end
    else
    begin
      Json.AddPair(JsonRespuesta, AccesoDenegado);
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'deleteUsuario',
        E.Message + '=> ' + ID);
    end;
  end;

  Result := Json;
  escribirMensaje('cancelUsuario', Json.toString);
  Query.Free;
end;

{ Método UPDATE - Usuario }
function TInvestigacion.acceptUsuario(const token: string;
  const datos: TJSONObject): TJSONObject;
var
  Json: TJSONObject;
  Query: TFDQuery;
  ID: string;
begin
  Query := TFDQuery.create(nil);
  Query.Connection := Conexion;
  try
    Json := TJSONObject.create;

    if token = FInvestigacion.obtenerToken then
    begin
      limpiarConsulta(Query);

      limpiarParametros;

      agregarParametro('idusuario', 'String');
      agregarParametro('nombre', 'String');
      agregarParametro('correo', 'String');
      agregarParametro('contra', 'String');
      agregarParametro('idrol', 'String');

      ID := datos.GetValue('idusuario').Value;
      UPDATE('usuario', 'idusuario', Texto(ID), Query);

      asignarDatos(datos, Query);

      Json.AddPair(JsonRespuesta, 'El usuario se actualizó correctamente');
    end
    else
    begin
      Json.AddPair(JsonRespuesta, AccesoDenegado);
    end;

  except
    on E: Exception do
    begin
      Json.AddPair(JsonError, E.Message);
      enviarError(TimeToStr(now), DateToStr(now), 'acceptUsuario',
        E.Message + datos.toString);
    end;
  end;

  Result := Json;
  escribirMensaje('updateUsuario', Json.toString);
  Query.Free;
end;

function TInvestigacion.JsonRespuesta: string;
begin
  Result := 'Respuesta';
end;

function TInvestigacion.JsonError: string;
begin
  Result := 'Error';
end;

procedure TInvestigacion.limpiarConsulta(Query: TFDQuery);
begin
  Query.Close;
  Query.SQL.Clear;
end;

procedure TInvestigacion.SELECT(nombreTabla, OrdenarPor: string;
  Query: TFDQuery);
begin
  Query.SQL.Text := 'SELECT * FROM ' + nombreTabla + ' ORDER BY ' + OrdenarPor;
  Query.Open;
  Query.First;
end;

procedure TInvestigacion.SelectWhere(nombreTabla, Identificador, ID: string;
  Query: TFDQuery);
begin
  Query.SQL.Text := 'SELECT * FROM ' + nombreTabla + ' WHERE ' + Identificador
    + '=' + ID;
  Query.Open;
end;

procedure TInvestigacion.SelectWhereOrder(nombreTabla, Identificador,
  OrdenarPor, ID: string; Query: TFDQuery);
begin
  Query.SQL.Text := 'SELECT * FROM ' + nombreTabla + ' WHERE ' + Identificador +
    '=' + ID + ' ORDER BY ' + OrdenarPor;
  Query.Open;
end;

procedure TInvestigacion.InnerJoin(Tabla1, Tabla2, Parametro, IdBusqueda,
  Valor: string; Query: TFDQuery);
begin
  Query.Close;
  Query.SQL.Text := 'SELECT * FROM ' + Tabla1 + ' INNER JOIN ' + Tabla2 + ' ON '
    + Tabla1 + '.' + Parametro + ' = ' + Tabla2 + '.' + Parametro + ' WHERE ' +
    Tabla2 + '.' + IdBusqueda + '=' + Valor;
  escribirMensaje('InnerJoin', Query.SQL.Text);
  Query.Open;
end;

procedure TInvestigacion.InnerJoin3(Tabla1, Tabla2, Tabla3, Parametro1,
  Parametro2, IdBusqueda, Valor: string; Query: TFDQuery);
begin
  Query.Close;
  Query.SQL.Text := 'SELECT * FROM ' + Tabla1 + ' INNER JOIN ' + Tabla2 + ' ON '
    + Tabla1 + '.' + Parametro1 + ' = ' + Tabla2 + '.' + Parametro1 +
    ' inner join ' + Tabla3 + ' on ' + Tabla1 + '.' + Parametro2 + ' = ' +
    Tabla3 + '.' + Parametro2 + ' WHERE ' + Tabla2 + '.' + IdBusqueda +
    '=' + Valor;
  Query.Open;
end;

procedure TInvestigacion.INSERT(nombreTabla: string; Query: TFDQuery);
var
  i: Integer;
  consulta: string;
begin
  consulta := 'INSERT INTO ' + nombreTabla + '(';

  for i := 1 to FParametros.Count do
  begin
    consulta := consulta + FParametros[i - 1];
    if i < FParametros.Count then
      consulta := consulta + ',';
  end;

  consulta := consulta + ') VALUES (';

  for i := 1 to FParametros.Count do
  begin
    consulta := consulta + ':' + FParametros[i - 1];
    if i < FParametros.Count then
      consulta := consulta + ',';
  end;

  consulta := consulta + ')';

  Query.SQL.Text := consulta;
end;

procedure TInvestigacion.DataModuleCreate(Sender: TObject);
begin
  FParametros := TStringList.create;
  FTipo := TStringList.create;
end;

procedure TInvestigacion.DELETE(nombreTabla, Identificador, ID: string;
  Query: TFDQuery);
begin
  Query.SQL.Text := 'DELETE FROM ' + nombreTabla + ' WHERE ' + Identificador
    + '=' + ID;
  Query.ExecSQL;
end;

procedure TInvestigacion.UPDATE(nombreTabla, Identificador, ID: string;
  Query: TFDQuery);
var
  consulta: string;
  i: Integer;
begin
  consulta := 'UPDATE ' + nombreTabla + ' SET ';

  for i := 1 to FParametros.Count do
  begin
    consulta := consulta + FParametros[i - 1] + '=:' + FParametros[i - 1];
    if i < FParametros.Count then
      consulta := consulta + ', ';
  end;

  consulta := consulta + ' WHERE ' + Identificador + '=' + ID;

  Query.SQL.Text := consulta;
end;

procedure TInvestigacion.limpiarParametros;
begin
  FParametros.Clear;
end;

function TInvestigacion.AccesoDenegado: string;
begin

end;

procedure TInvestigacion.agregarParametro(Param: string; Tipo: string);
begin
  FParametros.Add(Param);
end;

function TInvestigacion.crearJSON(Query: TFDQuery): TJSONObject;
var
  i: Integer;
begin
  Result := TJSONObject.create;

  if Query.RecordCount > 0 then
  begin
    for i := 1 to FParametros.Count do
    begin
      Result.AddPair(FParametros[i - 1], Query.FieldByName(FParametros[i - 1])
        .AsString);
    end
  end
  else
  begin
    Result.AddPair(JsonRespuesta, 'Consulta con resultado vacio');
  end;
end;

procedure TInvestigacion.asignarDatos(datos: TJSONObject; Query: TFDQuery);
var
  i: Integer;
begin
  for i := 1 to FParametros.Count do
  begin
    Query.Params.ParamByName(FParametros[i - 1]).Value :=
      datos.GetValue(FParametros[i - 1]).Value;
  end;
  Query.ExecSQL;
end;

function TInvestigacion.Texto(ss: string): string;
begin
  Result := chr(39) + ss + chr(39);
end;

function TInvestigacion.EchoString(Value: string): string;
begin
  Result := Value;
end;

procedure TInvestigacion.enviarError(hora, fecha, procedimiento,
  mensaje: string);
begin
  FErrores.registrarError(hora, fecha, procedimiento, mensaje);
end;

procedure TInvestigacion.escribirMensaje(procedimiento, objetoJson: string);
begin
  FInvestigacion.escribirMensaje(procedimiento, objetoJson)
end;

function TInvestigacion.generarId: string;
begin
  Result := FInvestigacion.generarId;
end;

function TInvestigacion.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TInvestigacion.updateToken(const datos: TJSONObject): TJSONObject;
var
  i, n, j: Integer;
  nombre, Correo, clave: string;
  token: string;
begin
  try
    nombre := datos.GetValue('nombre').Value;
    Correo := datos.GetValue('correo').Value;
    clave := datos.GetValue('clave').Value;

    if (nombre = 'jprincon') and (Correo = 'jarincon@uniquindio.edu.co') and
      (clave = 'Donmatematicas#512519') then
    begin
      token := FInvestigacion.obtenerToken;
    end
    else
    begin
      token := 'acceso-denegado';
    end;

    Result := TJSONObject.create;
    Result.AddPair('token', token);
  except
    on E: Exception do
    begin
      enviarError(TimeToStr(now), DateToStr(now), 'updateToken',
        E.Message + datos.toString);
    end;
  end;
end;

end.
