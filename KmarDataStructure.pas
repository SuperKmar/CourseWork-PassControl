unit KmarDataStructure;

interface


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
end;

implementation

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
var i:integer;
function last:integer;
begin
  result:=length(self.structure)-1;
end;

begin
  if (index>=0) and (index<=last) then
  begin
    self.structure[index].Free;
    for i:=index to last-1 do
    begin
      self.structure[i]:=self.structure[i+1];
    end;
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
