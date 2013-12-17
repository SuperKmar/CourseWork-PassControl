unit KmarDataStructure;

interface


uses SysUtils;

type TDataType=(Default,MyInteger,MyFloat,MyString);
type TFilterType=(MinLength,MaxLength,LessThen,MoreThen, ExcludeChar, IncludeChar);

type TFilter= class
  FilterType:TFilterType;
  FilterValue:String;
end;

type TDataItem=class
  Name:string;
  DataType:TDataType;
  Filters:array of TFilter;
  function incfilterlength: integer;
  function decfilterlength: integer;
end;

type TFormStructure=class
  structure : array of TDataItem;
  function incdatalength:integer;
  function decdatalength:integer;
  function removedatafield(index:integer):integer;
  procedure writedata(handle:Thandle);
  procedure readdata(handle:THandle);
end;

implementation

procedure TFormstructure.writedata(handle:THandle);
var
  i,o,u:integer;
begin
  //

  {Handle:=filecreate('kmarstructdata.ksd', fmopenwrite);


  o:=length(self.structure);
  filewrite(Handle, o, sizeof(integer));
  for i:=0 to length(self.structure)-1 do
  begin
    //    self.structure[i].Name, datatype, filter;
    o:=length(self.structure[i].Name); //name
    filewrite(Handle, o,sizeof(integer));
    filewrite(Handle, PChar(self.structure[i].name)^, o*sizeof(char));

    case self.structure[i].DataType of
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
    end; //end of case
    filewrite(handle, o, sizeof(integer)); //datatype

    o:=length(self.structure[i].Filters)-1;
    filewrite(Handle, o, sizeof(integer));   //how many filters

    for u:=0 to length(self.structure[i].Filters)-1-1 do
    begin
      //self.structure[i].Filters[u].FilterType, value
      case self.structure[i].Filters[u].FilterType of
        MinLength: o:=0;
        MaxLength: o:=1;
        LessThen: o:=2;
        MoreThen: o:=3;
        ExcludeChar: o:=4;
        IncludeChar: o:=5;
        else o:=0;
      end; //end of case
      filewrite(Handle, o, sizeof(integer)); //filtertype

      o:=length(self.structure[i].Filters[u].FilterValue);
      filewrite(Handle, o, sizeof(integer));
      filewrite(Handle, PChar(self.structure[i].Filters[u].FilterValue)^, o*sizeof(char)); //filtervalue
    end; //end of for(u);

  end; //end of for(i)
  fileclose(Handle); }
end;

procedure TFormStructure.readdata(handle:THandle);
begin
   {
  //load last form from file if it exists
  if fileexists('kmarstructdata.ksd') then
  begin
    //load lines into the structure

    filehandle:=fileopen-( 'kmarstructdata.ksd', fmopenread);

    fileread(filehandle, o, sizeof(integer));  //got field count

    i:=0;
    while (o>i) do i:=formstructure.incdatalength+1;

    for i:=0 to length(formstructure.structure)-1 do
    begin //for every field
      fileread(filehandle, o, sizeof(integer)); 
      setlength(formstructure.structure[i].Name, o);
      fileread(filehandle, PChar(formstructure.structure[i].Name)^, o*sizeof(Char)); //got name

      fileread(filehandle, o, sizeof(integer));
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
  end; //end of fileexists    }
end;

function TFormStructure.incdatalength:integer;
var o:integer;
begin
  setlength(self.structure, length(self.structure)+1);
  o:=length(self.structure)-1;
  self.structure[o]:=TDataItem.Create;
  result:=length(self.structure)-1;
end;

function TFormStructure.decdatalength:integer;
var o:integer;
begin
  if length(self.structure)>0 then
  begin
    o:=length(self.structure)-1;
    self.structure[o].Free;
    setlength(self.structure, length(self.structure)-1);
    result:=length(self.structure)-1;
  end else result:= -1;
end;

function TFormStructure.removedatafield(index:integer):integer;
var
  i:integer;
  temp:TDataItem;

function last:integer;
begin
  result:=length(self.structure)-1;
end;

begin
  if (index>=0) and (index<=last) then
  begin
    //self.structure[index].Free;
    temp:=self.structure[index];
    for i:=index to last-1 do
    begin
      self.structure[i]:=self.structure[i+1];
    end;
    self.structure[last]:=temp;
    self.decdatalength;
    result:=last;
  end else result:=-1;
end;

function TDataItem.incfilterlength:integer;
var o:integer;
begin
  setlength(self.Filters, length(self.Filters)+1);
  o:=length(self.Filters)-1;
  self.Filters[o]:=TFilter.Create;
  result:=length(self.Filters)-1;
end;

function TDataItem.decfilterlength:integer;
var o:integer;
begin
  if length(self.Filters)>0 then
  begin
    o:=length(self.Filters)-1;
    self.Filters[o].Free;
    setlength(self.Filters, length(self.Filters)+1);
    result:=length(self.Filters)-1;
  end else result:=-1;
end;

end.
