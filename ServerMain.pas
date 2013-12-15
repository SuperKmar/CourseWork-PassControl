unit ServerMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, KmarDataStructure;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Changeform1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Changeform1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure recive(NewStruct:TFormStructure);
  private
    { Private declarations }
  public
    { Public declarations }
    
  end;

var
  Form1: TForm1;

implementation

uses FormEditor;

var
  FormStructure: TFormStructure;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  //p:=Formstructure;
  FormStructure:=TFormStructure.Create;


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
  form2.Summon(FormStructure); 
end;

procedure TForm1.FormDestroy(Sender: TObject);
var i,o:integer;
begin //maybe free all sub objects as well?
 { for i:=0 to length(formstructure.structure)-1 do
  begin
    o:=length(formstructure.structure[i].Filters)-1;
    while o<>-1 do o:=formstructure.structure[i].decfilterlength;
  end;
  i:= length(formstructure.structure)-1;
  while i<>-1 do i:=formstructure.decdatalength;}

  FormStructure.Free;
end;

procedure TForm1.recive(NewStruct:TFormStructure);
var i:integer;
begin
  //get new form to work with - this form will be saved in the future
//  FormStructure.Free;
//  FormStructure:=NewStruct;
  caption:='';
  for i:=0 to length(formstructure.structure)-1 do
    caption:=caption+ ' ' + formstructure.structure[i].Name;
end;

Procedure StructUpdate;
begin

end;

end.
