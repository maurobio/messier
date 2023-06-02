{=======================================================================}
{        MESSIER - Simulates the formation of globular star clusters    }
{           (c) 1998 Mauro J. Cavalcanti. All rights reserved.          }
{                                                                       }
{  This program may be freely copied and modified, as long as the above }
{  copyright notice is not removed and modifications are documented.    }
{  No price or fee may be charged for it.                               }
{                                                                       }
{  The latest versions will be made available directly over the         }
{  Internet from the Toucan* Web page at the URL:                       }
{           http://www.angelfire.com/mi/SETI/                           }
{                                                                       }
{  If anyone makes any significant alterations or has any bright ideas  }
{  to enhance this program then please forward them to me so I can keep }
{  one up to date copy. Comments may be sent by e-mail to the address:  }
{  maurobio@geocities.com                                               }
{                                                                       }
{  Disclaimer: this program is provided as is, without warranty of any  }
{  kind. Use it at your own risk.                                       }
{                                                                       }
{=======================================================================}

Unit Main;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, Clipbrd;

Type
  TMainForm = Class (TForm)
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
    Procedure FormPaint (Sender: TObject);
    Procedure HelpAboutClick (Sender: TObject);
    Procedure FileExitClick(Sender: TObject);
    Procedure FormClose (Sender: TObject; Var Action: TCloseAction);
    Procedure FormCreate (Sender: TObject);
    Procedure FormDestroy (Sender: TObject);
    Procedure FileSaveAsClick (Sender: TObject);
    Procedure RunMenuClick (Sender: TObject);
    Procedure EditCopyClick (Sender: TObject);
  Private
    { Private declarations }
    S1, R, R0, R1, R2, R3, C, C0, C1, D, X, Y, X2, Y2, Z: Double;
    Xm, Ym, S, T: Integer;
    Done: Boolean;
    Bitmap: TBitmap;
    Procedure Iterate;
    Procedure PlotAStar;
    Procedure PlotAGlobularCluster;
    Procedure PlotStarField;
  Public
    { Public declarations }
    Procedure UpdateMenuItems (Sender: TObject);
  End;

Var
  MainForm: TMainForm;

Implementation

Uses About;

{$R *.DFM}

Procedure TMainForm. Iterate; { Newton-Raphson iteration }
Var
  A: Double;
Begin
  A := R / R0;
  C1 := ArcTan (A) * 0.5 * R3;
  A := 1.0 + A * A;
  C1 := C1 + R * 0.5 * R2 / A;
  C1 := PI * (C1 - R * R2 / (A * A) );
  D := 4.0 * PI * R * R / (A * A * A);
End;

Procedure TMainForm. PlotAStar; { 2-dimensional plot }
Var
  XPlot, YPlot: Integer;
  Rnd: Double;
  Clr: TColor;
Begin
  XPlot := Round (X * S + X2);
  YPlot := Round (Y * S + Y2);
  If (XPlot < 0) Or (YPlot < 0) Then
    Exit;
  If (XPlot > Xm) Or (YPlot > Ym) Then
    Exit;
  Clr := clWhite;
  Rnd := Random;
  If Rnd > 0.7 Then Clr := RGB (255, 165, 0); { Orange }
  If Rnd > 0.9 Then Clr := clRed;
  Canvas. Pixels [XPlot, YPlot] := Clr;
End;

Procedure TMainForm. PlotAGlobularCluster;
Var
  I, K: Integer;
Begin
  PlotStarField;
  R0 := 20;
  R2 := R0 * R0;
  R3 := R2 * R0;
  C0 := PI * PI * R3 / 4;
  R1 := R0 / Sqrt (2);
  Xm := ClientWidth;
  Ym := ClientHeight;
  X2 := Xm / 2;
  Y2 := Ym / 2;
  S := 5;
  If T > 0 Then
  Begin
    Caption := Application. Title;
    Screen. Cursor := crHourGlass;
    Randomize;
    For I := 1 To T Do
    Begin
      { Yield to other events }
      Application. ProcessMessages;
      C := C0 * Random;
      R := R1;
      { Now find radius }
      For K := 1 To 5 Do
      Begin
        Iterate;
        R := R + (C - C1) / D;
      End;
      Repeat
        { 3-dimensional position }
        X := Random - 0.5;
        Y := Random - 0.5;
        Z := Random - 0.5;
        S1 := Sqrt (X * X + Y * Y + Z * Z);
      Until S1 <= 1;
      { Point is now in sphere }
      R := R * S1;
      X := X * R;
      Y := Y * R;
      Z := Z * R;
      PlotAStar;
    End;
    Done := True;
    Caption := Concat ('Globular Cluster of ', IntToStr (T), ' Stars');
    Screen. Cursor := crDefault;
  End
  Else Done := False;
  UpdateMenuItems (Self);
End;

Procedure TMainForm. PlotStarField;
Var
  I: Integer;
  Area: TRect;
Begin
  { Clear our area }
  Area := Rect (0, 0, ClientWidth, ClientHeight);
  Canvas. FillRect (Area);
  { Plot some "stars" }
  For I := 1 To 100 Do
    Canvas. Pixels [Random (ClientWidth), Random (ClientHeight)] := clWhite;
End;

Procedure TMainForm. FormPaint (Sender: TObject);
Begin
  If T > 0 Then
    PlotAGlobularCluster
  Else
    PlotStarField;
End;

Procedure TMainForm. HelpAboutClick (Sender: TObject);
Begin
  AboutBox. ShowModal;
End;

Procedure TMainForm. FileExitClick (Sender: TObject);
Begin
  Close;
End;

Procedure TMainForm. FormClose (Sender: TObject; Var Action: TCloseAction);
Begin
  Action := caFree;
End;

Procedure TMainForm. FormCreate (Sender: TObject);
Begin
  T := 0;
  Done := False;
  Bitmap := TBitmap. Create;
  Canvas. Brush. Style := bsSolid;
  Canvas. Brush. Color := clBlack;
  Canvas. CopyMode := cmSrcCopy;
  Screen. OnActiveFormChange := UpdateMenuItems;
End;

Procedure TMainForm. FormDestroy (Sender: TObject);
Begin
  Screen. OnActiveFormChange := Nil;
  Bitmap. Free;
End;

Procedure TMainForm. FileSaveAsClick (Sender: TObject);
Begin
  If SaveDialog. Execute Then
  Begin
    Bitmap. Width := ClientWidth;
    Bitmap. Height := ClientHeight;
    Bitmap. Canvas. CopyRect (ClientRect, Canvas, ClientRect);
    Bitmap. SaveToFile (SaveDialog. FileName);
    Canvas. CopyRect (ClientRect, Bitmap. Canvas, ClientRect);
  End;
End;

Procedure TMainForm. RunMenuClick (Sender: TObject);
Begin
  T := StrToIntDef (InputBox ('Enter Number of Stars in Cluster', 'How many stars?', '0'), 0);
  If T > 0 Then PlotAGlobularCluster;
  If Done Then MessageBeep (mb_IconInformation);
End;

Procedure TMainForm. UpdateMenuItems (Sender: TObject);
Begin
  FileSaveAs. Enabled := Done;
  EditCopy. Enabled := Done;
End;

Procedure TMainForm. EditCopyClick (Sender: TObject);
Begin
  Bitmap. Width := ClientWidth;
  Bitmap. Height := ClientHeight;
  Bitmap. Canvas. CopyRect (ClientRect, Canvas, ClientRect);
  Clipboard. Assign (Bitmap);
End;

End.
