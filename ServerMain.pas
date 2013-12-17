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
var
  i,o,u,ilimit,ulimit:integer;
  filehandle:THandle;
begin
  //p:=Formstructure;
  FormStructure:=TFormStructure.Create;


  //load last form from file if it exists
  if fileexists('kmarstructdata.ksd') then
  begin
    //load lines into the structure

    filehandle:=fileopen( 'kmarstructdata.ksd', fmopenread);

    fileread(filehandle, o, sizeof(o));  //got field count

    i:=0;
    while (o>i) do i:=formstructure.incdatalength+1;

    for i:=0 to length(formstructure.structure)-1 do
    begin //for every field
      fileread(filehandle, o, sizeof(o));
      setlength(formstructure.structure[i].Name, o);
      fileread(filehandle, PChar(formstructure.structure[i].Name)^, o*sizeof(Char)); //got name

      fileread(filehandle, o, sizeof(o));
      case o of
        0: FormStructure.Structure[i].DataType:=Default;
        1: FormStructure.Structure[i].DataType:=MyInteger;
        2: FormStructure.Structure[i].DataType:=MyFloat;
        3: FormStructure.Structure[i].DataType:=MyString;
      end; //end of case
      
      fileread(filehandle, o, sizeof(integer)); //filter count
      
      u:=0;
      while (u<o) do u:=formstructure.structure[i].incfilterlength+1;

      for u:=0 to length(FormStructure.structure[i].Filters)-1 do
      begin
        fileread(filehandle, o, sizeof(integer));
        case o of
          0: FormStructure.Structure[i].Filters[u].FilterType:=MinLength;
          1: FormStructure.Structure[i].Filters[u].FilterType:=MaxLength;
          2: FormStructure.Structure[i].Filters[u].FilterType:=LessThen;
          3: FormStructure.Structure[i].Filters[u].FilterType:=MoreThen;
          4: FormStructure.Structure[i].Filters[u].FilterType:=ExcludeChar;
          5: FormStructure.Structure[i].Filters[u].FilterType:=IncludeChar;
        end; //end of case

        fileread(filehandle, o, sizeof(integer));
        setlength(FormStructure.structure[i].Filters[u].FilterValue, o);
        fileread(filehandle, PChar(FormStructure.structure[i].Filters[u].FilterValue)^, o*sizeof(char)); //got filter value!

      end; //end of for(u)
    end; //end of for(i)


  end; //end of fileexists
end;

procedure TForm1.Changeform1Click(Sender: TObject);
begin
  //summon form2
  form2.Visible:=true;
  form2.Summon(FormStructure); 
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i,o,u,ilimit,ulimit:integer;
  filehandle:THandle;

begin

  //save current structure in some file.
  fileHandle:=filecreate('kmarstructdata.ksd', fmopenwrite);


  o:=length(formstructure.structure);
  filewrite(filehandle, o, sizeof(o));
  for i:=0 to length(formstructure.structure)-1 do
  begin
    //    formstructure.structure[i].Name, datatype, filter;
    o:=length(formstructure.structure[i].Name); //name
    filewrite(filehandle, o,sizeof(o));
    filewrite(filehandle, PChar(formstructure.structure[i].name)^, o*sizeof(char));
    {
    case formstructure.structure[i].DataType of
      default:
        begin
          o:=0;
        end;
      MyInteger:
        begin
          o:=1;
        end;
      MyFloat:
        begin
          o:=2;
        end;
      Mystring:
        begin
          o:=3;
        end;
      else o:=0;
    end; //end of case }

    o:=integer(formstructure.structure[i].DataType);
    u:=filewrite(filehandle, o, sizeof(o)); //datatype
    if u=-1 then showmessage('oops on file write!');


    o:=length(formstructure.structure[i].Filters)-1;
    filewrite(filehandle, o, sizeof(integer));   //how many filters

    for u:=0 to length(formstructure.structure[i].Filters)-1-1 do
    begin
      //formstructure.structure[i].Filters[u].FilterType, value
      case formstructure.structure[i].Filters[u].FilterType of
        MinLength: o:=0;
        MaxLength: o:=1;
        LessThen: o:=2;
        MoreThen: o:=3;
        ExcludeChar: o:=4;
        IncludeChar: o:=5;
        else o:=0;
      end; //end of case
      filewrite(filehandle, o, sizeof(integer)); //filtertype

      o:=length(formstructure.structure[i].Filters[u].FilterValue);
      filewrite(filehandle, o, sizeof(integer));
      filewrite(filehandle, PChar(formstructure.structure[i].Filters[u].FilterValue)^, o*sizeof(char)); //filtervalue
    end; //end of for(u);

  end; //end of for(i) 


  fileclose(filehandle);

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
