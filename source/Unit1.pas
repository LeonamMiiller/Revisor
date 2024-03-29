﻿unit Unit1;

interface

uses
   Winapi.Windows,
   Winapi.Messages,
   System.SysUtils,
   System.Variants,
   System.Classes,
   Vcl.Graphics,
   Vcl.Controls,
   Vcl.Forms,
   Vcl.Dialogs,
   Vcl.StdCtrls,
   REST.Client,
   REST.Types,
   HTTPApp,
   Data.Bind.Components,
   Data.Bind.ObjectScope,
   Vcl.OleCtrls,
   SHDocVw,
   Vcl.ComCtrls,
   IPPeerClient;

type
   TService = (Google_Translate = 0, Reverso = 1, UrbanDictionary = 2, Bing_Translate = 3);

type
   TForm1 = class(TForm)
    edTextoTraduzir: TEdit;
      PageControl1: TPageControl;
      TabSheet1: TTabSheet;
      TabSheet2: TTabSheet;
      Memo1: TMemo;
      WebBrowser1: TWebBrowser;
      TabSheet3: TTabSheet;
      WebBrowser2: TWebBrowser;
      TabSheet4: TTabSheet;
      WebBrowser3: TWebBrowser;
    TabSheet5: TTabSheet;
    Memo2: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Button1: TButton;
      procedure RESTRequest1AfterExecute(Sender: TCustomRESTRequest);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
      private
         { Private declarations }
      public
         { Public declarations }
   end;

var
   Form1: TForm1;
   Serviço: TService;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  PageControl1Change(Sender);
end;

procedure TForm1.FormCreate(Sender: TObject);
 var SL: TStringList;
     servidor, porta, user, password: string ;
begin
 // Carrega configuracoes de proxy
 SL :=  TStringList.Create;
  try
    if(FileExists('proxy.properties')) then
    Begin
      SL.LoadFromFile('proxy.properties');
      servidor := SL.Values['servidor'];
      porta := SL.Values['porta'];
      user := SL.Values['user'];
      password := SL.Values['password'];
      Form1.RestClient1.ProxyServer := servidor ;
      Form1.RestClient1.ProxyPort := Integer.Parse(porta) ;
      Form1.RestClient1.ProxyUsername := user ;
      Form1.RestClient1.ProxyPassword := password ;
    End;
  finally
//    SL.Free;
  end;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
var textoPesquisar: string ;
begin
 if(PageControl1.ActivePage = TabSheet1) then Begin
   RESTClient1.BaseURL := 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=pt-BR&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=gt&q=' +
      edTextoTraduzir.Text;
   Serviço := Google_Translate;
   RESTRequest1.Execute;
   exit ;
 End;

  if(PageControl1.ActivePage = TabSheet2) then Begin
   textoPesquisar := edTextoTraduzir.Text ;
   textoPesquisar := textoPesquisar.Replace(' ', '_') ;
   RESTClient1.BaseURL := 'https://context.reverso.net/traducao/ingles-portugues/' + HTTPEncode(textoPesquisar);
   //RESTClient1.BaseURL := 'https://context.reverso.net/traducao/ingles-portugues/' + edTextoTraduzir.Text ;
   Serviço := Reverso;
   RESTRequest1.Params.Clear;
   RESTRequest1.ClearBody;
   RESTRequest1.Method := rmGET;
   RESTRequest1.Execute;
   exit ;
 End;

  if(PageControl1.ActivePage = TabSheet3) then Begin
   RESTClient1.BaseURL := 'https://www.urbandictionary.com/define.php?term=' + HTTPEncode(edTextoTraduzir.Text);
   Serviço := UrbanDictionary;
   RESTRequest1.Params.Clear;
   RESTRequest1.ClearBody;
   RESTRequest1.Method := rmGET;
   RESTRequest1.Execute;
   exit ;
 End;

  if(PageControl1.ActivePage = TabSheet4) then Begin
   WebBrowser3.Navigate('https://www.google.com/search?q=' + HTTPEncode(edTextoTraduzir.Text) + '&safe=off&tbm=isch');
   PageControl1.TabIndex := 3;
   exit ;
 End;

 if(PageControl1.ActivePage = TabSheet5) then Begin
   RESTClient1.BaseURL := 'https://www.bing.com/ttranslate';
   Serviço := Bing_Translate;
   RESTRequest1.Params.Clear;
   RESTRequest1.ClearBody;
   RESTRequest1.Method := rmPOST;

   with RESTRequest1.Params.AddItem do
   begin
      name := 'text';
      Value := edTextoTraduzir.Text;
      Kind := pkGETorPOST;
   end;

   with RESTRequest1.Params.AddItem do
   begin
      name := 'from';
      Value := 'en';
      Kind := pkGETorPOST;
   end;

   with RESTRequest1.Params.AddItem do
   begin
      name := 'to';
      Value := 'pt';
      Kind := pkGETorPOST;
   end;

   RESTRequest1.Execute;
 End;



end;

procedure TForm1.RESTRequest1AfterExecute(Sender: TCustomRESTRequest);
var
   I: Integer;
   Source, HTML: TStringList;
   Line: String;
   Doc: Variant;
   OK: Boolean;
   PosA, PosB: Integer;
   StrParte: String;
   Teste: String;
begin
   case Serviço of
      Google_Translate:
         begin
            Memo1.Text := RESTResponse1.Content;
            PageControl1.TabIndex := 0;
         end;
      Reverso:
         begin
            Source := TStringList.Create;
            HTML := TStringList.Create;
            try
               Source.Text := RESTResponse1.Content;
            finally
            end;

            // Montando o HTML para exibir no WebBrowser
            HTML.Add('<!DOCTYPE html><html lang="pt" dir="ltr"><head><style class="font-family">');
            HTML.Add('@font-face{font-family:''contexticons'';src:url(''https://cdn.reverso.net/context/v5801/fonts/contexticons.eot?phzsmg'');src:url(''https://cdn.reverso.net/context/v5801/fonts/contexticons.eot?phzsmg#iefix'') format(''embedded-opentype''),url(''https://cd'
               + 'n.reverso.net/context/v5801/fonts/contexticons.ttf?phzsmg'') format(''truetype''),url(''https://cdn.reverso.net/context/v5801/fonts/contexticons.woff?phzsmg'') format(''woff''),url(''https://cdn.reverso.net/context/v5801/fonts/contexticons.svg?phzsmg#con'
               + 'texticons'') format(''svg'');font-weight: normal;font-style: normal;}</style><link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,700|Roboto+Condensed:300,400&amp;subset=cyrillic,cyrillic-ext,latin-ext" rel="stylesheet">');
            HTML.Add('<link rel="stylesheet" type="text/css" href="https://cdn.reverso.net/context/v5801/css/bst.style.css"></head><body><div class="title-content">');

            I := 0;
            while I < Source.Count - 1 do
            begin
               Line := Trim(Source.Strings[I]);
               Inc(I);
               if Pos('<h1>', Line) > 0 then // Pega o "Tradução de "I love you" em português"
               begin
                  HTML.Add(Line + '</div>');
                  Continue;
               end;

               // Pegando as traduções da expressão
               if Pos('id="translations-content"', Line) > 0 then
               begin
                  while Pos('id="filters-content"', Line) = 0 do
                  begin
                     HTML.Add(Line);
                     Line := Trim(Source.Strings[I]);
                     Inc(I);
                  end;
               end;

               // Pegando as comparações de original/traduzido
               if Pos('id="examples-content"', Line) > 0 then
               begin
                  while Pos('id="blocked-results-banner"', Line) = 0 do
                  begin
                     if Pos('class="options">', Line) > 0 then // Igonora aqueles botões de opções e frescurada...
                     begin
                        repeat
                           if( i >= source.count ) then break ;
                           Line := Source.Strings[I];
                           Inc(I);
                        until Pos('class="mobile-voice icon stopped played">', Line) > 0;
                        Inc(I);
                        if(i < source.count ) then begin
                          Line := Source.Strings[I];
                          HTML.Add('<br>'); // Adiciona um espaço entre cada exemplo de frase traduzida
                        end ;
                        // Inc(I);
                     end;
                     // Retira a sensura por não estar logado no site, retira o link da expressão traduzida e adiciona a cor de fundo
                     HTML.Add(Line.Replace('class="example blocked">', 'class="example">').Replace('<em>', '<span style="background-color: #FFFF00">').Replace('</em>',
                        '</span>').Replace('<a class="link_highlighted" href=', '<a'));
                     if( i >= source.count ) then break ;
                     Line := Source.Strings[I];
                     Inc(I);
                  end;
                  HTML.Add('</section></body></html>');
                  Break;
               end;
            end;
            Source.Free;

            PageControl1.TabIndex := 1;

            if not Assigned(WebBrowser1.Document) then
               WebBrowser1.Navigate('about:blank');
            Doc := WebBrowser1.Document;
            Doc.Clear;
            Doc.Write(HTML.Text);
            Doc.Close;

            HTML.Free;
         end;

      UrbanDictionary:
         begin
            Source := TStringList.Create;
            HTML := TStringList.Create;
            try
               Source.Text := RESTResponse1.Content;
            finally
               //Source.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Urban.html');
            end;

            PageControl1.TabIndex := 2;

            // Montando o cabeçalho do HTML
            HTML.Add('<html lang="en-US"><head><link href="https://d2gatte9o95jao.cloudfront.net/assets/application-4bd4588c60671d7ca9e91a5ea25f331d82a4ad191f55262156a138d1b956ca2e.css" rel="stylesheet" type="text/css"></head><body>');

            I := 0;
            while I < Source.Count - 1 do
            begin
               Line := Trim(Source.Strings[I]);
               if Pos('<div class="def-header"><a class="word"', Line) > 0 then
               begin
                  // Copiando só a parte do HTML onde estão os significados da expressão
                  repeat
                     Inc(I);
                     Line := Line + Trim(Source.Strings[I]);
                  until (Pos('id="columnist">', Source.Strings[I]) > 0);

                  HTML.Add('<div class="def-panel">');
                  HTML.Add('<div class="row">');

                  while Pos('<div class="def-header"><a class="word"', Line) > 0 do
                  begin
                     PosA := Pos('<div class="def-header"><a class="word"', Line);
                     PosB := Pos('</a>', Line, PosA) + 4;
                     StrParte := Copy(Line, PosA, PosB - PosA);
                     // Setando cor do Background e aumentando a fonte do título da expressão
                     StrParte := (Copy(StrParte, 0, Pos('>', StrParte, Pos('name=', StrParte))) + '<span style="background-color: #FFFF00"><font size="6">' + Copy(StrParte,
                        Pos('>', StrParte, Pos('name=', StrParte)) + 1, StrParte.Length).Replace('</a>', '</font></span></a>'));

                     HTML.Add(StrParte);

                     Line := Copy(Line, PosB, Line.Length - PosB);

                     // Pegando a parte do texto com o significado e exemplos de uso
                     PosA := Pos('<div class="meaning">', Line);
                     PosB := Pos('</div>', Line, Pos('<div class="example">', Line));

                     HTML.Add(Copy(Line, PosA, PosB - PosA));

                     Line := Copy(Line, PosB, Line.Length - PosB);

                     HTML.Add('<br><br><br>');

                  end;
                  Break;
               end;
               Inc(I);
            end;

            HTML.Add('</body></html>');

            if not Assigned(WebBrowser2.Document) then
               WebBrowser2.Navigate('about:blank');
            Doc := WebBrowser2.Document;
            Doc.Clear;
            Doc.Write(HTML.Text);
            Doc.Close;

            HTML.Free;
            Source.Free;

         end;

      Bing_Translate:
         begin
            Memo2.Text := RESTResponse1.Content;
            PageControl1.TabIndex := 4;
         end;
   end;
end;

end.
