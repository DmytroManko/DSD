unit FormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dsdDataSetWrapperUnit;

type
  TParentForm = class(TForm)
  private
    FParams: TdsdParams;
  public
    { Public declarations }
    property Params: TdsdParams read FParams;
    procedure Execute(Params: TdsdParams);
  end;

implementation

uses cxPropertiesStore, cxControls, cxContainer, cxEdit, cxGroupBox,
  dxBevel, cxButtons, cxGridDBTableView, cxGrid, DB, DBClient,
  dxBar, Vcl.ActnList, dsdActionUnit, cxTextEdit, cxLabel,
  StdActns;

{$R *.dfm}

procedure TParentForm.Execute(Params: TdsdParams);
var
  i: integer;
begin
  // ��������� ��������� ����� ����������� �����������
  for I := 0 to ComponentCount - 1 do
    if Components[i] is TdsdFormParams then begin
       FParams := (Components[i] as TdsdFormParams).Params;
       FParams.Assign(Params);
  end;

  for I := 0 to ComponentCount - 1 do begin
    // ������������ ������� ����������
    if Components[i] is TdsdDataSetRefresh then
       (Components[i] as TdsdDataSetRefresh).Execute;
    if Components[i] is TcxPropertiesStore then
       (Components[i] as TcxPropertiesStore).RestoreFrom;
  end;
end;

initialization
  // ����������� ����������
  RegisterClass (TDataSource);
  RegisterClass (TClientDataSet);
  RegisterClass (TFileExit);
  RegisterClass (TActionList);
  // ���������� DevExpress
  RegisterClass (TdxBevel);
  RegisterClass (TcxButton);
  RegisterClass (TcxGroupBox);
  RegisterClass (TcxGridDBTableView);
  RegisterClass (TcxGrid);
  RegisterClass (TcxPropertiesStore);
  RegisterClass (TdxBarManager);
  RegisterClass (TcxTextEdit);
  RegisterClass (TcxLabel);
  // ������������ ����������
  RegisterClass (TdsdOpenForm);
  RegisterClass (TdsdStoredProc);
  RegisterClass (TdsdFormParams);
  RegisterClass (TdsdFormClose);
  RegisterClass (TdsdDataSetRefresh);
  RegisterClass (TdsdExecStoredProc);
  RegisterClass (TdsdInsertUpdateAction);

end.
