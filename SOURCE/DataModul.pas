unit DataModul;

interface

uses
  SysUtils, Classes, ImgList, Controls;

type

  {����� �������� ���������� � ����������}
  TdmMain = class(TDataModule)
    ImageList: TImageList;
    MainImageList: TImageList;
    TreeImageList: TImageList;
  end;

var dmMain: TdmMain;
implementation

{$R *.dfm}

end.
