program testeViasoftMVC;

uses
  Vcl.Forms,
  umain in 'View\umain.pas' {FrmMain},
  UCadastroPadrao in 'View\UCadastroPadrao.pas' {FrmCadastroPadrao},
  ucadproduto in 'View\ucadproduto.pas' {FrmCadProduto},
  connection.model in 'Model\connection.model.pas',
  conexao.model in 'Model\conexao.model.pas',
  produto.model in 'Model\produto.model.pas',
  produtorepository.model in 'Model\produtorepository.model.pas',
  produto.controller in 'Controller\produto.controller.pas',
  venda.controller in 'Controller\venda.controller.pas',
  venda.model in 'Model\venda.model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmCadastroPadrao, FrmCadastroPadrao);
  Application.CreateForm(TFrmCadProduto, FrmCadProduto);
  Application.Run;
end.
