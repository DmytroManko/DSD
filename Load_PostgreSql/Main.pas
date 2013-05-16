unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, Gauges, ADODB;

type
  TMainForm = class(TForm)
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    ButtonPanel: TPanel;
    OKGuideButton: TButton;
    Panel1: TPanel;
    cbGoodsGroup: TCheckBox;
    cbAllGuide: TCheckBox;
    Gauge: TGauge;
    cbGoods: TCheckBox;
    fromADOConnection: TADOConnection;
    toADOConnection: TADOConnection;
    toStoredProc: TADOStoredProc;
    fromQuery: TADOQuery;
    fromSqlQuery: TADOQuery;
    toQuery: TADOQuery;
    StopButton: TButton;
    CloseButton: TButton;
    cbMeasure: TCheckBox;
    cbGoodsKind: TCheckBox;
    toStoredProcTwo: TADOStoredProc;
    cbPaidKind: TCheckBox;
    cbJuridicalGroup: TCheckBox;
    cbContractKind: TCheckBox;
    cbContract: TCheckBox;
    cbJuridical: TCheckBox;
    cbPartner: TCheckBox;
    cbBusiness: TCheckBox;
    cbBranch: TCheckBox;
    cbUnitGroup: TCheckBox;
    cbUnit: TCheckBox;
    cbPriceList: TCheckBox;
    cbPriceListItems: TCheckBox;
    cbGoodsProperty: TCheckBox;
    cbGoodsPropertyValue: TCheckBox;
    procedure OKGuideButtonClick(Sender: TObject);
    procedure cbAllGuideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    fStop:Boolean;
    procedure EADO_EngineErrorMsg(E:EADOError);
    procedure EDB_EngineErrorMsg(E:EDBEngineError);
    function myExecToStoredProc:Boolean;

    function FormatToVarCharServer_notNULL(_Value:string):string;
    function FormatToDateServer_notNULL(_Date:TDateTime):string;

    function fGetSession:String;
    function fExecSqFromQuery (mySql:String):Boolean;

    procedure pLoadGuide_Measure;
    procedure pLoadGuide_GoodsGroup;
    procedure pLoadGuide_Goods;
    procedure pLoadGuide_GoodsKind;
    procedure pLoadPaidKind;
    procedure pLoadContractKind;
    procedure pLoadJuridicalGroup;
    procedure pLoadJuridical;
    procedure pLoadPartner;
    procedure pLoadUnitGroup;
    procedure pLoadUnit;
    procedure pLoadPriceList;
    procedure pLoadGoodsProperty;
    procedure pLoadGoodsPropertyValue;

    procedure myEnabledCB (cb:TCheckBox);
    procedure myDisabledCB (cb:TCheckBox);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.StopButtonClick(Sender: TObject);
begin
     if MessageDlg('������������� ���������� ��������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
     fStop:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.CloseButtonClick(Sender: TObject);
begin
     if not fStop then
       if MessageDlg('������������� ���������� �������� � �����?',mtConfirmation,[mbYes,mbNo],0)=mrYes then fStop:=true;
     //
     if fStop then Close;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.fGetSession:String;
begin Result:='1005'; end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.fExecSqFromQuery(mySql:String):Boolean;
begin
     with fromSqlQuery,Sql do begin
        Clear;
        Add(mySql);
        try ExecSql except ShowMessage('fExecSqFromQuery'+#10+#13+mySql);Result:=false;exit;end;
     end;
     Result:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.OKGuideButtonClick(Sender: TObject);
begin
     if MessageDlg('������������� ��������� ��������� �����������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
     fStop:=false;
     DBGrid.Enabled:=false;
     OKGuideButton.Enabled:=false;
     //
     Gauge.Visible:=true;
     //
     if not fStop then pLoadGuide_Measure;
     if not fStop then pLoadGuide_GoodsGroup;
     if not fStop then pLoadGuide_Goods;
     if not fStop then pLoadGuide_GoodsKind;
     if not fStop then pLoadPaidKind;
     if not fStop then pLoadContractKind;
     if not fStop then pLoadJuridicalGroup;
     if not fStop then pLoadJuridical;
     if not fStop then pLoadPartner;
     if not fStop then pLoadUnitGroup;
     if not fStop then pLoadUnit;
     if not fStop then pLoadPriceList;
     if not fStop then pLoadGoodsProperty;
     if not fStop then pLoadGoodsPropertyValue;
     //
     Gauge.Visible:=false;
     DBGrid.Enabled:=true;
     OKGuideButton.Enabled:=true;
     //
     toADOConnection.Connected:=false;
     //fromADOConnection.Connected:=false;
     //
     if fStop then ShowMessage('����������� �� ���������.') else ShowMessage('����������� ���������.');
     //
     fStop:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Measure;
begin
     if (not cbMeasure.Checked)or(not cbMeasure.Enabled) then exit;
     //
     myEnabledCB(cbMeasure);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Measure.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Measure.MeasureName as ObjectName');
        Add('     , Measure.Id_Postgres');
        Add('from dba.Measure');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_measure';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             //toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Measure set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbMeasure);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_GoodsGroup;
begin
     if (not cbGoodsGroup.Checked)or(not cbGoodsGroup.Enabled) then exit;
     //
     myEnabledCB(cbGoodsGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Goods.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Goods.GoodsName as ObjectName');
        Add('     , Goods.Id_Postgres');
        Add('     , Goods_parent.Id_Postgres as ParentId_Postgres');
        Add('from dba.Goods');
        Add('     left outer join dba.Goods as Goods_parent on Goods_parent.Id = Goods.ParentId');
        Add('where Goods.HasChildren <> zc_hsLeaf()');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_goodsgroup';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inParentId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             //toStoredProc.Parameters.ParamByName('inGoodsGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             //create table dba.__tmp (st TVarCharLongLong);
             //fExecSqFromQuery('insert into __tmp (st) values ('+char(39)+'update dba.Goods set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('GoodsId').AsString+';commit;'+char(39)+')');
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Goods set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbGoodsGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Goods;
begin
     if (not cbGoods.Checked)or(not cbGoods.Enabled) then exit;
     //
     myEnabledCB(cbGoods);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select GoodsProperty.Id as ObjectId');
        Add('     , GoodsProperty.GoodsCode as ObjectCode');
        Add('     , GoodsProperty.GoodsName as ObjectName');
        Add('     , max (case when Goods.ParentId=686 then GoodsProperty.Tare_Weight else GoodsProperty_Detail.Ves_onMeasure end) as Ves_onMeasure');
        Add('     , GoodsProperty.Id_Postgres as Id_Postgres');
        Add('     , Measure.Id_Postgres as MeasureId_Postgres');
        Add('     , Goods_parent.Id_Postgres as ParentId_Postgres');
        Add('from dba.GoodsProperty');
        Add('     left outer join dba.Goods on Goods.Id = GoodsProperty.GoodsId');
        Add('     left outer join dba.Goods as Goods_parent on Goods_parent.Id = Goods.ParentId');
        Add('     left outer join dba.Measure on Measure.Id = GoodsProperty.MeasureId');
        Add('     left outer join dba.GoodsProperty_Detail on GoodsProperty_Detail.GoodsPropertyId = GoodsProperty.Id');
        Add('where Goods.HasChildren = zc_hsLeaf() ');
        Add('group by ObjectId');
        Add('       , ObjectName');
        Add('       , ObjectCode');
        Add('       , Id_Postgres');
        Add('       , MeasureId_Postgres');
        Add('       , ParentId_Postgres');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_goods';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inGoodsGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inMeasureId').Value:=FieldByName('MeasureId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inWeight').Value:=FieldByName('MeasureId_Postgres').AsFloat;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.GoodsProperty set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbGoods);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_GoodsKind;
begin
     if (not cbGoodsKind.Checked)or(not cbGoodsKind.Enabled) then exit;
     //
     myEnabledCB(cbGoodsKind);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select KindPackage.Id as ObjectId');
        Add('     , KindPackage.KindPackageCode as ObjectCode');
        Add('     , KindPackage.KindPackageName as ObjectName');
        Add('     , KindPackage.Id_Postgres as Id_Postgres');
        Add('from dba.KindPackage');
        Add('where KindPackage.HasChildren = zc_hsLeaf()');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_goodskind';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.KindPackage set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbGoodsKind);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadPaidKind;
begin
     if (not cbPaidKind.Checked)or(not cbPaidKind.Enabled) then exit;
     //
     myEnabledCB(cbPaidKind);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select MoneyKind.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , MoneyKind.MoneyKindName as ObjectName');
        Add('     , MoneyKind.Id_Postgres as Id_Postgres');
        Add('from dba.MoneyKind');
        Add('where MoneyKind.Id<=2');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_paidkind';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.MoneyKind set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbPaidKind);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadContractKind;
begin
     if (not cbContractKind.Checked)or(not cbContractKind.Enabled) then exit;
     //
     myEnabledCB(cbPaidKind);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select ContractKind.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , ContractKind.ContractKindName as ObjectName');
        Add('     , ContractKind.Id_Postgres as Id_Postgres');
        Add('from dba.ContractKind');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_contractkind';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.ContractKind set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbContractKind);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadJuridicalGroup;
begin
     if (not cbJuridicalGroup.Checked)or(not cbJuridicalGroup.Enabled) then exit;
     //
     myEnabledCB(cbJuridicalGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id1_Postgres as Id_Postgres');
        Add('     , Unit_parent.Id1_Postgres as ParentId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = Unit.ParentId');
        Add('where Unit.HasChildren <> zc_hsLeaf() and (Unit.Id in (151'  // ���
                                                                +', 5354' // FLOATER
                                                                +', 4219' // �������� ����� �2
                                                                +', 28'   // ����� �� �������
                                                                +', 3504' // ����������-���
                                                                +', 152'  // ����������-���
                                                                +', 4418' // ����������-���. ��������
                                                                +' )'
           +'                                        or Unit.ParentId in(3504' // ����������-���
                                                                     +', 152'  // ����������-���
                                                                     +' ))');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_juridicalgroup';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inParentId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             //toStoredProc.Parameters.ParamByName('inJuridicalGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id1_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbJuridicalGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadJuridical;
begin
     if (not cbJuridical.Checked)or(not cbJuridical.Enabled) then exit;
     //
     myEnabledCB(cbJuridical);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , Unit.UnitCode as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id2_Postgres as Id_Postgres');
        Add('     , case when Unit_parent1.Id1_Postgres is not null then Unit_parent1.Id1_Postgres');
        Add('            when Unit_parent2.Id1_Postgres is not null then Unit_parent2.Id1_Postgres');
        Add('            when Unit_parent3.Id1_Postgres is not null then Unit_parent3.Id1_Postgres');
        Add('            when Unit_parent4.Id1_Postgres is not null then Unit_parent4.Id1_Postgres');
        Add('            when Unit_parent5.Id1_Postgres is not null then Unit_parent5.Id1_Postgres');
        Add('            when Unit_parent6.Id1_Postgres is not null then Unit_parent6.Id1_Postgres');
        Add('            when Unit_parent7.Id1_Postgres is not null then Unit_parent7.Id1_Postgres');
        Add('            when Unit_parent8.Id1_Postgres is not null then Unit_parent8.Id1_Postgres');
        Add('            when Unit_parent9.Id1_Postgres is not null then Unit_parent9.Id1_Postgres');
        Add('            else Unit_parentAll.Id1_Postgres');
        Add('       end as ParentId_Postgres');
        Add('     , GoodsProperty_PG.Id_Postgres as GoodsPropertyId_PG');
        Add('     , isnull(zf_ChangeTVarCharMediumToNull(ClientInformation.GLNMain),ClientInformation.GLN) as GLNCode');
        Add('from dba.Unit as Unit_all');
        Add('     join dba.Unit on Unit.Id = isnull(zf_ChangeIntToNull(Unit_all.DolgByUnitID), isnull(zf_ChangeIntToNull(Unit_all.InformationFromUnitID), Unit_all.Id))');
        Add('     left outer join dba.GoodsProperty_Postgres as GoodsProperty_PG on GoodsProperty_PG.Id= case when fIsClient_ATB(Unit.Id)=zc_rvYes() then 1'
                                                                                                       +'    when fIsClient_OK(Unit.Id)=zc_rvYes() then 2'
                                                                                                       +'    when fIsClient_Metro(Unit.Id)=zc_rvYes() then 3'
                                                                                                       +'    when fIsClient_Fozzi(Unit.Id)=zc_rvYes() or fIsClient_FozziM(Unit.Id)=zc_rvYes() then 5'
                                                                                                       +'    when fIsClient_Kisheni(Unit.Id)=zc_rvYes() then 6'
                                                                                                       +'    when fIsClient_Vivat(Unit.Id)=zc_rvYes() then 7'
                                                                                                       +'    when fIsClient_Billa(Unit.Id)=zc_rvYes() then 8'
                                                                                                       +'    when fIsClient_Amstor(Unit.Id)=zc_rvYes() then 9'
                                                                                                       +'    when fIsClient_Omega(Unit.Id)=zc_rvYes() then 10'
                                                                                                       +'    when fIsClient_Vostorg(Unit.Id)=zc_rvYes() then 11'
                                                                                                       +'    when fIsClient_Ashan(Unit.Id)=zc_rvYes() then 12'
                                                                                                       +'    when fIsClient_Real(Unit.Id)=zc_rvYes() then 13'
                                                                                                       +'    when fIsClient_GD(Unit.Id)=zc_rvYes() then 14'
                                                                                                       +'    else null'
                                                                                                       +' end'
            );
        Add('     left outer join dba.Unit as Unit_parentAll on Unit_parentAll.Id = 151'); // ���
        Add('     left outer join dba.Unit as Unit_parent1 on Unit_parent1.Id = Unit.ParentId');
        Add('     left outer join dba.Unit as Unit_parent2 on Unit_parent2.Id = Unit_parent1.ParentId');
        Add('     left outer join dba.Unit as Unit_parent3 on Unit_parent3.Id = Unit_parent2.ParentId');
        Add('     left outer join dba.Unit as Unit_parent4 on Unit_parent4.Id = Unit_parent3.ParentId');
        Add('     left outer join dba.Unit as Unit_parent5 on Unit_parent5.Id = Unit_parent4.ParentId');
        Add('     left outer join dba.Unit as Unit_parent6 on Unit_parent6.Id = Unit_parent5.ParentId');
        Add('     left outer join dba.Unit as Unit_parent7 on Unit_parent7.Id = Unit_parent6.ParentId');
        Add('     left outer join dba.Unit as Unit_parent8 on Unit_parent8.Id = Unit_parent7.ParentId');
        Add('     left outer join dba.Unit as Unit_parent9 on Unit_parent9.Id = Unit_parent8.ParentId');
        Add('     left outer join dba.ClientInformation on ClientInformation.ClientId = isnull( zf_ChangeIntToNull( Unit_all.InformationFromUnitID), Unit_all.Id)');
        Add('where Unit.Id1_Postgres is null'
           +'  and isnull(Unit.findGoodsCard,zc_rvNo()) = zc_rvNo()'
           +'  and fCheckUnitClientParentID(3,Unit.Id)=zc_rvNo()'    // ����
           +'  and fCheckUnitClientParentID(3714,Unit.Id)=zc_rvNo()' // ����-������
           +'  and fCheckUnitClientParentID(3531,Unit.Id)=zc_rvNo()' // � ��*
           +'  and fCheckUnitClientParentID(3349,Unit.Id)=zc_rvNo()' // ���
           +'  and fCheckUnitClientParentID(600,Unit.Id)=zc_rvNo()'  // ��������
           +'  and fCheckUnitClientParentID(149,Unit.Id)=zc_rvNo()'  // ������� ������������
           );
        Add('group by ObjectId');
        Add('       , ObjectName');
        Add('       , ObjectCode');
        Add('       , Id_Postgres');
        Add('       , ParentId_Postgres');
        Add('       , GoodsPropertyId_PG');
        Add('       , GLNCode');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_juridical';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inGLNCode').Value:=FieldByName('GLNCode').AsString;
             toStoredProc.Parameters.ParamByName('inIsCorporate').Value:=false;
             toStoredProc.Parameters.ParamByName('inJuridicalGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inJuridicalGroupId').Value:=FieldByName('GoodsPropertyId_PG').AsInteger;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id2_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbJuridical);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadPartner;
begin
     if (not cbPartner.Checked)or(not cbPartner.Enabled) then exit;
     //
     myEnabledCB(cbPartner);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , Unit.UnitCode as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id3_Postgres as Id_Postgres');
        Add('     , Unit_Juridical.Id2_Postgres as JuridicalId_Postgres');
        Add('     , ClientInformation.GLN as GLNCode');
        Add('from dba.Unit');
        Add('     left outer join dba.Unit as Unit_Juridical on Unit_Juridical.Id = isnull(zf_ChangeIntToNull( Unit.DolgByUnitID), isnull(zf_ChangeIntToNull( Unit.InformationFromUnitID), Unit.Id))');
        Add('     left outer join dba.ClientInformation on ClientInformation.ClientId = Unit.Id');
        Add('where Unit.Id1_Postgres is null'
           +'  and isnull(Unit.findGoodsCard,zc_rvNo()) = zc_rvNo()'
           +'  and fCheckUnitClientParentID(3,Unit.Id)=zc_rvNo()'    // ����
           +'  and fCheckUnitClientParentID(3714,Unit.Id)=zc_rvNo()' // ����-������
           +'  and fCheckUnitClientParentID(3531,Unit.Id)=zc_rvNo()' // � ��*
           +'  and fCheckUnitClientParentID(3349,Unit.Id)=zc_rvNo()' // ���
           +'  and fCheckUnitClientParentID(600,Unit.Id)=zc_rvNo()'  // ��������
           +'  and fCheckUnitClientParentID(149,Unit.Id)=zc_rvNo()'  // ������� ������������
           );
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_partner';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inGLNCode').Value:=FieldByName('GLNCode').AsString;
             toStoredProc.Parameters.ParamByName('inJuridicalId').Value:=FieldByName('JuridicalId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id3_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbPartner);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadUnitGroup;
begin
     if (not cbUnitGroup.Checked)or(not cbUnitGroup.Enabled) then exit;
     //
     myEnabledCB(cbUnitGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id1_Postgres as Id_Postgres');
        Add('     , case when Unit.Id in (3, 3714) then 0 else Unit_parent.Id1_Postgres end as ParentId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.isUnit on isUnit.UnitId = Unit.Id');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = Unit.ParentId');
        Add('where (fCheckUnitClientParentID(3,Unit.Id)=zc_rvYes()'    // ����
           +'    or fCheckUnitClientParentID(3714,Unit.Id)=zc_rvYes()' // ����-������
           +'      )');
        Add('  and isUnit.UnitId is null');
        Add('  and Unit.Id not in (4417' // ����������� ��������-�����
                               +' ,4137' // �� ����-���
                               +' ,4927' // ����� �������
                               +' ,4931' // ����� ������� �����
                               +' ,3487' // ����� �������� ����
                               +' )');
        Add('  and Unit.ParentId <> 4137'); // MO
        Add('  and Unit.Erased=zc_ErasedVis()');
        Add('  and Unit.HasChildren<>zc_hsLeaf()');

        Add('union all');

        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , '+FormatToVarCharServer_notNULL('��� ����������� � �������')+' as ObjectName');
        Add('     , Unit.Id3_Postgres as Id_Postgres');
        Add('     , 0 as ParentId_Postgres');
        Add('from dba.Unit');
        Add('where Unit.Id = 151'); // ���
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_unitgroup';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inParentId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             //toStoredProc.Parameters.ParamByName('inUnitGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then if FieldByName('ObjectId').AsInteger=151
                  then fExecSqFromQuery('update dba.Unit set Id3_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString)
                  else fExecSqFromQuery('update dba.Unit set Id1_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbUnitGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadUnit;
begin
     if (not cbUnit.Checked)or(not cbUnit.Enabled) then exit;
     //
     myEnabledCB(cbUnit);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id2_Postgres as Id_Postgres');
        Add('     , Unit_parent.Id1_Postgres as ParentId_Postgres');
        Add('     , 0 as BranchId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.isUnit on isUnit.UnitId = Unit.Id');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = Unit.ParentId');
        Add('where (fCheckUnitClientParentID(3,Unit.Id)=zc_rvYes()'    // ����
           +'    or fCheckUnitClientParentID(3714,Unit.Id)=zc_rvYes()' // ����-������
           +'      )');
        Add('  and (isUnit.UnitId is not null or Unit.Id in (3487))'); // ����� �������� ����
//        Add('  and Unit.Erased=zc_ErasedVis()');

        Add('union all');

        Add('select Unit.Id as ObjectId');
        Add('     , Unit.UnitCode as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id2_Postgres as Id_Postgres');
        Add('     , Unit_parent.Id3_Postgres as ParentId_Postgres');
        Add('     , 0 as BranchId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.isUnit on isUnit.UnitId = Unit.Id');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = 151');
        Add('where fCheckUnitClientParentID(3,Unit.Id)=zc_rvNo()'    // ����
           +'  and fCheckUnitClientParentID(3714,Unit.Id)=zc_rvNo()' // ����-������
            );
        Add('  and isnull(Unit.findGoodsCard,zc_rvNo()) = zc_rvYes()');
        Add('  and isUnit.UnitId is null');
//        Add('  and Unit.Erased=zc_ErasedVis()');
        Add('order by ObjectId');

        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_unit';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inUnitGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inBranchId').Value:=FieldByName('BranchId_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id2_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbUnit);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadPriceList;
begin
     if (not cbPriceList.Checked)or(not cbPriceList.Enabled) then exit;
     //
     myEnabledCB(cbPriceList);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select PriceList_byHistory.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , PriceList_byHistory.PriceListName as ObjectName');
        Add('     , PriceList_byHistory.Id_Postgres as Id_Postgres');
        Add('from dba.PriceList_byHistory');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_pricelist';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.PriceList_byHistory set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbPriceList);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGoodsProperty;
begin
     if (not cbGoodsProperty.Checked)or(not cbGoodsProperty.Enabled) then exit;
     //
     myEnabledCB(cbGoodsProperty);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select GoodsProperty_Postgres.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , GoodsProperty_Postgres.Name_PG as ObjectName');
        Add('     , GoodsProperty_Postgres.Id_Postgres as Id_Postgres');
        Add('from dba.GoodsProperty_Postgres');
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_goodsproperty';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Parameters.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.GoodsProperty_Postgres set Id_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);//+' and Id_Postgres is null'
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbGoodsProperty);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGoodsPropertyValue;
begin
     if (not cbGoodsPropertyValue.Checked)or(not cbGoodsPropertyValue.Enabled) then exit;
     //
     myEnabledCB(cbGoodsPropertyValue);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select GoodsProperty_Detail.Id as ObjectId');
        Add('     , zc_rvYes() as zc_rvYes');

        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner)<>'+FormatToVarCharServer_notNULL('')+' then zc_rvYes() else zc_rvNo() end as is1');
        Add('     , '+FormatToVarCharServer_notNULL('')+'as ObjectName1');
        Add('     , case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)='+FormatToVarCharServer_notNULL('230365')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,13,2) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,15,2) else 0 end as Amount1');
        Add('     , case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)='+FormatToVarCharServer_notNULL('230365')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,12) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,13) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)+'+FormatToVarCharServer_notNULL('0000000')+' end as BarCode1');
        Add('     , case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)='+FormatToVarCharServer_notNULL('230365')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,17,5) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,18,5) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,8,5) end as Article1');
        Add('     , '+FormatToVarCharServer_notNULL('')+'as BarCodeGLN1');
        Add('     , '+FormatToVarCharServer_notNULL('')+'as ArticleGLN1');
        Add('     , PG1.Id_Postgres as GoodsPropertyId1');
        Add('     , GoodsProperty.Id_Postgres as GoodsId1');
        Add('     , KindPackage.Id_Postgres as GoodsKindId1');
        Add('     , GoodsProperty_Detail.Id1_Postgres as Id_Postgres1');

        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner_byKievOK)<>'+FormatToVarCharServer_notNULL('')+' then zc_rvYes() else zc_rvNo() end as is2');
        Add('     , '+FormatToVarCharServer_notNULL('')+'as ObjectName2');
        Add('     , 0 as Amount2');
        Add('     , '+FormatToVarCharServer_notNULL('')+'as BarCode2');
        Add('     , trim (GoodsProperty_Detail.GoodsCodeScaner_byKievOK) as Article2');
        Add('     , '+FormatToVarCharServer_notNULL('')+'as BarCodeGLN2');
        Add('     , '+FormatToVarCharServer_notNULL('')+'as ArticleGLN2');
        Add('     , PG2.Id_Postgres as GoodsPropertyId2');
        Add('     , GoodsProperty.Id_Postgres as GoodsId2');
        Add('     , KindPackage.Id_Postgres as GoodsKindId2');
        Add('     , GoodsProperty_Detail.Id2_Postgres as Id_Postgres2');

        Add('from dba.GoodsProperty_Detail');
        Add('     left outer join dba.GoodsProperty on GoodsProperty.Id=GoodsProperty_Detail.GoodsPropertyId');
        Add('     left outer join dba.KindPackage on KindPackage.Id=GoodsProperty_Detail.KindPackageId');
        Add('     left outer join dba.GoodsProperty_Postgres as PG1 on PG1.Id=1');
        Add('     left outer join dba.GoodsProperty_Postgres as PG2 on PG2.Id=2');
        Add('     left outer join dba.GoodsProperty_Postgres as PG3 on PG3.Id=3');
        Add('     left outer join dba.GoodsProperty_Postgres as PG4 on PG4.Id=4');
        Add('     left outer join dba.GoodsProperty_Postgres as PG5 on PG5.Id=5');
        Add('     left outer join dba.GoodsProperty_Postgres as PG6 on PG6.Id=6');
        Add('     left outer join dba.GoodsProperty_Postgres as PG7 on PG7.Id=7');
        Add('     left outer join dba.GoodsProperty_Postgres as PG8 on PG8.Id=8');
        Add('     left outer join dba.GoodsProperty_Postgres as PG9 on PG9.Id=9');
        Add('     left outer join dba.GoodsProperty_Postgres as PG10 on PG10.Id=10');
        Add('     left outer join dba.GoodsProperty_Postgres as PG11 on PG11.Id=11');
        Add('     left outer join dba.GoodsProperty_Postgres as PG12 on PG12.Id=12');
        Add('     left outer join dba.GoodsProperty_Postgres as PG13 on PG13.Id=13');
        Add('     left outer join dba.GoodsProperty_Postgres as PG14 on PG14.Id=14');
        Add('where is1=zc_rvYes()'
             +' or is2=zc_rvYes()'
           );
        Add('order by ObjectId');
        Open;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //exit;
        toStoredProc.ProcedureName:='gpinsertupdate_object_goodspropertyvalue';
        toStoredProc.Parameters.Refresh;
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             // 1
             if FieldByName('is1').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres1').AsInteger;
                       toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName1').AsString;
                       toStoredProc.Parameters.ParamByName('inAmount').Value:=FieldByName('Amount1').AsFloat;
                       toStoredProc.Parameters.ParamByName('inBarCode').Value:=FieldByName('BarCode1').AsString;
                       toStoredProc.Parameters.ParamByName('inArticle').Value:=FieldByName('Article1').AsString;
                       toStoredProc.Parameters.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN1').AsString;
                       toStoredProc.Parameters.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId1').AsString;
                       toStoredProc.Parameters.ParamByName('inGoodsId').Value:=FieldByName('GoodsId1').AsString;
                       toStoredProc.Parameters.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId1').AsString;
                       toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id1_Postgres').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id1_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                       end;
             // 2
             if FieldByName('is2').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Parameters.ParamByName('ioId').Value:=FieldByName('Id_Postgres2').AsInteger;
                       toStoredProc.Parameters.ParamByName('inName').Value:=FieldByName('ObjectName2').AsString;
                       toStoredProc.Parameters.ParamByName('inAmount').Value:=FieldByName('Amount2').AsFloat;
                       toStoredProc.Parameters.ParamByName('inBarCode').Value:=FieldByName('BarCode2').AsString;
                       toStoredProc.Parameters.ParamByName('inArticle').Value:=FieldByName('Article2').AsString;
                       toStoredProc.Parameters.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN2').AsString;
                       toStoredProc.Parameters.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId2').AsString;
                       toStoredProc.Parameters.ParamByName('inGoodsId').Value:=FieldByName('GoodsId2').AsString;
                       toStoredProc.Parameters.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId2').AsString;
                       toStoredProc.Parameters.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id1_Postgres').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id2_Postgres='+IntToStr(toStoredProc.Parameters.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                       end;
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbGoodsPropertyValue);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.FormatToVarCharServer_notNULL(_Value:string):string;
begin if trim(_Value)='' then Result:=chr(39)+''+chr(39) else Result:=chr(39)+trim(_Value)+chr(39);end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.FormatToDateServer_notNULL(_Date:TDateTime):string;
var
  Year, Month, Day: Word;
begin
     DecodeDate(_Date,Year,Month,Day);
     result:=chr(39)+IntToStr(Year)+'-'+IntToStr(Month)+'-'+IntToStr(Day)+chr(39);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.myExecToStoredProc:Boolean;
begin
     result:=false;
    toStoredProc.Prepared:=true;
     try toStoredProc.ExecProc;
     except
           //on E:EDBEngineError do begin EDB_EngineErrorMsg(E);exit;end;
           on E:EADOError do begin EADO_EngineErrorMsg(E);exit;end;

     end;
     result:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.EADO_EngineErrorMsg(E:EADOError);
begin
  MessageDlg(E.Message,mtError,[mbOK],0);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.EDB_EngineErrorMsg(E:EDBEngineError);
var
  DBError: TDBError;
begin
  DBError:=E.Errors[1];
  MessageDlg(DBError.Message,mtError,[mbOK],0);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.myEnabledCB (cb:TCheckBox);
begin
     cb.Font.Style:=[fsBold];
     cb.Font.Color:=clBlue;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.myDisabledCB (cb:TCheckBox);
begin
     cb.Font.Style:=[];
     cb.Font.Color:=clWindowText;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.cbAllGuideClick(Sender: TObject);
var i:Integer;
begin
     for i:=0 to ComponentCount-1 do
        if (Components[i] is TCheckBox) then
          if Components[i].Tag=10
          then TCheckBox(Components[i]).Checked:=cbAllGuide.Checked;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
begin
     Gauge.Visible:=false;
     Gauge.Progress:=0;
     //
     //cbAllGuide.Checked:=true;
     //
     fStop:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
end.

{
--
-- !!!! � ���� ������ ���� ������� ����� !!!
--
alter table dba.Goods add Id_Postgres integer null;
alter table dba.GoodsProperty add Id_Postgres integer null;
alter table dba.Measure add Id_Postgres integer null;
alter table dba.KindPackage add Id_Postgres integer null;

alter table dba.MoneyKind add Id_Postgres integer null;
alter table dba.ContractKind add Id_Postgres integer null;

alter table dba.Unit add Id1_Postgres integer null;
alter table dba.Unit add Id2_Postgres integer null;
alter table dba.Unit add Id3_Postgres integer null;

alter table dba.PriceList_byHistory add Id_Postgres integer null;

alter table dba.GoodsProperty_Detail add Id1_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id2_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id3_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id4_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id5_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id6_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id7_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id8_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id9_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id10_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id11_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id12_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id13_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id14_Postgres integer null;

create table dba.GoodsProperty_Postgres (Id integer not null, Name_PG TVarCharMedium not null, Id_Postgres integer null);
insert into dba.GoodsProperty_Postgres (Id, Name_PG)
  select 1, '���' union all       // +fIsClient_ATB
  select 2, '���� ��' union all   // +fIsClient_OK
  select 3, '�����' union all     // +fIsClient_Metro
  select 4, '����' union all      //
  select 5, '�����' union all     // +fIsClient_Fozzi fIsClient_FozziM
  select 6, '������' union all    // +fIsClient_Kisheni
  select 7, '�����' union all     // +fIsClient_Vivat
  select 8, '�����' union all     // +fIsClient_Billa
  select 9, '������' union all    // +fIsClient_Amstor
  select 10, '�����' union all    // ***fIsClient_Omega
  select 11, '�������' union all  // ***fIsClient_Vostorg
  select 12, '����' union all     // +fIsClient_Ashan
  select 13, '����' union all     // +fIsClient_Real
  select 14, '��';                // ***fIsClient_GD
                                  // fIsClient_Furshet
                                  // fIsClient_Obgora
                                  // fIsClient_Tavriya

--
--!!!! ��� ������ �������� ������ � ��������, � ������ ���� �������� ����� !!!
--
update dba.Goods set Id_Postgres = null;
update dba.GoodsProperty set Id_Postgres = null;
update dba.Measure set Id_Postgres = null;
update dba.KindPackage set Id_Postgres = null;

update dba.MoneyKind set Id_Postgres = null;
update dba.ContractKind set Id_Postgres = null;

update dba.Unit set Id1_Postgres = null, Id2_Postgres = null, Id3_Postgres = null;

update dba.PriceList_byHistory set Id_Postgres = null;

update dba.GoodsProperty_Postgres set Id_Postgres = null;
update dba.GoodsProperty_Detail set Id1_Postgres = null, Id2_Postgres = null, Id3_Postgres = null, Id4_Postgres = null, Id5_Postgres = null, Id6_Postgres = null, Id7_Postgres = null, Id8_Postgres = null, Id9_Postgres = null, Id10_Postgres = null, Id11_Postgres = null, Id12_Postgres = null, Id13_Postgres = null, Id14_Postgres = null;

}