unit uProduto.Model;

interface

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: string;
    FPrecoVenda: Currency;
  public
    constructor Create(ACodigo: Integer; ADescricao: String; APrecoVenda: Currency);

    property getCodigo: Integer read FCodigo;
    property getDescricao: string read FDescricao;
    property getPrecoVenda: Currency read FPrecoVenda;
  end;

implementation

{ TProduto }

constructor TProduto.Create(ACodigo: Integer; ADescricao: String; APrecoVenda: Currency);
begin
  FCodigo := ACodigo;
  FDescricao := ADescricao;
  FPrecoVenda := APrecoVenda;
end;

end.
