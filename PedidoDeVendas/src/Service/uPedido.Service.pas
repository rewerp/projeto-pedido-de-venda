unit uPedido.Service;

interface

uses
  uPedido.Model,
  uPedido.Repository,
  FireDAC.Comp.Client,
  System.SysUtils;

type
  TPedidoService = class
  private
    FRepository: TPedidoRepository;
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    procedure FinalizarPedido(APedido: TPedido);
  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
  FRepository := TPedidoRepository.Create(FConnection);
end;

destructor TPedidoService.Destroy;
begin
  FRepository.Free;
  inherited;
end;

procedure TPedidoService.FinalizarPedido(APedido: TPedido);
begin
  FConnection.StartTransaction;

  try
    FRepository.Gravar(APedido);
    FConnection.Commit;
  except
    on E: Exception do
    begin
      FConnection.Rollback;
      raise Exception.Create('Falha ao gravar pedido: ' + E.Message);
    end;
  end;
end;

end.
