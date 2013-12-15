program Server;

uses
  Forms,
  ServerMain in 'ServerMain.pas' {Form1},
  FormEditor in 'FormEditor.pas' {Form2},
  KmarDataStructure in 'KmarDataStructure.pas',
  NewFormWizard in 'NewFormWizard.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
