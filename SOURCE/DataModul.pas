unit DataModul;

interface

uses
  SysUtils, Classes, ImgList, Controls, frxClass;

type

  {����� �������� ���������� � ����������}
  TdmMain = class(TDataModule)
    ImageList: TImageList;
    MainImageList: TImageList;
    TreeImageList: TImageList;
    frxReport: TfrxReport;
  end;

var dmMain: TdmMain;
implementation

{$R *.dfm}

end.
