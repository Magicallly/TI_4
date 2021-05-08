object fMain: TfMain
  Left = 269
  Top = 138
  Width = 1090
  Height = 600
  Caption = 'Cipher2'
  Color = clBtnHighlight
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 1090
  Constraints.MinHeight = 600
  Constraints.MinWidth = 1090
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbEnterKey: TLabel
    Left = 368
    Top = 16
    Width = 39
    Height = 30
    Caption = 'Key'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Papyrus'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object mmPlaintext: TMemo
    Left = 0
    Top = 88
    Width = 358
    Height = 473
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object mmKey: TMemo
    Left = 359
    Top = 88
    Width = 356
    Height = 473
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object mmCiphertext: TMemo
    Left = 716
    Top = 88
    Width = 358
    Height = 473
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object btnLoadFile: TButton
    Left = 16
    Top = 16
    Width = 153
    Height = 57
    Caption = 'Load File'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Papyrus'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnLoadFileClick
  end
  object btnEncryption: TButton
    Left = 184
    Top = 16
    Width = 153
    Height = 57
    Caption = 'Encrypt'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Papyrus'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnEncryptionClick
  end
  object btnSaveFile: TButton
    Left = 904
    Top = 16
    Width = 153
    Height = 57
    Caption = 'Save File'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Papyrus'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btnSaveFileClick
  end
  object btnDecryption: TButton
    Left = 736
    Top = 16
    Width = 153
    Height = 57
    Caption = 'Decrypt'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Papyrus'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    Visible = False
  end
  object edKey: TEdit
    Left = 368
    Top = 48
    Width = 337
    Height = 21
    Hint = 'Please, enter only 30 symbols'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
  end
  object OpenDialog1: TOpenDialog
    Left = 656
  end
  object SaveDialog1: TSaveDialog
    Left = 704
    Top = 16
  end
end
