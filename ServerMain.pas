unit ServerMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Changeform1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Changeform1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses FormEditor;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  //load last form from file if it exists
  if fileexists('kmarstructdata.ksd') then
  begin

    //load lines into

  end;
end;

procedure TForm1.Changeform1Click(Sender: TObject);
begin
  //summon form2
  form2.Visible:=true;
  
end;

end.
