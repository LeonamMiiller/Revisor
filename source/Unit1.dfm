object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Tradu'#231#227'o'
  ClientHeight = 524
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    748
    524)
  PixelsPerInch = 96
  TextHeight = 13
  object edTextoTraduzir: TEdit
    Left = 4
    Top = 4
    Width = 415
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 29
    Width = 739
    Height = 490
    ActivePage = TabSheet4
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Google Translate'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 731
        Height = 462
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reverso'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 0
        Width = 731
        Height = 462
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 88
        ExplicitTop = 136
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C0000008D4B0000C02F00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620F000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'UrbanDictionary'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object WebBrowser2: TWebBrowser
        Left = 0
        Top = 0
        Width = 731
        Height = 462
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 88
        ExplicitTop = 136
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C0000008D4B0000C02F00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620F000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Google Imagens'
      ImageIndex = 3
      object WebBrowser3: TWebBrowser
        Left = 0
        Top = 0
        Width = 731
        Height = 462
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 88
        ExplicitTop = 136
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C0000008D4B0000C02F00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620F000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Bing'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 731
        Height = 462
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Button1: TButton
    Left = 425
    Top = 2
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    Left = 246
    Top = 108
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    OnAfterExecute = RESTRequest1AfterExecute
    SynchronizedEvents = False
    Left = 330
    Top = 108
  end
  object RESTResponse1: TRESTResponse
    Left = 422
    Top = 108
  end
end
