unit connection.model;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,  FireDAC.Stan.Error, FireDAC.UI.Intf,
     FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
     FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.SysUtils,
     FireDAC.Phys.MSSQL;

type
  TConnection = class
    private
      FConexao: TFDConnection;
      FTransacao: TFDTransaction;

    public
      constructor Create;
      destructor Destroy; override;
      function GetConexao: TFDConnection;
      function CriarQuery: TFDQuery;
      function CriarDataSource: TDataSource;
      function CriarTransaction: TFDTransaction;
      function TestarConexao: Boolean;
      procedure InciarTransacao;

  end;

implementation

uses Vcl.Dialogs;

{ TConnection }

constructor TConnection.Create;
var FDPhysMSSQL: TFDPhysMSSQLDriverLink;
begin
  inherited Create;
  FDPhysMSSQL := TFDPhysMSSQLDriverLink.Create(nil);

  // Cria Conex�o
  FConexao := TFDConnection.Create(nil);
  FConexao.Params.DriverID := 'MSSQL';
  FConexao.Params.Database := 'BDTESTE';
  FConexao.Params.UserName := 'SA';
  FConexao.Params.Password := 'info';
  FConexao.Params.Add('ADDRESS=PC-ALVARO\SQLEXPRESS');
  FConexao.LoginPrompt := False;


  // Cria e associa transa��o � conex�o
  FTransacao := TFDTransaction.Create(nil);
  FTransacao.Connection := FConexao;
  FConexao.Transaction := FTransacao;  // Associa transa��o � conex�o


  // Tenta conectar
  TestarConexao;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;

end;

function TConnection.GetConexao: TFDConnection;
begin
  Result := FConexao;
end;

function TConnection.CriarQuery: TFDQuery;
var Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConexao;
  Query.Transaction := FTransacao;
  Result := Query;
end;

function TConnection.CriarDataSource: TDataSource;
var DataSource: TDataSource;
begin
  DataSource := TDataSource.Create(nil);
  Result := DataSource;
end;

function TConnection.CriarTransaction: TFDTransaction;
begin
  Result := FTransacao;
end;

function TConnection.TestarConexao: Boolean;
begin
  Result := False;
  try
    FConexao.Connected := True;
    Result := FConexao.Connected;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao conectar: ' + E.Message);
    end;
  end;
end;

procedure TConnection.InciarTransacao;
begin
  // Verifica se a transa��o j� foi iniciada
  if not FTransacao.Active then
  begin
    FTransacao.Connection := FConexao;  // Certifique-se de que a transa��o est� associada
    FTransacao.StartTransaction;        // Inicia a transa��o
  end;
end;

end.
