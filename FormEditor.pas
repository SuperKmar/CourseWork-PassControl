unit FormEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, KmarDataStructure, Menus, StdCtrls;

type
  TForm2 = class(TForm)
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    Add1: TMenuItem;
    Removeselected1: TMenuItem;
    ApplyChanges1: TMenuItem;
    procedure Summon(struct:TFormStructure);
    procedure Add1Click(Sender: TObject);
    procedure Removeselected1Click(Sender: TObject);
    procedure ReciveField(NewField:TDataItem);
    procedure ApplyChanges1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses ServerMain, NewFormWizard;

var
  form2structure:TFormStructure;
{$R *.dfm}

Procedure TForm2.Summon(struct:TFormStructure);
var
  i:integer;
  temp:string;
begin
  // here we display all the current fields that we plan to display
  listbox1.Clear;
  for i:=0 to length(struct.structure)-1 do
  begin
    temp:=struct.structure[i].Name;
    case struct.structure[i].DataType of
      MyInteger:
        begin
          temp:=temp+' (Integer) ';
        end;
      MyFloat:
        begin
          temp:=temp+' (Float) ';
        end;
      MyString:
        begin
          temp:=temp+' (String) ';
        end;
    end;//end of case
    listbox1.Items.Add(temp);
  end; // end of for(i)
  Form2Structure:=struct;
end;

procedure TForm2.Add1Click(Sender: TObject);
begin
  //add a new field through form3
  form3.visible:=true;
end;

procedure TForm2.Removeselected1Click(Sender: TObject);
var i,errmsg:integer;
begin
  //remove selected fields
  for i:=0 to listbox1.Count-1 do
  begin
    if listbox1.Selected[i] then
    begin
      errmsg:=form2structure.removedatafield(i);
      if errmsg=-1 then showmessage('error on removal of data item at INDEX='+inttostr(i));
    end;
    listbox1.DeleteSelected;
    break;
  end;
end;

procedure TForm2.ReciveField(NewField:TDataItem);
var
  i,o:integer;
begin
  //recive this guy
 o:=Form2structure.incdatalength;
 Form2structure.structure[o]:=NewField;
 summon(Form2structure);

end;

procedure TForm2.ApplyChanges1Click(Sender: TObject);
begin
  //send the new form
  form1.recive(Form2structure);
  form2.visible:=false;
end;

end.
