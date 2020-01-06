unit About;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI;

const
  crHandCur = 8888;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    EMail: TLabel;
    City: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure EMailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.LFM}

procedure TAboutBox.FormCreate(Sender: TObject);
var
  HC: HCursor;
begin
  HC := LoadCursor(HInstance, PChar(8888));
  Screen.Cursors[crHandCur] := HC;
  EMail.Cursor := crHandCur;
end;

procedure TAboutBox.EMailClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'mailto:maurobio@gmail.com',
    nil, nil, SW_NORMAL);
end;

end.
