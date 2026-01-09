unit uProduto.Repository;

interface

uses
  uProduto.Model,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  System.SysUtils;

type
  TProdutoRepository = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetProduto(ACodigoProduto: Integer): TProduto;
  end;

implementation

{ TProdutoRepository }

constructor TProdutoRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TProdutoRepository.GetProduto(ACodigoProduto: Integer): TProduto;
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);

  try
    LQuery.Connection := FConnection;

    LQuery.SQL.Add('SELECT');
    LQuery.SQL.Add('	CODIGO,');
    LQuery.SQL.Add('	DESCRICAO,');
    LQuery.SQL.Add('	PRECO_VENDA');
    LQuery.SQL.Add('FROM PRODUTO');
    LQuery.SQL.Add('WHERE CODIGO = :codigoProduto');

    LQuery.ParamByName('codigoProduto').AsInteger := ACodigoProduto;

    LQuery.Open();

    Result := TProduto.Create(
      LQuery.FieldByName('CODIGO').AsInteger,
      LQuery.FieldByName('DESCRICAO').AsString,
      LQuery.FieldByName('PRECO_VENDA').AsCurrency);
  finally
    LQuery.Free;
  end;
end;

end.
