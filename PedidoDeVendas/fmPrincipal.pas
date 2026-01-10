unit fmPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  FireDAC.Comp.Client,
  uDMConnection,
  uPedido.Model,
  uPedido.Service,
  uCliente.Service,
  uCliente.Model,
  uProduto.Service,
  uProduto.Model;

type
  TFormPrincipal = class(TForm)
    gbDadosCliente: TGroupBox;
    edtCodigoCliente: TLabeledEdit;
    edtNomeCliente: TLabeledEdit;
    edtCidadeCliente: TLabeledEdit;
    edtUFCliente: TLabeledEdit;
    gbDadosProduto: TGroupBox;
    edtCodigoProduto: TLabeledEdit;
    edtDescricaoProduto: TLabeledEdit;
    edtPrecoUnitarioProduto: TLabeledEdit;
    edtQuantidadeProduto: TLabeledEdit;
    btInserirAtualizar: TButton;
    btGravarPedido: TButton;
    gbItensPedido: TGroupBox;
    dbgItensPedido: TDBGrid;
    lbPrecoTotalPedidoValor: TLabel;
    lbPrecoTotalPedido: TLabel;
    procedure btInserirAtualizarClick(Sender: TObject);
    procedure btGravarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure dbgItensPedidoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoClienteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQuantidadeProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoUnitarioProdutoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FmtItensPedido: TFDMemTable;
    FdsItensPedido: TDataSource;
    procedure ConfigurarMemTable();
    procedure ExcluirItem();
    procedure AtualizarTotalPedido();
    procedure LimparCamposProduto();
    procedure CarregarProdutoParaEdicao();
    procedure CarregarDadosCliente();
    procedure CarregarDadosProduto();
    procedure FinalizarPedido();
    function PrepararFinalizacaoPedido(): TPedido;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

{ TFormPrincipal }

procedure TFormPrincipal.AtualizarTotalPedido;
var
  LTotal: Currency;
begin
  LTotal := 0;
  FmtItensPedido.First;

  while not FmtItensPedido.Eof do
  begin
    LTotal := LTotal + FmtItensPedido.FieldByName('ValorTotal').AsCurrency;
    FmtItensPedido.Next;
  end;

  lbPrecoTotalPedidoValor.Caption := FormatCurr('#,##0.00', LTotal);
end;

procedure TFormPrincipal.btGravarPedidoClick(Sender: TObject);
begin
  FinalizarPedido();
end;

procedure TFormPrincipal.btInserirAtualizarClick(Sender: TObject);
begin
  if ((trim(edtCodigoProduto.Text) = EmptyStr) or (StrToFloatDef(edtQuantidadeProduto.Text, 0) <= 0)) then
  begin
    ShowMessage('Informe o produto e a quantidade.');
    Exit();
  end;

  if not (FmtItensPedido.State in [dsEdit, dsInsert]) then
    FmtItensPedido.Append()
  else
    FmtItensPedido.Edit();

  FmtItensPedido.FieldByName('CodigoProduto').AsInteger := StrToInt(edtCodigoProduto.Text);
  FmtItensPedido.FieldByName('Descricao').AsString := edtDescricaoProduto.Text;
  FmtItensPedido.FieldByName('Quantidade').AsFloat := StrToFloat(edtQuantidadeProduto.Text);
  FmtItensPedido.FieldByName('ValorUnitario').AsCurrency :=
    StrToCurr(StringReplace(edtPrecoUnitarioProduto.Text, '.', '', [rfReplaceAll]));

  FmtItensPedido.FieldByName('ValorTotal').AsCurrency :=
    FmtItensPedido.FieldByName('Quantidade').AsFloat * FmtItensPedido.FieldByName('ValorUnitario').AsCurrency;

  FmtItensPedido.Post();

  AtualizarTotalPedido();
  LimparCamposProduto();
end;

procedure TFormPrincipal.ConfigurarMemTable;
begin
  FmtItensPedido := TFDMemTable.Create(Self);
  FdsItensPedido := TDataSource.Create(Self);
  FdsItensPedido.DataSet := FmtItensPedido;

  dbgItensPedido.DataSource := FdsItensPedido;

  FmtItensPedido.FieldDefs.Clear;
  FmtItensPedido.FieldDefs.Add('CodigoProduto', ftInteger);
  FmtItensPedido.FieldDefs.Add('Descricao', ftString, 60);
  FmtItensPedido.FieldDefs.Add('Quantidade', ftFloat);
  FmtItensPedido.FieldDefs.Add('ValorUnitario', ftCurrency);
  FmtItensPedido.FieldDefs.Add('ValorTotal', ftCurrency);

  FmtItensPedido.CreateDataSet;

  FmtItensPedido.Fields.FieldByName('CodigoProduto').DisplayLabel := 'Código Produto';
  FmtItensPedido.Fields.FieldByName('Descricao').DisplayLabel := 'Descrição';
  FmtItensPedido.Fields.FieldByName('Quantidade').DisplayLabel := 'Quantidade';
  FmtItensPedido.Fields.FieldByName('ValorUnitario').DisplayLabel := 'Preço Unitário';
  FmtItensPedido.Fields.FieldByName('ValorTotal').DisplayLabel := 'Preço Total';

  TFloatField(FmtItensPedido.FieldByName('ValorUnitario')).DisplayFormat := '###,##0.00';
  TFloatField(FmtItensPedido.FieldByName('ValorTotal')).DisplayFormat := '###,##0.00';
end;

procedure TFormPrincipal.dbgItensPedidoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: CarregarProdutoParaEdicao();
    VK_DELETE: ExcluirItem();
  else
    Exit();
  end;
end;

procedure TFormPrincipal.edtCodigoClienteExit(Sender: TObject);
begin
  CarregarDadosCliente();
end;

procedure TFormPrincipal.edtCodigoClienteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    CarregarDadosCliente();
end;

procedure TFormPrincipal.edtCodigoProdutoExit(Sender: TObject);
begin
  CarregarDadosProduto();
end;

procedure TFormPrincipal.edtCodigoProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    CarregarDadosProduto();
end;

procedure TFormPrincipal.edtPrecoUnitarioProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (CharInSet(Key, ['0'..'9', #8, ',']))) then
    Key := #0
  else if (Key = ',') and (Pos(',', TEdit(Sender).Text) > 0) then
    Key := #0;
end;

procedure TFormPrincipal.edtQuantidadeProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (CharInSet(Key, ['0'..'9', #8, ',']))) then
    Key := #0
  else if (Key = ',') and (Pos(',', TEdit(Sender).Text) > 0) then
    Key := #0;
end;

procedure TFormPrincipal.ExcluirItem;
begin
  if not FmtItensPedido.IsEmpty then
  begin
    if MessageDlg('Deseja excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FmtItensPedido.Delete;
      AtualizarTotalPedido;
    end;
  end;
end;

procedure TFormPrincipal.FinalizarPedido;
var
  LPedidoService: TPedidoService;
begin
  LPedidoService := TPedidoService.Create(DMConnection.FDConnection);
  LPedidoService.FinalizarPedido(PrepararFinalizacaoPedido());

  ShowMessage('Pedido finalizado com sucesso!');
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  ConfigurarMemTable();
end;

procedure TFormPrincipal.LimparCamposProduto;
begin
  edtCodigoProduto.Clear();
  edtDescricaoProduto.Clear();
  edtQuantidadeProduto.Clear();
  edtPrecoUnitarioProduto.Clear();

  edtQuantidadeProduto.ReadOnly := true;
  edtPrecoUnitarioProduto.ReadOnly := true;
end;

function TFormPrincipal.PrepararFinalizacaoPedido: TPedido;
var
  LItem: TItemPedido;
begin
  Result := TPedido.Create();

  try
    Result.CodigoCliente := StrToInt(edtCodigoCliente.Text);
//    Result.DataEmissao := Now();
    Result.ValorTotal := StrToCurr(Trim(StringReplace(lbPrecoTotalPedidoValor.Caption, '.', '', [rfReplaceAll])));
//    Result.Observacao := edtObservacao.Text;

    FmtItensPedido.First();

    while not FmtItensPedido.Eof do
    begin
      LItem := TItemPedido.Create();

      LItem.CodigoProduto := FmtItensPedido.FieldByName('CodigoProduto').AsInteger;
      LItem.Quantidade := FmtItensPedido.FieldByName('Quantidade').AsFloat;
      LItem.ValorUnitario := FmtItensPedido.FieldByName('ValorUnitario').AsCurrency;
      LItem.ValorTotal := FmtItensPedido.FieldByName('ValorTotal').AsCurrency;

      Result.Itens.Add(LItem);

      FmtItensPedido.Next();
    end;
  except
    Result.Free();
    raise;
  end;
end;

procedure TFormPrincipal.CarregarDadosCliente;
var
  LClienteService: TClienteService;
  LCliente: TCliente;
begin
  if (not (trim(edtCodigoCliente.Text) = EmptyStr)) then
  begin
    LClienteService := TClienteService.Create(DMConnection.FDConnection);
    LCliente := LClienteService.GetCliente(StrToInt(edtCodigoCliente.Text));

    edtNomeCliente.Text := LCliente.getNome;
    edtCidadeCliente.Text := LCliente.getCidade;
    edtUFCliente.Text := LCliente.getUF;
  end;
end;

procedure TFormPrincipal.CarregarDadosProduto;
var
  LProdutoService: TProdutoService;
  LProduto: TProduto;
begin
  if (not (trim(edtCodigoProduto.Text) = EmptyStr)) then
  begin
    LProdutoService := TProdutoService.Create(DMConnection.FDConnection);
    LProduto := LProdutoService.GetProduto(StrToInt(edtCodigoProduto.Text));

    edtDescricaoProduto.Text := LProduto.getDescricao;
    edtQuantidadeProduto.Text := '1';
    edtPrecoUnitarioProduto.Text := FormatCurr('###,##0.00', LProduto.getPrecoVenda);

    edtQuantidadeProduto.ReadOnly := false;
    edtPrecoUnitarioProduto.ReadOnly := false;
  end;
end;

procedure TFormPrincipal.CarregarProdutoParaEdicao;
begin
  if not FmtItensPedido.IsEmpty then
  begin
    edtCodigoProduto.Text := FmtItensPedido.FieldByName('CodigoProduto').AsString;
    edtDescricaoProduto.Text := FmtItensPedido.FieldByName('Descricao').AsString;
    edtQuantidadeProduto.Text := FmtItensPedido.FieldByName('Quantidade').AsString;
    edtPrecoUnitarioProduto.Text := FmtItensPedido.FieldByName('ValorUnitario').AsString;

    edtQuantidadeProduto.ReadOnly := false;
    edtPrecoUnitarioProduto.ReadOnly := false;

    FmtItensPedido.Edit();
    edtQuantidadeProduto.SetFocus();
  end;
end;

end.
