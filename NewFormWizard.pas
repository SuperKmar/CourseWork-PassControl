unit NewFormWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, KmarDataStructure;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    Edit2: TEdit;
    ComboBox2: TComboBox;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses FormEditor;
type TFilterParams=class
  FType: TComboBox; //how the filter works
  FValue: TEdit; //filter paramaters

  constructor create;
  destructor destroy; override;
end;

var
  Filter:array of TFilterParams;

constructor TFilterParams.create;
begin
  Ftype:=TComboBox.Create(form3);
  FValue:=TEdit.Create(form3);
  FType.Parent:=Form3;
  FValue.Parent:=Form3;
//  FType.Items.Add('Test Item');
  FType.Items.Add('MinLength');
  FType.Items.Add('MaxLength');
  FType.Items.Add('LessThen');
  FType.Items.Add('MoreThen');
  FType.Items.Add('ExcludeChar');
  FType.Items.Add('IncludeChar');
end;

destructor TFilterParams.destroy;
begin
  FType.Free;
  FValue.Free;
end;
{$R *.dfm}

procedure TForm3.Timer1Timer(Sender: TObject);
var i,o:integer;

function last:integer;
begin
  result:=length(Filter)-1;
end;

begin
  //this is for the filters display only
  //remove empty filters exept last
  for i:=0 to length(Filter)-1-1 do //not last
  begin
    if (Filter[i].FValue.Text='') and ((not filter[i].FValue.Focused) or (Filter[i].FType.Focused))then
    begin  //delete this filter
      filter[i].Free;
      for o:=i to length(Filter)-1-1 do //shift filters up by 1 space
      begin
        Filter[o]:=Filter[o+1];
      end;
      setlength(Filter, length(Filter)-1);
    end;
  end;

  //add filters

  if length(filter)=0 then
  begin
    setlength(Filter, length(Filter)+1);
    Filter[last]:=TFilterParams.create;
  end;

  if Filter[last].FValue.text <> '' then
  begin
    setlength(Filter, length(Filter)+1);
    Filter[last]:=TFilterParams.create;
    Filter[last].FValue.Text:='';
  end;


  //set filter positions
  for i:=0 to length(filter)-1 do
  begin
    Filter[i].FType.Left:=combobox2.Left;
    Filter[i].FType.Top:=(i)*55+combobox2.Top;
    Filter[i].FType.Width:=combobox2.Width;
    Filter[i].FType.Height:=combobox2.Height;

    Filter[i].FValue.Left:=edit2.Left;
    Filter[i].FValue.Top:=Filter[i].FType.Top;
    Filter[i].FValue.Width:=edit2.Width;
  end;


end;

procedure TForm3.Button1Click(Sender: TObject);
var
  temp:TDataItem;
  i,o:integer;

function last:integer;
begin
  result:=length(Filter)-1;
end;

begin
  //adds to the list

  Temp:=TDataItem.Create;

  Temp.Name:=Edit1.Text;

  case   combobox1.ItemIndex of
    0: temp.DataType:=Default;
    1: temp.DataType:=MyInteger;
    2: temp.DataType:=MyFloat;
    3: temp.DataType:=MyString;
  end;

  For i:=0 to last do
  begin
    o:=Temp.incfilterlength;
    if i=o then
    begin
      case Filter[i].FType.ItemIndex of
        0: temp.Filters[i].FilterType:=MinLength;
        1: temp.Filters[i].FilterType:=MaxLength;
        2: temp.Filters[i].FilterType:=LessThen;
        3: temp.Filters[i].FilterType:=MoreThen;
        4: temp.Filters[i].FilterType:=ExcludeChar;
        5: temp.Filters[i].FilterType:=IncludeChar;
      end; //end of case

      temp.Filters[i].FilterValue:=Filter[i].FValue.Text;

    end; //end of if(i=o)
  end; //end of for(i)

  Form2.ReciveField(temp);
  form3.visible:=false;
  form2.visible:=true;
end;

end.
