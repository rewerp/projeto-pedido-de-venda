unit uCliente.Model;

interface

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: string;
    FCidade: string;
    FUF: string;
  public
    constructor Create(ACodigo: Integer; ANome, ACidade, AUF: String);

    property getCodigo: Integer read FCodigo;
    property getNome: string read FNome;
    property getCidade: string read FCidade;
    property getUF: string read FUF;
  end;

implementation

{ TCliente }

constructor TCliente.Create(ACodigo: Integer; ANome, ACidade, AUF: String);
begin
  FCodigo := ACodigo;
  FNome := ANome;
  FCidade := ACidade;
  FUF := AUF;
end;

end.
