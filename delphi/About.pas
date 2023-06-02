Unit About;

Interface

Uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI;

Const
  crHandCur = 8888;

Type
  TAboutBox = Class (TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    EMail: TLabel;
    City: TLabel;
    Procedure FormCreate (Sender: TObject);
    Procedure EMailClick (Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Var
  AboutBox: TAboutBox;

Implementation

{$R *.DFM}

Procedure TAboutBox. FormCreate (Sender: TObject);
Var
  HC: HCursor;
Begin
  HC := LoadCursor (HInstance, PChar (8888) );
  Screen.Cursors [crHandCur] := HC;
  EMail. Cursor := crHandCur;
End;

Procedure TAboutBox. EMailClick (Sender: TObject);
Begin
  ShellExecute (Application. Handle, 'open', 'mailto:maurobio@geocities.com', Nil, Nil, SW_NORMAL);
End;

End.

