program Messier;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
