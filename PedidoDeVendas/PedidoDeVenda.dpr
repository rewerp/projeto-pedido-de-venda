program PedidoDeVenda;

uses
  Vcl.Forms,
  fmPrincipal in 'fmPrincipal.pas' {FormPrincipal},
  uPedido.Model in 'src\Model\uPedido.Model.pas',
  uPedido.Repository in 'src\Repository\uPedido.Repository.pas',
  uPedido.Service in 'src\Service\uPedido.Service.pas',
  uDMConnection in 'src\DataConnection\uDMConnection.pas' {DMConnection: TDataModule},
  uProduto.Model in 'src\Model\uProduto.Model.pas',
  uCliente.Model in 'src\Model\uCliente.Model.pas',
  uCliente.Service in 'src\Service\uCliente.Service.pas',
  uCliente.Repository in 'src\Repository\uCliente.Repository.pas',
  uProduto.Repository in 'src\Repository\uProduto.Repository.pas',
  uProduto.Service in 'src\Service\uProduto.Service.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConnection, DMConnection);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
