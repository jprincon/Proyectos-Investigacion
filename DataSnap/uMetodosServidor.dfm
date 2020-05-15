object Investigacion: TInvestigacion
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 388
  Width = 413
  object Conexion: TFDConnection
    Params.Strings = (
      'Database=investigacion'
      'User_Name=postgres'
      'Password=postgres'
      'DriverID=PG')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 72
    Top = 40
  end
end
