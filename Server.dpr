program Server;

uses
  Forms,
  ServerMain in 'ServerMain.pas' {Form1},
  FormEditor in 'FormEditor.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
