unit frmMain_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Types,
  FMX.Controls, FMX.Controls.Presentation, FMX.Edit,FMX.Utils,FMX.DialogService,
  FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Math,System.Notification;

type
  TfrmMain = class(TForm)
    edtPrefix: TEdit;
    edtSuffix: TEdit;
    memRaw: TMemo;
    memFinal: TMemo;
    btnProcess: TCornerButton;
    btnClear: TCornerButton;
    progress: TProgressBar;
    btnCopy: TButton;
    notify: TNotificationCenter;
    procedure btnProcessClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    sPrefix, sSuffix: string;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  memRaw.Lines.Clear;
  memFinal.Lines.Clear;
  progress.Value :=  0;
end;

procedure TfrmMain.btnCopyClick(Sender: TObject);
var
MyNotification : TNotification;
begin
  memFinal.SelectAll;
  memFinal.CopyToClipboard;
  MyNotification := notify.CreateNotification;
  MyNotification.Title := 'Copied' ;
  MyNotification.AlertBody := 'Processed Data Copied to Clipboard';
  MyNotification.EnableSound := False;
  notify.PresentNotification(MyNotification);
end;

procedure TfrmMain.btnProcessClick(Sender: TObject);
var
  sCurrLine: string;
  i, Progressor: integer;
begin
  progress.Value := 0;

  sPrefix := edtPrefix.Text;
  sSuffix := edtSuffix.Text;
  Progressor := Ceil(100 / (memRaw.Lines.Count - 1));
  for i := 0 to memRaw.Lines.Count - 1 do
  begin
    sCurrLine := memRaw.Lines[i];
    memFinal.Lines.Add(sPrefix + sCurrLine + sSuffix);
    progress.Value := progress.Value + Progressor;
  end;


end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  btnCopy.Position.X := (memFinal.Position.X + memFinal.Width)- btnCopy.Width;
  memRaw.Height := (35/100)*frmMain.Height;
  memFinal.Height := (40/100)*frmMain.Height;
  progress.Width := (frmMain.Width - btnProcess.Width) - (progress.Position.X * 3);

  memFinal.Position.Y := memRaw.Position.Y + memRaw.Height + 10;
  btnProcess.Position.Y := memFinal.Position.Y + memFinal.Height + 5;
  btnClear.Position.Y := btnProcess.Position.Y + btnProcess.Height + 2;
  progress.Position.Y := btnProcess.Position.Y + (btnProcess.Height / 4);
  btnCopy.Position.Y := memFinal.Position.Y;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  edtPrefix.SetFocus;
end;

end.
