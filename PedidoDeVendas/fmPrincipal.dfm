object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Pedido de Venda'
  ClientHeight = 750
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object gbDadosCliente: TGroupBox
    Left = 8
    Top = 8
    Width = 737
    Height = 129
    Caption = 'Dados do Cliente'
    TabOrder = 0
    object edtCodigoCliente: TLabeledEdit
      Left = 24
      Top = 41
      Width = 105
      Height = 23
      EditLabel.Width = 96
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo do Cliente'
      TabOrder = 0
      Text = ''
      OnExit = edtCodigoClienteExit
    end
    object edtNomeCliente: TLabeledEdit
      Left = 144
      Top = 41
      Width = 553
      Height = 23
      TabStop = False
      EditLabel.Width = 90
      EditLabel.Height = 15
      EditLabel.Caption = 'Nome do Cliente'
      ReadOnly = True
      TabOrder = 1
      Text = ''
    end
    object edtCidadeCliente: TLabeledEdit
      Left = 24
      Top = 89
      Width = 241
      Height = 23
      TabStop = False
      EditLabel.Width = 37
      EditLabel.Height = 15
      EditLabel.Caption = 'Cidade'
      ReadOnly = True
      TabOrder = 2
      Text = ''
    end
    object edtUFCliente: TLabeledEdit
      Left = 280
      Top = 89
      Width = 65
      Height = 23
      TabStop = False
      EditLabel.Width = 14
      EditLabel.Height = 15
      EditLabel.Caption = 'UF'
      ReadOnly = True
      TabOrder = 3
      Text = ''
    end
  end
  object gbDadosProduto: TGroupBox
    Left = 8
    Top = 143
    Width = 737
    Height = 130
    Caption = 'Dados do Produto'
    TabOrder = 1
    object edtCodigoProduto: TLabeledEdit
      Left = 24
      Top = 41
      Width = 105
      Height = 23
      EditLabel.Width = 102
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo do Produto'
      TabOrder = 0
      Text = ''
      OnExit = edtCodigoProdutoExit
    end
    object edtDescricaoProduto: TLabeledEdit
      Left = 144
      Top = 41
      Width = 553
      Height = 23
      TabStop = False
      EditLabel.Width = 114
      EditLabel.Height = 15
      EditLabel.Caption = 'Descri'#231#227'o do Produto'
      ReadOnly = True
      TabOrder = 1
      Text = ''
    end
    object edtPrecoUnitarioProduto: TLabeledEdit
      Left = 144
      Top = 88
      Width = 225
      Height = 23
      EditLabel.Width = 99
      EditLabel.Height = 15
      EditLabel.Caption = 'Pre'#231'o Unit'#225'rio (R$)'
      TabOrder = 3
      Text = ''
    end
    object edtQuantidadeProduto: TLabeledEdit
      Left = 24
      Top = 88
      Width = 105
      Height = 23
      EditLabel.Width = 62
      EditLabel.Height = 15
      EditLabel.Caption = 'Quantidade'
      TabOrder = 2
      Text = ''
    end
    object btInserirAtualizar: TButton
      Left = 552
      Top = 86
      Width = 145
      Height = 25
      Caption = 'Inserir / Atualizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btInserirAtualizarClick
    end
  end
  object btGravarPedido: TButton
    Left = 8
    Top = 697
    Width = 737
    Height = 41
    Caption = 'Gravar Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btGravarPedidoClick
  end
  object gbItensPedido: TGroupBox
    Left = 8
    Top = 279
    Width = 737
    Height = 402
    Caption = 'Itens do Pedido'
    TabOrder = 3
    DesignSize = (
      737
      402)
    object lbPrecoTotalPedido: TLabel
      Left = 348
      Top = 368
      Width = 206
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = 'Pre'#231'o Total do Pedido (R$):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 220
      ExplicitTop = 328
    end
    object lbPrecoTotalPedidoValor: TLabel
      Left = 560
      Top = 368
      Width = 162
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '1.000,50'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 432
      ExplicitTop = 328
    end
    object DBGrid1: TDBGrid
      Left = 5
      Top = 24
      Width = 726
      Height = 338
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyUp = DBGrid1KeyUp
    end
  end
end
