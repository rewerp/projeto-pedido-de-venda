unit uCliente.Repository;

interface

uses
  uCliente.Model,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  System.SysUtils;

type
  TClienteRepository = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetCliente(ACodigoCliente: Integer): TCliente;
  end;

implementation

{ TClienteRepository }

constructor TClienteRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TClienteRepository.GetCliente(ACodigoCliente: Integer): TCliente;
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);

  try
    LQuery.Connection := FConnection;

    LQuery.SQL.Add('SELECT');
    LQuery.SQL.Add('	CODIGO,');
    LQuery.SQL.Add('	NOME,');
    LQuery.SQL.Add('	CIDADE,');
    LQuery.SQL.Add('	UF');
    LQuery.SQL.Add('FROM CLIENTE');
    LQuery.SQL.Add('WHERE CODIGO = :codigoCliente');

    LQuery.ParamByName('codigoCliente').AsInteger := ACodigoCliente;

    LQuery.Open();

    Result := TCliente.Create(
      LQuery.FieldByName('CODIGO').AsInteger,
      LQuery.FieldByName('NOME').AsString,
      LQuery.FieldByName('CIDADE').AsString,
      LQuery.FieldByName('UF').AsString);
  finally
    LQuery.Free;
  end;
end;

end.
