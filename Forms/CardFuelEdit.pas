unit CardFuelEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ParentForm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, Vcl.Menus, dsdAddOn, cxPropertiesStore,
  dsdDB, dsdAction, Vcl.ActnList, cxCurrencyEdit, Vcl.StdCtrls, cxButtons,
  cxLabel, cxTextEdit, dsdGuides, cxMaskEdit, cxButtonEdit;

type
  TCardFuelEditForm = class(TParentForm)
    edCardFuelName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    ���: TcxLabel;
    ceCode: TcxCurrencyEdit;
    ActionList: TActionList;
    dsdDataSetRefresh: TdsdDataSetRefresh;
    dsdFormClose1: TdsdFormClose;
    spInsertUpdate: TdsdStoredProc;
    dsdFormParams: TdsdFormParams;
    spGet: TdsdStoredProc;
    cxPropertiesStore: TcxPropertiesStore;
    dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn;
    dsdInsertUpdateGuides: TdsdInsertUpdateGuides;
    cePersonalDriver: TcxButtonEdit;
    cxLabel7: TcxLabel;
    PersonalDriverGuides: TdsdGuides;
    cxLabel2: TcxLabel;
    ceCar: TcxButtonEdit;
    CarGuides: TdsdGuides;
    cxLabel3: TcxLabel;
    cePaidKind: TcxButtonEdit;
    PaidKindGuides: TdsdGuides;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    ceJuridical: TcxButtonEdit;
    ceGoods: TcxButtonEdit;
    JuridicalGuides: TdsdGuides;
    GoodsGuides: TdsdGuides;

  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

initialization
  RegisterClass(TCardFuelEditForm);

end.