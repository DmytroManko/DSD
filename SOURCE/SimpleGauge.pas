unit SimpleGauge;

interface

uses
  Gauges, System.Classes, Vcl.Controls, Forms;

type

  IGauge = interface(IDispatch)
    {$IFDEF VER100}
    procedure IncProgress(IncValue: integer);
    {$ELSE}
    procedure IncProgress(IncValue: integer = 1);
    {$ENDIF}
    procedure Start;
    procedure Finish;
  end;

  TGaugeFactory = class
    class function GetGauge(in_stCaption: TCaption; AMinValue, AMaxValue: integer): IGauge;
  end;

  TSimpleGaugeForm = class(TForm, IGauge)
    Gauge: TGauge;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    constructor Create(AOwner: TForm; ACaption: TCaption; AMinValue, AMaxValue: integer);
    procedure Start;
    procedure Finish;
    {$IFDEF VER100}
    procedure IncProgress(IncValue: integer);
    {$ELSE}
    procedure IncProgress(IncValue: integer = 1);
    {$ENDIF}
  end;

implementation

{$R *.DFM}
{------------------------------------------------------------------------------}
constructor TSimpleGaugeForm.Create(AOwner: TForm;ACaption: TCaption;AMinValue,AMaxValue: integer);
begin
  inherited Create(AOwner);
  Caption:=ACaption;
  with Gauge do begin
    Progress:=AMinValue;
    MinValue:=AMinValue;
    MaxValue:=AMaxValue;
  end;
end;
{------------------------------------------------------------------------------}
procedure TSimpleGaugeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
end;
{------------------------------------------------------------------------------}
procedure TSimpleGaugeForm.Finish;
begin
  Close;
end;

procedure TSimpleGaugeForm.Start;
begin
  Show;
  Gauge.Progress := Gauge.MinValue;
end;

{ TGaugeFactory }
class function TGaugeFactory.GetGauge(in_stCaption: TCaption; AMinValue, AMaxValue: integer): IGauge;
begin
   result := TSimpleGaugeForm.Create(nil, in_stCaption, AMinValue, AMaxValue);
end;

procedure TSimpleGaugeForm.IncProgress(IncValue: integer);
begin
  Gauge.Progress := Gauge.Progress + IncValue;
  Application.ProcessMessages;
end;

end.
