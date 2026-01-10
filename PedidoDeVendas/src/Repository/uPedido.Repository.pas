unit uPedido.Repository;

interface

uses
  uPedido.Model,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  System.SysUtils;

type
  TPedidoRepository = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure Gravar(APedido: TPedido);
    function GetProximoNumero: Integer;
  end;

implementation

{ TPedidoRepository }

constructor TPedidoRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TPedidoRepository.GetProximoNumero: Integer;
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);

  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Add('SELECT NEXT VALUE FOR RDB$8 FROM RDB$DATABASE');
    LQuery.Open();

    Result := LQuery.Fields[0].AsInteger;
  finally
    LQuery.Free;
  end;
end;

procedure TPedidoRepository.Gravar(APedido: TPedido);
var
  LQuery: TFDQuery;
  LItem: TItemPedido;
begin
  LQuery := TFDQuery.Create(nil);

  try
    LQuery.Connection := FConnection;

    LQuery.SQL.Add('INSERT INTO PEDIDO (CODIGO_CLIENTE, VALOR_TOTAL, OBSERVACAO)');
    LQuery.SQL.Add('VALUES (:cliente, :valorTotal, :observacao) RETURNING NUMERO_PEDIDO');

    LQuery.ParamByName('cliente').AsInteger := APedido.CodigoCliente;
    LQuery.ParamByName('valorTotal').AsCurrency := APedido.ValorTotal;
    LQuery.ParamByName('observacao').AsString := APedido.Observacao;
    LQuery.Open;

    APedido.NumeroPedido := LQuery.FieldByName('NUMERO_PEDIDO').AsInteger;

    LQuery.Close;
    LQuery.SQL.Clear;

    LQuery.SQL.Add('INSERT INTO PEDIDO_ITEM (NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VLR_UNITARIO, VLR_TOTAL)');
    LQuery.SQL.Add('VALUES (:numeroPedido, :codigoProduto, :quantidade, :valorUnitario, :valorTotal)');

    for LItem in APedido.Itens do
    begin
      LQuery.ParamByName('numeroPedido').AsInteger := APedido.NumeroPedido;
      LQuery.ParamByName('codigoProduto').AsInteger := LItem.CodigoProduto;
      LQuery.ParamByName('quantidade').AsFloat := LItem.Quantidade;
      LQuery.ParamByName('valorUnitario').AsCurrency := LItem.ValorUnitario;
      LQuery.ParamByName('valorTotal').AsCurrency := LItem.ValorTotal;

      LQuery.ExecSQL;
    end;
  finally
    LQuery.Free;
  end;

end;

end.
