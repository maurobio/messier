Program Messier;

Uses
  Forms,
  Main In 'Main.pas' {MainForm},
  About In 'About.pas' {AboutBox};

{$R *.RES}

Begin
  Application.Initialize;
  Application.Title := 'Messier';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
End.
