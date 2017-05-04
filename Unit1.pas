unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    BtStart: TCornerButton;
    Edit1: TEdit;
    BtStop: TCornerButton;
    Switch1: TSwitch;
    Label1: TLabel;
    NumberBox1: TNumberBox;
    NumberBox2: TNumberBox;
    Label2: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    CornerButton1: TCornerButton;
    Timer2: TTimer;
    Memo1: TMemo;
    procedure BtStartClick(Sender: TObject);
    procedure BtStopClick(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
    Procedure  Stop;
    Procedure  Start;
    Procedure showinfo;
    Procedure hideinfo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Work:boolean=false;
  info:boolean=false;
  Takt:integer=0;
implementation

uses
  Winapi.Windows;

{$R *.fmx}

procedure TForm1.BtStartClick(Sender: TObject);
begin
  Start;
end;

procedure TForm1.BtStopClick(Sender: TObject);
begin
 Stop;
end;

Procedure TForm1.hideinfo;
var
  i:integer;
begin
  i:=Form1.Height;
  if Form1.Height >=147 then
  begin
    dec(i);
    Form1.Height:=i;
  end else
  Timer2.Enabled:=false;
end;

Procedure TForm1.showinfo;
var
  i:integer;
begin
  i:=Form1.Height;
  if Form1.Height <=250 then
  begin
    inc(i);
    Form1.Height:=i;
  end else
  Timer2.Enabled:=false;
end;

procedure TForm1.CornerButton1Click(Sender: TObject);
begin
info:=not info;
Timer2.Enabled:=true;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  BtStart.Enabled:=not Switch1.IsChecked;
  BtStop.Enabled:=not Switch1.IsChecked;
  Edit1.Enabled:=not Switch1.IsChecked;
  Timer1.Enabled:=Switch1.IsChecked;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  lworking, lpause: integer;
begin
  lworking:=StrToInt( NumberBox1.Text);
  lpause:=StrToInt( NumberBox2.Text);
  Inc(Takt);
  if Work then
  begin
    if  Takt >= lworking then
    begin
      Stop;
      Takt:=0;
    end;
  end else
  begin
    if  Takt >= lpause then
    begin
      Start;
      Takt:=0;
    end;
  end;

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if info then
    showinfo
  else
    hideinfo;
end;

Procedure  TForm1.Start;
var
  PName:PANSIChar;
  str: string;
begin
 str:=Edit1.Text;
 str:=trim(str);
 PName:=PAnsiChar(AnsiString(str));
 WinExec(PName, SW_ShowNormal);
 Work:=True;
end;

Procedure  TForm1.Stop;
var
  PName:PANSIChar;
  str: string;
begin
 str:=Edit1.Text;
 str:=trim(str);
 if pos('.exe',str)= 0 then
   str:=str+'.exe';
 str:='TaskKill /IM '+str;
 PName:=PAnsiChar(AnsiString(str));
 WinExec(PName, SW_HIDE);
 Work:=False;
end;


end.
