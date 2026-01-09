unit uCliente.Service;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  uCliente.Repository,
  uCliente.Model;

type
  TClienteService = class
  private
    FRepository: TClienteRepository;
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    function GetCliente(ACodigoCliente: Integer): TCliente;
  end;

implementation

{ TPedidoService }

constructor TClienteService.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
  FRepository := TClienteRepository.Create(FConnection);
end;

destructor TClienteService.Destroy;
begin
  FRepository.Free;
  inherited;
end;

function TClienteService.GetCliente(ACodigoCliente: Integer): TCliente;
begin
  Exit(FRepository.GetCliente(ACodigoCliente));
end;

end.
