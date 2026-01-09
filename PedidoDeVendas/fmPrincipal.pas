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
    DBGrid1: TDBGrid;
    lbPrecoTotalPedido: TLabel;
    lbPrecoTotalPedidoValor: TLabel;
    procedure btInserirAtualizarClick(Sender: TObject);
    procedure btGravarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoProdutoExit(Sender: TObject);
  private
    { Private declarations }
    FPedidoService: TPedidoService;
    FItensPedido: TFDMemTable;
    procedure ExcluirItem();
    procedure AtualizarTotalPedido();
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
  FItensPedido.First;

  while not FItensPedido.Eof do
  begin
    LTotal := LTotal + FItensPedido.FieldByName('VLR_TOTAL').AsCurrency;
    FItensPedido.Next;
  end;

  lbPrecoTotalPedidoValor.Caption := FormatCurr('#,##0.00', LTotal);
end;

procedure TFormPrincipal.btGravarPedidoClick(Sender: TObject);
begin
  ShowMessage('Teste de "Gravar Pedido"');
end;

procedure TFormPrincipal.btInserirAtualizarClick(Sender: TObject);
begin
  ShowMessage('Teste de "Incluir/Atualizar"');
end;

procedure TFormPrincipal.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ShowMessage('Teste de "Alterar item"');
    VK_DELETE: ShowMessage('Teste de "Excluir item"');
  else
    Exit();
  end;
end;

procedure TFormPrincipal.edtCodigoClienteExit(Sender: TObject);
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

//    ShowMessage('Teste de "Pesquisar Cliente"');
  end;
end;

procedure TFormPrincipal.edtCodigoProdutoExit(Sender: TObject);
var
  LProdutoService: TProdutoService;
  LProduto: TProduto;
begin
  if (not (trim(edtCodigoProduto.Text) = EmptyStr)) then
  begin
    LProdutoService := TProdutoService.Create(DMConnection.FDConnection);
    LProduto := LProdutoService.GetProduto(StrToInt(edtCodigoProduto.Text));

    edtDescricaoProduto.Text := LProduto.getDescricao;
    edtPrecoUnitarioProduto.Text := CurrToStr(LProduto.getPrecoVenda);

    ShowMessage('Teste de "Pesquisar Produto"');
  end;
end;

procedure TFormPrincipal.ExcluirItem;
begin
  if not FItensPedido.IsEmpty then
  begin
    if MessageDlg('Deseja excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FItensPedido.Delete;
      AtualizarTotalPedido;
    end;
  end;
end;

end.
