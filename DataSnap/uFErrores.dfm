object FErrores: TFErrores
  Left = 0
  Top = 0
  Caption = 'FErrores'
  ClientHeight = 770
  ClientWidth = 1079
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object LvErrores: TListView
    Left = 0
    Top = 0
    Width = 1079
    Height = 770
    Align = alClient
    Columns = <
      item
      end
      item
        Caption = 'No'
        Width = 100
      end
      item
        Caption = 'Id Error'
        Width = 200
      end
      item
        Caption = 'Hora'
        Width = 120
      end
      item
        Caption = 'Fecha'
        Width = 120
      end
      item
        Caption = 'Procedimiento'
        Width = 200
      end
      item
        Caption = 'Mensaje'
        Width = 700
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnKeyDown = LvErroresKeyDown
  end
  object Query: TFDQuery
    Connection = Conexion
    Left = 712
    Top = 96
  end
  object Conexion: TFDConnection
    Params.Strings = (
      'DriverID=MSAcc')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 392
    Top = 112
  end
end
