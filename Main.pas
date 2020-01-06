{==========================================================================}
{      MESSIER - Simulates the formation of globular star clusters         }
{           (c) 1998-2019 Mauro J. Cavalcanti. All rights reserved.        }
{                                                                          }
{   This program is free software: you can redistribute it and/or modify   }
{   it under the terms of the GNU General Public License as published by   }
{   the Free Software Foundation, either version 3 of the License, or      }
{   (at your option) any later version.                                    }
{                                                                          }
{   This program is distributed in the hope that it will be useful,        }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of         }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          }
{   GNU General Public License for more details.                           }
{                                                                          }
{   You should have received a copy of the GNU General Public License      }
{   along with this program. If not, see <http://www.gnu.org/licenses/>.   }
{                                                                          }
{   The latest versions will be made available directly over the           }
{   Internet from my Web page at <http://sites.google.com/site/maurobio>   }
{                                                                          }
{   If anyone makes any significant alterations or has any bright ideas    }
{   to enhance this program then please forward them to me so I can keep   }
{   one up to date copy. Comments may be sent by e-mail to the address:    }
{   <maurobio@gmail.com>                                                   }
{                                                                          }
{   Requirements:                                                          }
{     Lazarus 2.0+ (www.lazarus.freepascal.org)                            }
{     Free Pascal 3.0+ (www.freepascal.org)                                }
{==========================================================================}

unit Main;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, Clipbrd;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    EditMenu: TMenuItem;
    HelpMenu: TMenuItem;
    HelpAbout: TMenuItem;
    EditCopy: TMenuItem;
    FileSaveAs: TMenuItem;
    FileExit: TMenuItem;
    SaveDialog: TSaveDialog;
    RunMenu: TMenuItem;
    N1: TMenuItem;
    procedure FormPaint(Sender: TObject);
    procedure HelpAboutClick(Sender: TObject);
    procedure FileExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileSaveAsClick(Sender: TObject);
    procedure RunMenuClick(Sender: TObject);
    procedure EditCopyClick(Sender: TObject);
  private
    { Private declarations }
    S1, R, R0, R1, R2, R3, C, C0, C1, D, X, Y, X2, Y2, Z: double;
    Xm, Ym, S, T: integer;
    Done: boolean;
    Bitmap: TBitmap;
    procedure Iterate;
    procedure PlotAStar;
    procedure PlotAGlobularCluster;
    procedure PlotStarField;
  public
    { Public declarations }
    procedure UpdateMenuItems(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

uses About;

{$R *.LFM}

procedure TMainForm.Iterate; { Newton-Raphson iteration }
var
  A: double;
begin
  A := R / R0;
  C1 := ArcTan(A) * 0.5 * R3;
  A := 1.0 + A * A;
  C1 := C1 + R * 0.5 * R2 / A;
  C1 := PI * (C1 - R * R2 / (A * A));
  D := 4.0 * PI * R * R / (A * A * A);
end;

procedure TMainForm.PlotAStar; { 2-dimensional plot }
var
  XPlot, YPlot: integer;
  Rnd: double;
  Clr: TColor;
begin
  XPlot := Round(X * S + X2);
  YPlot := Round(Y * S + Y2);
  if (XPlot < 0) or (YPlot < 0) then
    Exit;
  if (XPlot > Xm) or (YPlot > Ym) then
    Exit;
  Clr := clWhite;
  Rnd := Random;
  if Rnd > 0.7 then
    Clr := RGB(255, 165, 0); { Orange }
  if Rnd > 0.9 then
    Clr := clRed;
  Canvas.Pixels[XPlot, YPlot] := Clr;
end;

procedure TMainForm.PlotAGlobularCluster;
var
  I, K: integer;
begin
  PlotStarField;
  R0 := 20;
  R2 := R0 * R0;
  R3 := R2 * R0;
  C0 := PI * PI * R3 / 4;
  R1 := R0 / Sqrt(2);
  Xm := ClientWidth;
  Ym := ClientHeight;
  X2 := Xm / 2;
  Y2 := Ym / 2;
  S := 5;
  if T > 0 then
  begin
    Caption := Application.Title;
    Screen.Cursor := crHourGlass;
    Randomize;
    for I := 1 to T do
    begin
      { Yield to other events }
      Application.ProcessMessages;
      C := C0 * Random;
      R := R1;
      { Now find radius }
      for K := 1 to 5 do
      begin
        Iterate;
        R := R + (C - C1) / D;
      end;
      repeat
        { 3-dimensional position }
        X := Random - 0.5;
        Y := Random - 0.5;
        Z := Random - 0.5;
        S1 := Sqrt(X * X + Y * Y + Z * Z);
      until S1 <= 1;
      { Point is now in sphere }
      R := R * S1;
      X := X * R;
      Y := Y * R;
      Z := Z * R;
      PlotAStar;
    end;
    Done := True;
    Caption := Concat('Globular Cluster of ', IntToStr(T), ' Stars');
    Screen.Cursor := crDefault;
  end
  else
    Done := False;
  UpdateMenuItems(Self);
end;

procedure TMainForm.PlotStarField;
var
  I: integer;
  Area: TRect;
begin
  { Clear our area }
  Area := Rect(0, 0, ClientWidth, ClientHeight);
  Canvas.FillRect(Area);
  { Plot some "stars" }
  for I := 1 to 100 do
    Canvas.Pixels[Random(ClientWidth), Random(ClientHeight)] := clWhite;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  if T > 0 then
    PlotAGlobularCluster
  else
    PlotStarField;
end;

procedure TMainForm.HelpAboutClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.FileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  T := 0;
  Done := False;
  Bitmap := TBitmap.Create;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clBlack;
  Canvas.CopyMode := cmSrcCopy;
  Screen.OnActiveFormChange := UpdateMenuItems;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
  Bitmap.Free;
end;

procedure TMainForm.FileSaveAsClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    Bitmap.Width := ClientWidth;
    Bitmap.Height := ClientHeight;
    Bitmap.Canvas.CopyRect(ClientRect, Canvas, ClientRect);
    Bitmap.SaveToFile(SaveDialog.FileName);
    Canvas.CopyRect(ClientRect, Bitmap.Canvas, ClientRect);
  end;
end;

procedure TMainForm.RunMenuClick(Sender: TObject);
begin
  T := StrToIntDef(InputBox('Enter Number of Stars in Cluster',
    'How many stars?', '0'), 0);
  if T > 0 then
    PlotAGlobularCluster;
end;

procedure TMainForm.UpdateMenuItems(Sender: TObject);
begin
  FileSaveAs.Enabled := Done;
  EditCopy.Enabled := Done;
end;

procedure TMainForm.EditCopyClick(Sender: TObject);
begin
  Bitmap.Width := ClientWidth;
  Bitmap.Height := ClientHeight;
  Bitmap.Canvas.CopyRect(ClientRect, Canvas, ClientRect);
  Clipboard.Assign(Bitmap);
end;

end.
