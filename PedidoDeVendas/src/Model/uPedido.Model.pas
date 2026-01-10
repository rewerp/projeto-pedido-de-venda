unit uPedido.Model;

interface

uses
  System.Generics.Collections;

type
  TItemPedido = class
  public
    CodigoProduto: Integer;
    Quantidade: Double;
    ValorUnitario: Currency;
    ValorTotal: Currency;
  end;

  TPedido = class
  public
    NumeroPedido: Integer;
    CodigoCliente: Integer;
    DataEmissao: TDateTime;
    ValorTotal: Currency;
    Observacao: string;
    Itens: TObjectList<TItemPedido>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  Itens := TObjectList<TItemPedido>.Create;
end;

destructor TPedido.Destroy;
begin
  Itens.Free;
  inherited;
end;

end.
