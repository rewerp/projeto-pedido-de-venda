unit uDMConnection;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,
  FireDAC.Comp.Client,
  Data.DB,
  Vcl.Dialogs;

type
  TDMConnection = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  DMConnection: TDMConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMConnection }

procedure TDMConnection.DataModuleCreate(Sender: TObject);
var
  LPath: string;
  LIni: TIniFile;
begin
  LPath := ExtractFilePath(ParamStr(0));
  LIni := TIniFile.Create(LPath + 'config.ini');

  try
    try
      FDConnection.Params.Clear;
      FDConnection.Params.DriverID := 'FB';
      FDConnection.Params.Database := LIni.ReadString('Configuracao', 'Database', '');
      FDConnection.Params.UserName := LIni.ReadString('Configuracao', 'Username', 'SYSDBA');
      FDConnection.Params.Password := LIni.ReadString('Configuracao', 'Password', 'masterkey');
      FDConnection.Params.Values['Server'] := LIni.ReadString('Configuracao', 'Server', 'localhost');
      FDConnection.Params.Values['Port'] := LIni.ReadString('Configuracao', 'Port', '3050');

      FDPhysFBDriverLink.VendorLib := LIni.ReadString('Configuracao', 'ClientLibrary', LPath + 'fbclient.dll');

      FDConnection.Connected := True;
    except
      on E: Exception do
      begin
        raise Exception.Create('Falha ao conectar ao banco de dados: ' + sLineBreak + sLineBreak + E.Message);
      end;
    end;
  finally
    LIni.Free;
  end;
end;

end.
