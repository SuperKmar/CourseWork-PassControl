object Form3: TForm3
  Left = 436
  Top = 141
  BorderStyle = bsDialog
  Caption = 'Field wizard'
  ClientHeight = 370
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 155
    Height = 13
    Caption = 'Field name (example: Full Name)'
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 51
    Height = 13
    Caption = 'Field type:'
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 217
    Height = 13
    Caption = 'Automatic Filters (lEmpty filters are not used)'
  end
  object Edit1: TEdit
    Left = 168
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'New Field'
  end
  object ComboBox1: TComboBox
    Left = 168
    Top = 64
    Width = 121
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Default'
    Items.Strings = (
      'Default'
      'Integer'
      'Float'
      'String')
  end
  object Edit2: TEdit
    Left = 160
    Top = 112
    Width = 129
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
    Visible = False
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 112
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Text = 'ComboBox2'
    Visible = False
    Items.Strings = (
      'Test Item')
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 281
    Height = 25
    Caption = 'Add'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 256
    Top = 88
  end
end
