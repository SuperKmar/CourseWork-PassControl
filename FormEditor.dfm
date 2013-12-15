object Form2: TForm2
  Left = 192
  Top = 124
  Width = 259
  Height = 500
  Caption = 'Form editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 243
    Height = 442
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 192
    Top = 352
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Removeselected1: TMenuItem
      Caption = 'Remove selected'
      OnClick = Removeselected1Click
    end
    object ApplyChanges1: TMenuItem
      Caption = 'Apply Changes'
      OnClick = ApplyChanges1Click
    end
  end
end
