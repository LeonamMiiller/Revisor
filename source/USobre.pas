unit USobre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrSobre = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    memo1: TMemo;
    Memo2: TMemo;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frSobre: TfrSobre;

implementation

{$R *.dfm}

procedure TfrSobre.Button1Click(Sender: TObject);
begin
  frSobre.Close;
end;

end.
