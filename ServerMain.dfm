object Form1: TForm1
  Left = 192
  Top = 124
  Width = 870
  Height = 500
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 8
    Top = 32
    object File1: TMenuItem
      Caption = 'File'
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Changeform1: TMenuItem
        Caption = 'Change form'
        OnClick = Changeform1Click
      end
    end
  end
end
