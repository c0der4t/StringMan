program StringMan;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmMain_u in 'frmMain_u.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
