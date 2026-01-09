unit uProduto.Service;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  uProduto.Repository,
  uProduto.Model;

type
  TProdutoService = class
  private
    FRepository: TProdutoRepository;
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    function GetProduto(ACodigoProduto: Integer): TProduto;
  end;

implementation

{ TProdutoService }

constructor TProdutoService.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
  FRepository := TProdutoRepository.Create(FConnection);
end;

destructor TProdutoService.Destroy;
begin
  FRepository.Free;
  inherited;
end;

function TProdutoService.GetProduto(ACodigoProduto: Integer): TProduto;
begin
  Exit(FRepository.GetProduto(ACodigoProduto));
end;

end.
