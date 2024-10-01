unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    PanelBotoesMenu: TPanel;
    BtnSair: TSpeedButton;
    BtnVendas: TSpeedButton;
    BtnRelatorios: TSpeedButton;
    BtnProdutos: TSpeedButton;
    procedure BtnProdutosClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses conexao.model, ucadproduto;

procedure TFrmMain.BtnProdutosClick(Sender: TObject);
begin
  if not Assigned(FrmCadProduto) then
    FrmCadProduto := TFrmCadProduto.Create(Self);  // Cria o formulário

  try
    FrmCadProduto.ShowModal;  // Exibe o formulário como modal
  finally
    FreeAndNil(FrmCadProduto);  // Libera a memória corretamente ao fechar
  end;
end;

procedure TFrmMain.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
