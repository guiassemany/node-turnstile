{
*****************************************
   Programa de DEMO - MaxFinger 2
   autor: José Emídio Francelino
   Data : Julho, 11 de 2012
   Data : Setembro, 12 de 2012
   Data : Setembro, 14 de 2012
   Data : Setembro, 19 de 2012
   Data : Dezembro, 03 de 2012
******************************************
}
unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, XPCom32, ComCtrls, OleCtrls, SHDocVw,
  ExtCtrls,StrUtils, ToolWin, RichEdit, ShellAPI, ScktComp, UnitThread, Global, Suprema,
  Menus;

type
  TFmPrincipal = class(TForm)
    GB_ID: TGroupBox;           // Grupo identificação do Maxfinger 2
    GB_Arq: TGroupBox;          // Grupo identificação dos Arquivos
    GB_INF: TGroupBox;          // Grupo identificação para ajuda na WEB
    GB_Conteudo: TGroupBox;     // Grupo conteudo do arquivo
    CB_COM: TComboBox;          // Grupo auditoria
    GB_Marcas: TGroupBox;       // Grupo marcações recolhidas
    GB_WEB: TGroupBox;          // Grupo Ajuda do Sistema em HTML
    GB_Auditoria: TGroupBox;    // Grupo Auditoria HTML
    GB_Msg_Online: TGroupBox;   // Grupo Auditoria HTML
    EditIP: TEdit;              // Caixa de Texto numero IP
    EditPortaTCP: TEdit;        // Caixa de Texto Numero porta TCP
    EditColetor: TEdit;         // Caixa de texto Numero coletor
    ed_Path: TEdit;             // Caixa de texto Pasta do executavel
    Ed_Resposta: TEdit;         // Caixa de texto Texto a responder ao coletor
    PCMain: TPageControl;       // Pagina controle
    TS_AJUDA: TTabSheet;        // Aba exibe a ajuda HTML
    TS_LOG: TTabSheet;          // Tab da pagina de controle - LOG sistema
    TS_Dados: TTabSheet;        // Tab da pagina de controle - Dados
    TS_ONLINE: TTabSheet;       // Tab da pagina de controle - Dados Online
    Mm_LOG: TMemo;              // WEBBrose endereço WEB com ajuda
    SB_Fechar: TSpeedButton;    // Botao encerra TRIXConnect
    SB_Abrir: TSpeedButton;     // Botão Abrir arquivo selecionado
    SB_Assistente: TSpeedButton;// Botão executar assistente
    SB_Salva: TSpeedButton;     // Botão Salva e envia dados para o coletor
    SB_Limpa: TSpeedButton;     // Botao limpa visualização arquivo selecionado
    SB_Limpa_OnLine_Log: TSpeedButton; // Botão limpa lista OnLine
    SP_EnviaPRG: TSpeedButton;         // Botao Envia programa
    SP_AtualizaDataHora: TSpeedButton; // Botão Atualiza data e hora
    SB_Receber: TSpeedButton;          // Botão receber ARQ marcação
    SB_Responder: TSpeedButton;   // Botão envia resposta
    SB_EnviaCMD: TSpeedButton;    // Envia comando
    LBox_NomesArquivos: TListBox; // Lista informando marcação feita no coletor
    TimerOnLine: TTimer;          // Verica se responde automaticamente
    StatusBar: TStatusBar;        // informa MSG importantes
    CB_MSG: TComboBox;            // Respota ao coletor
    RichEdit: TRichEdit;          // Conteudo dos arquivos
    MemoArq: TMemo;               // Temporario transforma RTF para Texto
    LB_IP: TLabel;                // Label Informa IP
    LB_Port: TLabel;              // Label informa Programa
    LB_Coletor: TLabel;           // Label quantidade Respostas enviadas ao EQUI
    Lb_UltimoEnvio: TLabel;       // Label Informa quantos envio
    Lb_UltimoArq: TLabel;         // Label Informa quantos envio de arquivos
    Lb_TotalMarcas: TLabel;       // Label Informa quantos vezes recebeu marcação
    Lb_TotalOnLine: TLabel;       // Label Informa quantos Ficou OnLine
    Lb_TotalRespotas: TLabel;     // Label Informa Resposndeu ao coletor
    Mm_Marcas: TMemo;             // Memo com as marcações recolhidas
    ChkBxSocket: TCheckBox;       // Recebe biometria do coletor
    SocketTRX: TClientSocket;     // Componente socket como o MAXFinger 2
    WebBrowser: TWebBrowser;      // Apresenta ajuda em HTML
    LstBx_OnLine: TListBox;
    MainMenu1: TMainMenu;
    Principal1: TMenuItem;
    LOG1: TMenuItem;
    Dados1: TMenuItem;
    OnLine1: TMenuItem;
    Ajuda1: TMenuItem;
    AtualizaDataHora1: TMenuItem;
    EnviaPrograma1: TMenuItem;
    Fechar1: TMenuItem;
    Salvar1: TMenuItem;
    ReceberMarcaes1: TMenuItem;       // Teste apagar versão final

    // *******************************************************

    Procedure RecebeBiometria(ID:String);       // REcebe biometria
    Procedure Assistente(Item:integer);         //
    procedure EnviaComandoXP;                   // Envia comando XP para protocolo XPNet, coloca modo REMOTO
    procedure IdentificaDado(X,Y:integer);      // Indetifica posição na edição ARQ
    procedure ConverteArquivo(Nome:string; N:integer); // Converte: Bin<->Texto
    procedure EnviaArquivo(Nome:string; N:integer);    // Comunica: EQUI<->PC
    procedure Auditoria;                              // Auditoria
    procedure ExibeMarca(Nome:string);                // Exibe Marcas
    procedure ApagarMarcas;                           // Apaga marcações Coletor
    procedure SB_FecharClick(Sender: TObject);        // Evento fechar
    procedure SP_EnviaPRGClick(Sender: TObject);      // Evento Envia PRG
    procedure FormCreate(Sender: TObject);            // Cria Formulario *1
    procedure SB_AbrirClick(Sender: TObject);         // Evento Abrir ARQ
    procedure SB_SalvaClick(Sender: TObject);         // Evento Salva ARQ
    procedure SB_AssistenteClick(Sender: TObject);    // Evento Assistente
    procedure SB_LimpaClick(Sender: TObject);         // Evento Limpa Texto ARQ
    procedure PCMainChange(Sender: TObject);          // Evento mudança TAB
    procedure TimerOnLineTimer(Sender: TObject);      // Evento Online
    procedure SB_ResponderClick(Sender: TObject);   // Evento responder a marcas
    procedure SB_Limpa_OnLine_LogClick(Sender: TObject); // Evento limpa MARC
    procedure SP_EnviaARQClick(Sender: TObject);          // Evento Envia ARQ
    procedure SP_AtualizaDataHoraClick(Sender: TObject);// Evento Envia DataHora
    procedure SB_ReceberClick(Sender: TObject);          // Evento Receber MARC
    procedure RichEditSelectionChange(Sender: TObject);// Evento move cursor RTF
    procedure LBox_NomesArquivosClick(Sender: TObject);// Evento Seleciona ARQ *1
    procedure SB_EnviaCMDClick(Sender: TObject);       // Envia comando ao MAXFinger
    procedure SB_INIClick(Sender: TObject);            // Inicia LEitor biometico
    procedure SB_UPGRADEClick(Sender: TObject);        // Reiniciliza Leitor Biomtrico
    procedure SB_UNIINITClick(Sender: TObject);        // Finaliza leitor Biometrico
    procedure SB_SENDClick(Sender: TObject);           // Envia Biometria
    procedure SB_CAPTUREClick(Sender: TObject);        // Captura Biometria 1
    procedure SB_ENROLLClick(Sender: TObject);         // Compara Biometria
    procedure SB_VERIFYClick(Sender: TObject);         // Identifica Biometria
    procedure SB_REICEIVEClick(Sender: TObject);       // Recebe a biometria
    function  CaptureFingerPrint1 : String;            // Captura o Biometria coloca Array
    procedure SaveTemplateToFile;                      // Grava a biometria em arquivo binário
    procedure ConvertStringIntoByteArray(pString : String); // Converte as Strings pR Array.
    procedure CaptureFingerPrint2;                          // Captura a Biometria
    procedure TimerTemplateTimer(Sender: TObject);          // Timer envio
    procedure EditIPChange(Sender: TObject);
    procedure LOG1Click(Sender: TObject);
    procedure OnLine1Click(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);                     // Captura Biometria 2
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TSck_OnLine = class(TThread)  // Thread usada no modo Online
  private
    procedure SetName;          // ****
  protected
    procedure Execute; override;  // Modulo onde deve ficar o código executado na Thread
end;

{ ***********************************************
   Armazena Auditoria
  ********************************************** }
Type TAuditor =record
  PRG: Integer;            { ** Quantas Vezes o PRG foi enviado **}
  ARQ: Integer;            { ** Quantas Vezes os ARQ foram enviado **}
  Marcas: Integer;         { ** Quantas Vezes as MARCAS foram Recebidas **}
  Online: integer;         { ** Quantas Vezes Usou Online **}
  Respostas: Integer;      { ** Quantas Vezes o Respondeu **}
  IP: String[16];          { ** Numero IP **}
  Porta: Integer;          { ** porta TCP **}
  Coletor: Integer;        { ** Coletor **}
  SocketOnLine: Boolean;   { ** Socket OnLine **}
  SerialOnLine: Boolean;   { ** Serial OnLine **}
end;
{
   ****************************************************
}
var
  FmPrincipal: TFmPrincipal;    { ** Formulario  **}

  FileAudit: File of TAuditor;  { ** Arquivo auditoria ** }
  Auditorias:TAuditor;          { ** Objeto auditoria ** }

  Nu:integer;                   { Uso local contador }
  s:string;                     { String temporária }
  I,N:integer;                  { Var Numericas temporárias }

  nResult:integer;              { Retorno Resultado das Informações }
  nCnt: integer;                { Porta COM }
  nColetor: integer;            { Coletor   }
  nPorta: integer;              { Porta TCP }

  sIP:String;                   { Numero IP }
  sNm:String;                   { Nome completo arquivo }

  cFileOrg:   array [0..100] of char; { ** Arquivo Fonte ** }
  cFileDest:  array[0..100] of char;  { ** Arquivo Fonte ** }

  {*
     Para declaração das estruturas, utilize a Unit XPCom32.pas
     Uses ..., XPCom32, ...
  *}

  Format:     CONVFILEFORMAT;   { Estrutura de dados para conversão }
  pFormat:    PCONVFILEFORMAT;  { Ponteriro para estrutura de dados }

  Lst,Lst1:TStringList;         { Usados para estrutura arquivos texto->Binário }

  { ******************** }
    nchannel:integer;
    nColleter:integer;
  { ******************** }


  Template1 : String; // Template1 represents the fingerprint stored in
                      // the database (as a string or memo field) and Template2 is the
                      // fingerprint captured to be compared with Template1

  Template1Byte,Template2Byte  : Array [0..MAX_TEMPLATESIZE-1] of Byte;  // represent the fingerprints as an Array of Bytes
  sizeTemplate1, sizeTemplate2 : Integer;

  hMatcher : HUFMATCHER;
  byteArrayTemplate: array[0..383] of byte;

  Sck_OnLine:TSck_OnLine;

{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType: LongWord;          // must be 0x1000
    FName: PChar;             // pointer to name (in user address space)
    FThreadID: LongWord;      // thread ID (-1 indicates caller thread)
    FFlags: LongWord;         // reserved for future use, must be zero
    SckTTRX: TClientSocket;   // Teste apagar versão final
  end;
{$ENDIF}

Const

  { *********  Mensagens  identifica PRG e ARQ ******** }
  Programa            :integer=0;
  Marca               :integer=1;
  Cadastro            :integer=2;
  Expediente          :integer=3;
  De_ID_Para_Matricula:integer=6;
  Sirene              :integer=8;
  Configuracao        :integer=9;
  Mestre              :integer=10;
  DataHora            :integer=99;
  {
      ****  Mensagens  Estrutura ARQ ****
      S, identifica como String.
      I, identifica como numero.
  }

  Struc_Marcas 		  :String= '|S15 |S09 |S09 |S02 |S15 |S02';
  Struc_Cadastro		:String= '|S10 |S14 |S02 |S01 ';
  Struc_Expediente	:String= '|S05 |S04 |S04 ';
  Struc_DePara 		  :String= '|S04 |S14 ';
  Struc_Sirena 		  :String= '|S01 |S01 |S05 |S05 |S05 |S05 |S05 |S05 |S05 |S05 ';
  Struc_Configuracao:String= '|S10 |S02 |S01 |S01 |S01 |S04 |S01 |S16 |S16 |S16 ';
  Struc_Mestre 		  :String= '|S14 |S06 |S01 ';

  { *********  Mensagens  Numero dos arquivos ARQ ******** }
  Struc_NumeroArq   :String= '|00 |00 |02 |03 |06 |08 |09 |10 ';

  MIN_QUALITY=50;

{
    ******************************************************
}
implementation


{$R *.dfm}
{
   ****************************************************************
}
procedure TSck_OnLine.SetName;
{$IFDEF MSWINDOWS}
var
  ThreadNameInfo: TThreadNameInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ThreadNameInfo.FType := $1000;
  ThreadNameInfo.FName := 'Thrd_Sckt_MXF2';
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags := 0;

  try
    RaiseException( $406D1388, 0, sizeof(ThreadNameInfo) div sizeof(LongWord), @ThreadNameInfo );
  except
  end;
{$ENDIF}
end;
{ ************************************ }
procedure TSck_OnLine.Execute;
var
    TxtRecebido:string;
begin
  SetName;
 { Place thread code here }

  while not self.Terminated do begin  // Thread está ativa

      with FmPrincipal.SocketTRX do begin  // acessa methodos e priedades do Socket

          Host := TRIM(FmPrincipal.EditIP.Text);           // Numero IP
          Port := StrToInt(FmPrincipal.EditPortaTCP.Text); // Porta TCP
          ClientType:=ctBlocking;                          // Recebe modo Blocking

             if not Socket.Connected then    // Socket Ativo
                for I := 1 to 3 do begin     // 3 Tentativa
                   Active := False;         // Desativa
                   Active := true;          // Ativa
                   Sleep(2000);             // Aguarda 20 segundos

                if Socket.Connected then Break; // Conseguiu conectar

             end; { *************************************************** }

            if Socket.Connected then begin  // Está conectado

                // Chegou informação vinda do coletor
                if FmPrincipal.SocketTRX.Socket.ReceiveLength > 0 then
                  begin

                    // Pega as marcações vindas do coletor.

                    TxtRecebido:=FmPrincipal.SocketTRX.Socket.ReceiveText;

                    FmPrincipal.LstBx_OnLine.Items.Add(TxtRecebido);
                    FmPrincipal.Mm_LOG.Lines.Add(TxtRecebido + ' <- Coletor');

                    // Responde ao coletor ao enviar informações
                    if TRIM(FmPrincipal.Ed_Resposta.Text)<>'' then
                       FmPrincipal.SocketTRX.Socket.SendText(
                                TRIM(FmPrincipal.Ed_Resposta.Text));

                  end; { *************************************************** }
            end; { *************************************************** }
      end; { *************************************************** }
  end; { *************************************************** }
end; { ************************** }
{
   **************************************************************
}
procedure TFmPrincipal.ConvertStringIntoByteArray(pString : String);
//put the pString parameter into TemplateByte1 Array, for example to get a string fingerprint
//stored in a database as string field and put it into the Array
var
      i : integer;
      temp : String;
begin
      for i:=0 to MAX_TEMPLATESIZE-1 do begin
        Template1Byte[i]:=255;
      end;
      i:=1;
      while i<= (length(pString)/2) do begin
           temp:='$'+pString[2*(i-1)+1]+pString[2*i];
           Template1Byte[i-1]:=strtoint(temp);
           i:=i+1;
      end;
      sizeTemplate1:=i-1;
end;

{*****************************************************}
{**        Save template string to file binary      **}
{*****************************************************}
procedure TFmPrincipal.SaveTemplateToFile;
var
  myFile    : File;
  sRet : String;
begin

  sRet := InputBox('Identificação',
  'Numero de identificação do funcionário' + chr(10) + chr(13),
  '1001');

  AssignFile(myFile, GetCurrentDir  +'\Bio\Bio'+Trim(sRet)+'.Byt' );
  ReWrite(myFile, 1);   // Define a single 'record' as 4 bytes

  BlockWrite(myFile, byteArrayTemplate, 384);   // Write 1 'records' of 384 bytes

  // Close the file
  CloseFile(myFile);

end;
{
   ********************************************************
}
procedure TFmPrincipal.EnviaComandoXP;
var
  Result,I:integer;
begin

// ChkSOCKET habilitado para envio do comando XP ao coletor

if TRIM(EditIP.Text)='' then begin
  { *********** ABRIR CANAL ************* }
  Result := ComOpen(nCnt,9600,8,1,COM_NONEP,COM_NOFLOW,COM_NOFLOW,256,256);

  if Result=0 then begin
     ChkBxSocket.Checked:=false;
     nResult:=ComTxData(nCnt,'XP',2);
  end;

  { *********** FECHA CANAL ************* }
  Result := ComClose(nCnt);
end;
{
  ************************************************
}
if TRIM(EditIP.Text)<>'' then with SocketTRX do begin

      Host := TRIM(EditIP.Text);            // Numero IP
      Port := StrToInt(EditPortaTCP.Text);  // Porta TCP
      ClientType:=ctBlocking;  // Recebe modo Blocking

        for I := 1 to 3 do  // Tenta 3 vezes a conection com o MAxFinger 2
         begin
          Active := False;   // Socket desativado
          Active := true;    // Socket Ativo
          Sleep(2000);       // Espera 20 segundos

          if Socket.Connected then Break; // Conectou
       end;

       if Socket.Connected then begin // Está conectado
          Socket.SendText( 'XP' );    // Envia comando XP, para colocar em modo remoto
       end;
       Active := False;               // SOCKET desativado
    end; { ***************** }

end;
{
  *****************************************************
}

procedure TFmPrincipal.SB_FecharClick(Sender: TObject);
begin


if TRIM(EditPortaTCP.Text)='' then EditPortaTCP.Text:='0';


Mm_LOG.Lines.Add('**********************************');
Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Auditoria ');

Mm_LOG.Lines.Add('Envio PRG['+IntToStr(Auditorias.PRG)+']'+
                 ' e ARQ['+IntToStr(Auditorias.ARQ)+']');

Mm_LOG.Lines.Add('Marcações ['+IntToStr(Auditorias.Marcas)+']'+
                 ' e Respostas['+IntToStr(Auditorias.Respostas)+']');

Mm_LOG.Lines.Add('Status Online ['+IntToStr(Auditorias.Online)+']');

Mm_LOG.Lines.Add('**********************************');

Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Finalizado');
Mm_LOG.Lines.SaveToFile(ed_Path.Text + '\LogFile.txt'); //Preserva LOG
LstBx_OnLine.Items.SaveToFile(ed_Path.Text + '\LogOnLine.txt');//Preserva Online

Auditoria;             { ** Grava e Preserva IP,Coletor,Topo COM informações ** }
Application.Terminate; { ** Fecha Aplicação ** }

end; { ******************************************************  }
procedure TFmPrincipal.SP_EnviaPRGClick(Sender: TObject);
var
  S:string;    // Uso local String
  I:integer;   // opção de envio
begin

    S := LBox_NomesArquivos.Items[LBox_NomesArquivos.ItemIndex]; // Nome ARQ

    // ** Nome completo do ARQ **
    sNm := TRIM(ed_Path.Text) + '\' + Trim(Copy( S, POS(':',S)+1, Length(S) ));

    Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Enviado PRG ' + sNm);

    EnviaArquivo(sNm,Programa);  { Envia Programa }

end; { ******************************************************  }
procedure TFmPrincipal.ConverteArquivo(Nome:string; N:integer);
var
   Nu:integer;  // Uso local contador
begin

  Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Convertendo Arquivo '+Nome+'.bin');

  Format.cFields := 0;                    { Limpa campos conversão }

  Lst:=TStringList.Create;                { Estancia Objeto Lst }
  Lst.Delimiter := ' ';                   { Espaço itens }
  Lst.QuoteChar := '|';                   { Caractere usado para separar items }

  { ** Associa a estrutura do arquivo a enviar ao coletor ** }

  if N=Marca                then  Lst.DelimitedText := Struc_Marcas;
  if N=Cadastro             then  Lst.DelimitedText := Struc_Cadastro;
  if N=Expediente           then  Lst.DelimitedText := Struc_Expediente;
  if N=De_ID_Para_Matricula then  Lst.DelimitedText := Struc_DePara;
  if N=Sirene               then  Lst.DelimitedText := Struc_Sirena;
  if N=Configuracao         then  Lst.DelimitedText := Struc_Configuracao;
  if N=Mestre               then  Lst.DelimitedText := Struc_Mestre;

  for Nu:=0 to Lst.Count-1 do begin

    Inc(Format.cFields);                   { ************************* Adiciona Campo  }
    Format.Field[Nu].cType   := XPFLD_STR; { ************************* configura Tipo String }
    Format.Field[Nu].cLength := StrToInt(Copy(Lst.Strings[Nu],2,2)); { configura Tamanho }

  end; { ******************************************************  }

    pFormat := @Format;                  // Ponteiro para formato
    StrPCopy(cFileOrg,  Nome);           // Arquivo Fonte

  if N = Marca then begin

    StrPCopy(cFileDest, Nome + '.TXT');  // Arquivo Destino p/ PC
    nResult:=FXPBasicConvToText(cFileOrg, cFileDest, XPLTERM_LF);

  end; { ******************************************************  }

  if N <> Marca then begin

    StrPCopy(cFileDest, Nome + '.BIN');  // Arquivo Destino p/ EQUI
    nResult:=FXPBasicConvFromText(cFileOrg, cFileDest, pFormat);

  end; { ******************************************************  }

  if nResult <> 0 then
     Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Erro Conversão, (' + Nome +') Numero  ' + IntToStr(nResult) );

  Lst.Destroy;

  if nResult = 0 then
     if N <> Marca then
        EnviaArquivo(Nome + '.BIN',N);  { ** Envia PRG ou Arquivo **}

end; { ******************************************************  }
procedure TFmPrincipal.EnviaArquivo(Nome:string; N:integer);
begin
  nCnt:=0;                                        { Porta COM }
  nPorta:=2101;
  nColetor:=StrToInt(EditColetor.Text);           { Coletor   }

  if TRIM(EditPortaTCP.Text)<>'' then
     nPorta:=StrToInt(EditPortaTCP.Text);         { Porta TCP }

  sIP:=TRIM(EditIP.Text);                         { Numero IP }

    if Length(sIP) > 0 then
      begin
        ComSetAddress(nCnt,COMCFG_IPADDR, Pchar(sIP), nPorta);  { usado Para Comunicação TCP/IP }
        nResult := XPnetmOpen(nCnt, 9600, 1024, 1024, XPN_COMIP, 2);
        Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Aberto comunicação IP:' + sIP) ;
      end
    else
      begin
        nResult := XPnetmOpen(nCnt, 9600, 1024, 1024, XPN_COMAUTO, 2);
      end;

    { *************************************************************** }

      if not ChkBxSocket.Checked then SLEEP(8000);

      { ** Liga Modo Remoto ** }
      if not ChkBxSocket.Checked then
         nResult := XPnetmRemote(hwnd(nil),nCnt, nColetor, 1); { Liga Modo Remoto, não causa erro }

        if nResult = 0 then begin

           if N=DataHora      then nResult:=XPnetmTxClock(hwnd(nil),nCnt, nColetor);
           if N=Programa      then nResult:=XPnetmTxProg(hwnd(nil), nCnt, nColetor, Pchar(Nome));
           if N=Marca         then nResult:=XPnetmRxFile(hwnd(nil), nCnt, nColetor, Pchar(Nome),N);
           if N=Cadastro      then nResult:=XPnetmTxFile(hwnd(nil), nCnt, nColetor, Pchar(Nome),N);
           if N=Expediente    then nResult:=XPnetmTxFile(hwnd(nil), nCnt, nColetor, Pchar(Nome),N);
           if N=Sirene        then nResult:=XPnetmTxFile(hwnd(nil), nCnt, nColetor, Pchar(Nome),N);
           if N=Configuracao  then nResult:=XPnetmTxFile(hwnd(nil), nCnt, nColetor, Pchar(Nome),N);
           if N=Mestre        then nResult:=XPnetmTxFile(hwnd(nil), nCnt, nColetor, Pchar(Nome),N);

           if N=De_ID_Para_Matricula then
                nResult:=XPnetmTxFile(hwnd(nil), nCnt, nColetor, Pchar(Nome),N);

        end; { ******************************************************  }

       if N=Marca then
          Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Recebendo ' + Nome)
       else
          Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Enviando ' + Nome);

      if nResult <> 0 then
         Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Erro comunicação: ' + IntToStr(nResult) );

      nResult := XPnetmRemote(hwnd(nil),nCnt, nColetor, 0); { Desliga Modo Remoto }

    { *************************************************************** }

      XPnetmClose(nCnt);
      Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Encerrado comunicação');

    If N<>99 then
       If not FileExists(Nome) then
          Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Arquivo Não Encontrado '+Nome);

end; { ******************************************************  }
{
  ********************
}
procedure TFmPrincipal.RecebeBiometria(ID:String); // REcebe biometria
var
  myFile       : File;
  byteArray    : array[0 .. 384] of string;
  aMsg         : array[0 .. 254] of Char;
  oneByte      : byte;
  NameFile,s   : String;
  IDBio        : String;
  i            : integer;
begin

  nCnt:=0;                                        { Porta COM }
  nColetor:=StrToInt(EditColetor.Text);           { Coletor   }
  nPorta:=StrToInt(EditPortaTCP.Text);            { Porta TCP }
  sIP:=TRIM(EditIP.Text);                         { Numero IP }

    if Length(sIP) > 0 then
      begin
        ComSetAddress(nCnt,COMCFG_IPADDR, Pchar(sIP), nPorta);  { usado Para Comunicação TCP/IP }
        nResult := XPnetmOpen(nCnt, 9600, 1024, 1024, XPN_COMIP, 2);
        Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Aberto comunicação IP:' + sIP) ;
      end
    else
      begin
        nResult := XPnetmOpen(nCnt, 9600, 1024, 1024, XPN_COMAUTO, 2);
      end;

      nResult:= XPnetmPollTerm(nCnt, nColetor, 2);

      if nResult = 0 then nResult:= XPnetmPollStart(nCnt, 1);

      if nResult <> 0 then begin
         Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' Erro, XPNet[mOpen ou mPollStart]! ');
      end;

end; { ******************************************************  }

procedure TFmPrincipal.Auditoria;
begin

{ ** Manter Auditori **}
FileMode := fmOpenRead;
AssignFile(FileAudit, ed_Path.Text + '\Auditoria.DAT');

if fileexists(ed_Path.Text + '\Auditoria.DAT') then Reset(FileAudit);

  Auditorias.IP     :=Trim(EditIP.Text);
  Auditorias.Porta  := StrToInt(EditPortaTCP.Text);
  Auditorias.Coletor:= StrToInt(EditColetor.Text);

  Lb_UltimoEnvio.Caption    := 'Total Envio PRG:' + IntToStr(Auditorias.PRG);
  Lb_UltimoArq.Caption      := 'Total Envio ARQ:' + IntToStr(Auditorias.ARQ);
  Lb_TotalMarcas.Caption    := 'Total Rec MARCAS:' + IntToStr(Auditorias.Marcas);
  Lb_TotalOnLine.Caption    := 'Total Estado Online:' + IntToStr(Auditorias.Online);
  Lb_TotalRespotas.Caption  := 'Total Repostas:' + IntToStr(Auditorias.Respostas);

  ReWrite(FileAudit);
  Write (FileAudit, Auditorias);

CloseFile(FileAudit);

end; { ******************************************************  }
procedure TFmPrincipal.FormCreate(Sender: TObject);
var
  i:integer;
begin

ed_Path.Text := GetCurrentDir;

WebBrowser.Navigate(GetCurrentDir + '\HTML\pagina_inicial.htm');

if FileExists(GetCurrentDir + '\LogFile.txt') then
   Mm_LOG.Lines.LoadFromFile(GetCurrentDir + '\LogFile.txt');

if FileExists(GetCurrentDir + '\LogOnLine.txt') then
   LstBx_OnLine.Items.LoadFromFile(GetCurrentDir + '\LogOnLine.txt');

PCMain.ActivePageIndex := 1; // Pagina Dados

{ ** Recupera Auditoria **}

  if fileexists(ed_Path.Text + '\Auditoria.DAT') then begin
    FileMode := fmOpenRead;
    AssignFile(FileAudit, ed_Path.Text + '\Auditoria.DAT');
    Reset(FileAudit);

    while not Eof(FileAudit) do Read(FileAudit, Auditorias);

    Lb_UltimoEnvio.Caption := 'Total Envio PRG:' + IntToStr(Auditorias.PRG);
    Lb_UltimoArq.Caption :=   'Total Envio ARQ:' + IntToStr(Auditorias.ARQ);
    Lb_TotalMarcas.Caption := 'Total Rec MARCAS:' + IntToStr(Auditorias.Marcas);
    Lb_TotalOnLine.Caption := 'Total Estado Online:' + IntToStr(Auditorias.Online);
    Lb_TotalRespotas.Caption := 'Total Repostas:' + IntToStr(Auditorias.Respostas);

    EditIP.Text       := Auditorias.IP;
    EditPortaTCP.Text := IntToStr(Auditorias.Porta);
    EditColetor.Text  := IntToStr(Auditorias.Coletor);

    CloseFile(FileAudit);

  end; { *********************** }

StatusBar.SimpleText := 'Bem vindo ao TRIXConnect!';

Lst := TStringList.Create;

Auditorias.SocketOnLine := False;

// ExecutaParam(ParamCount);

end; { *********************** }

procedure TFmPrincipal.SB_AbrirClick(Sender: TObject);
var
  s:string;
  I:integer;
begin

    MemoArq.Lines.Clear;
    RichEdit.Clear;

    if LBox_NomesArquivos.ItemIndex > 1 then begin

       S := LBox_NomesArquivos.Items[LBox_NomesArquivos.ItemIndex];
       sNm := TRIM(ed_Path.Text) + '\' + Trim( Copy( S, POS(':',S)+1, Length(S) ) );

       if FileExists(sNm) then MemoArq.Lines.LoadFromFile(sNm);

       RichEdit.Lines.Clear;
       if MemoArq.Lines.Count > 0 then
          for I:=0 to MemoArq.Lines.Count-1 do
              RichEdit.Lines.Add(MemoArq.Lines[I]);

       Mm_LOG.Lines.Add(DateTimeToStr(now) +' : dados ');


    end; { ******************************************************  }

    INC(Auditorias.ARQ);

end; { ******************************************************  }

procedure TFmPrincipal.SB_SalvaClick(Sender: TObject);
var
  s:string;
  I,N:integer;
begin
    Lst1:=TStringList.Create;
    Lst1.Delimiter := ' ';
    Lst1.QuoteChar := '|';
    Lst1.DelimitedText := Struc_NumeroArq;

    if LBox_NomesArquivos.ItemIndex > 1 then begin

       N := StrToInt(TRIM(lst1.Strings[LBox_NomesArquivos.ItemIndex]));
       S := LBox_NomesArquivos.Items[LBox_NomesArquivos.ItemIndex];
       sNm := TRIM(ed_Path.Text) + '\' + Trim( Copy( S, POS(':',S)+1, Length(S) ) );

       MemoArq.Lines.Clear;
       for I:=0 to RichEdit.Lines.Count-1 do
           MemoArq.Lines.Add(RichEdit.Lines[I]);

       MemoArq.Lines.SaveToFile(sNm);
       // RichEdit.Lines.Clear;

       Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Salvo '+ sNm);

       EnviaComandoXP;  {Muda de socket para XPComlib}

       if FileExists(sNm) then ConverteArquivo(sNm,N);

    end; { ******************************************************  }

    Lst1.Destroy;

    INC(Auditorias.ARQ);
    Auditoria; { ** Auditoria do Sistema ** }

end; { ******************************************************  }

procedure TFmPrincipal.SB_AssistenteClick(Sender: TObject);
var
   Action:integer;
begin

   Action:=StrToInt(InputBox('ASSISTENTE',

            'Para criar todos arquivos digite 9999, ' + chr(10) + chr(13)+
            chr(10) + chr(13)+
            'criar um especifico. Digite o numero corresponde: ' + chr(10) + chr(13)+
            'A lista dos arquivos. ou zero para nenhum.' + chr(10) + chr(13) +
            chr(10) + chr(13)+
            '[2] - CADASTRO : Cadastro2.txt' + chr(10) + chr(13)+
            '[3] - EXPEDIENTE : Expediente3.txt' + chr(10) + chr(13)+
            '[4] - ID_MATRICULA: ID_Matricula6.txt' + chr(10) + chr(13)+
            '[5] - SIRENE : Sirene8.txt' + chr(10) + chr(13)+
            '[6] - CONFIGURAÇÃO : Configurar9.txt' + chr(10) + chr(13)+
            '[7] - MESTRE : Mestre10.txt' + chr(10) + chr(13)+
            '[8] - PROGRAMA ( Socket ): oficskt.bin' + chr(10) + chr(13),

            '0') );

            Case Action of 2,3,4,5,6,7 : Assistente(Action) end;

   if (Action=9999) then begin

      FmPrincipal.Caption := 'POR FAVOR! Aguarde criando os arquivos.';

      MemoArq.Lines.Clear;
      MemoArq.Lines.Add('0020100000000');
      MemoArq.Lines.Add('0020204801080');
      MemoArq.Lines.Add('0020304801080');
      MemoArq.Lines.Add('0020404801080');
      MemoArq.Lines.Add('0020504801080');
      MemoArq.Lines.Add('0020604801080');
      MemoArq.Lines.Add('0020700000000');
      MemoArq.Lines.SaveToFile( GetCurrentDir + '\Expediente3.TXT' );

      LBox_NomesArquivos.ItemIndex := 3;
      LBox_NomesArquivosClick(self);
      SB_SalvaClick(self);
      sleep(5000);

      MemoArq.Lines.Clear;
      MemoArq.Lines.Add('000000100112345678901231200');
      MemoArq.Lines.Add('000000100212345678901232200');
      MemoArq.Lines.Add('000000100312345678901233200');
      MemoArq.Lines.Add('000000100412345678901234200');
      MemoArq.Lines.Add('000000100512345678901235200');
      MemoArq.Lines.Add('000000100612345678901236200');
      MemoArq.Lines.Add('000000100712345678901237200');
      MemoArq.Lines.Add('000000100812345678901238200');
      MemoArq.Lines.SaveToFile( GetCurrentDir + '\Cadastro2.TXT' );

      LBox_NomesArquivos.ItemIndex := 2;
      LBox_NomesArquivosClick(self);
      SB_SalvaClick(self);
      sleep(5000);

      MemoArq.Lines.Clear;
      MemoArq.Lines.Add('100112345678901231');
      MemoArq.Lines.Add('100212345678901232');
      MemoArq.Lines.Add('100312345678901233');
      MemoArq.Lines.Add('100412345678901234');
      MemoArq.Lines.Add('100512345678901235');
      MemoArq.Lines.Add('100612345678901236');
      MemoArq.Lines.Add('100712345678901237');
      MemoArq.Lines.Add('100812345678901238');

      MemoArq.Lines.SaveToFile( GetCurrentDir + '\ID_Matricula6.TXT' );

      LBox_NomesArquivos.ItemIndex := 4;
      LBox_NomesArquivosClick(self);
      SB_SalvaClick(self);
      sleep(5000);

      MemoArq.Lines.Clear;
      MemoArq.Lines.Add('00000000009991000000S');
      MemoArq.Lines.Add('00000000009992000000N');
      MemoArq.Lines.SaveToFile( GetCurrentDir + '\Mestre10.TXT' );

      LBox_NomesArquivos.ItemIndex := 7;
      LBox_NomesArquivosClick(self);
      SB_SalvaClick(self);
      sleep(5000);

      MemoArq.Lines.Clear;
      MemoArq.Lines.Add(
        'NNNS1S110003SAN9900N*    TRIX2012   ** ENTRADA - OK ** SAIDA   - OK *');
      MemoArq.Lines.Add(
        'NNNS1S220003SAN9900N*    TRIX2012  ** ENTRADA - OK ** SAIDA   - OK *');
      MemoArq.Lines.Add(
        'NNNN0N000000SAN9999S0000000000000000*    TRIXTEC  **    TRIXTEC  *');
      MemoArq.Lines.Add(
        'NNNN0N000000SAN9999S000000000000000199999999999999990000000000000000');

      MemoArq.Lines.SaveToFile( GetCurrentDir + '\Configurar9.TXT' );

      LBox_NomesArquivos.ItemIndex := 6;
      LBox_NomesArquivosClick(self);
      SB_SalvaClick(self);
      sleep(5000);

      FmPrincipal.Caption :=  'TRIXConnect - MAXFinger 2  V.1.2.6';
      StatusBar.SimpleText := 'Arquivos criado, obrigado!';

      showMessage('Arquivos criados!');

   end;

end;
{
  **************************************************************
}
procedure TFmPrincipal.Assistente(Item:integer);
var
  sRet:string;
  s:string;
  N:integer;
begin

LBox_NomesArquivos.ItemIndex := Item;

if LBox_NomesArquivos.ItemIndex <> -1 then begin

    Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Assistente Criar ' +
           LBox_NomesArquivos.Items[LBox_NomesArquivos.ItemIndex] ) ;

    MemoArq.Clear; s:='';
    // RichEdit.Clear;

    INC(Auditorias.ARQ);
    FmPrincipal.Auditoria;

    StatusBar.SimpleText := 'Leia as informações, entre com os dados, não é aceito em branco.';

    { ******************************************* }
    if LBox_NomesArquivos.ItemIndex = 2 then begin
    repeat

       repeat
          sRet := InputBox('CADASTRO-cartão ',
          'Código do cartão com 10 digitos ' + chr(10) + chr(13),
          '0000001001');
          s:=s + sRet;
       until (sRet <> ''); { ************************ }

       if sRet <> ' ' then
       repeat
          sRet := InputBox('CADASTRO-identificação',
          'Numero de identificação do funcionário - ' + chr(10) + chr(13) +
          'Será utilizado para cadastramento da biometria 14 Digitos' + chr(10) + chr(13),
          '12345678901231');
          s:=s + sRet;
       until (sRet <> ''); { ************************ }

       if sRet <> ' ' then
       repeat
          sRet := InputBox('CADASTRO-Expediente ',
          'Código expediente 2 digitos ' + chr(10) + chr(13),
          '20');
          s:=s + sRet;
       until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
       repeat
          sRet := InputBox('CADASTRO-Lista ',
          '0-Lista branca   1-Lista negra (bloqueio) ' + chr(10) + chr(13),
          '0');
          s:=s + sRet;
       until (sRet <> '');  { ************************ }

    RichEdit.Lines.Add(s);
    MemoArq.Lines.Add(s);s:='';

    until (InputBox('REGISTRO','Inserir mais digite 1, Parar 0','0') <> '1');
    end; { ************************************** }

    { ******************************************* }

    if LBox_NomesArquivos.ItemIndex = 3 then begin
       repeat
       if sRet <> ' ' then
          repeat
            sRet := InputBox('EXPEDIENTE-Código ',
            'Codigo expediente, 4 caracteres.' + chr(10) + chr(13),
            '0020');
            s:=s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('EXPEDIENTE-Dia Semana ',
            'Dia da semana, 1-Domingo ...  7-Sabado.' + chr(10) + chr(13),
            '1');
            s:=s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('EXPEDIENTE-Hora Inicial ',
            'Horario inicial ( minutos ), 5 caracteres. HH:MM' + chr(10) + chr(13),
            '07:00');

            N := StrToInt(Copy(sRet,1,2))*60 + StrToInt(Copy(sRet,4,2));
            s := s + RightStr('0000' + IntToStr(N),4);

          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('EXPEDIENTE-Hora Final ',
            'Horario inicial ( minutos ), 5 caracteres. HH:MM' + chr(10) + chr(13),
            '18:00');

            N := StrToInt(Copy(sRet,1,2))*60 + StrToInt(Copy(sRet,4,2));
            s := s + RightStr('0000' + IntToStr(N),4);

          until (sRet <> '');  { ************************ }

       RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);s:='';

       until (InputBox('REGISTRO','Inserir mais digite 1, Parar 0','0') <> '1');
    end; { ************************************** }

    if LBox_NomesArquivos.ItemIndex = 4 then begin

      if sRet <> ' ' then
          repeat
            sRet := InputBox('RELACIONAR-Id ',
            'Codigo identificação  ' + chr(10) + chr(13),
            '1001');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('RELACIONAR-Matricula',
            'Numero de identificação do funcionário  ( Matricula ), '+ chr(10) + chr(13)+
            'O mesmo do arquivo 2'+ chr(10) + chr(13),
            '00000001001');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);s:='';

    end; { ************************************** }

    if LBox_NomesArquivos.ItemIndex = 5 then begin
       repeat
       if sRet <> ' ' then
          repeat
            sRet := InputBox('SIRENE-Rele ',
            'Rele a ser acionado' + chr(10) + chr(13),
            '1');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('SIRENE-Tempo Rele ',
            'Tempo de acionamento do rele - segundos (1-9)' + chr(10) + chr(13),
            '3');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
         for N:=1 to 8 do begin

          repeat
            sRet := InputBox('SIRENE-Hora Final 8:' + IntToStr(N) ,
            'Horario inicial ( minutos ), 5 caracteres. HH:MM' + chr(10) + chr(13),
            '12:00');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

          if sRet = '0' then break;

         end; { ************************ }

        RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);s:='';

       until (InputBox('REGISTRO','Inserir mais digite 1, Parar 0','0') <> '1');
    end; { ************************************** }

    if LBox_NomesArquivos.ItemIndex = 6 then begin

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Lista ',
            'Checa a lista (S/N) ' + chr(10) + chr(13),
            'N');
            s := 'NNN' + sRet + '1';
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Biometria ',
            'Identificação biometria (S/N) ' + chr(10) + chr(13),
            'N');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Rele Entrada ',
            '0 - Não aciona Rele, '+ chr(10) + chr(13)+
            '1 - Rele 1 '+ chr(10) + chr(13) +
            '2 - Rele 2 '+ chr(10) + chr(13),
            '0');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Switch Entrada ',
            '0 - Não controla Giro '+ chr(10) + chr(13) +
            '1 - Switch 1 '+ chr(10) + chr(13) +
            '2 - Switch 2 '+ chr(10) + chr(13),
            '0');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Rele Saida ',
            '0 - Não aciona Rele, '+ chr(10) + chr(13)+
            '1 - Rele 1 '+ chr(10) + chr(13) +
            '2 - Rele 2 '+ chr(10) + chr(13),
            '0');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Switch Saida ',
            '0 - Não controla Giro '+ chr(10) + chr(13) +
            '1 - Switch 1 '+ chr(10) + chr(13) +
            '2 - Switch 2 '+ chr(10) + chr(13),
            '0');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Tempo Rele ',
            'Tempo de acionamento do rele  - segundos 2 caracteres '+ chr(10) + chr(13),
            '05');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Teclado ',
            'Permite Teclado (S/N) '+ chr(10) + chr(13),
            'S');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Sentido Giro ',
            'E - Libera para entrada  '+ chr(10) + chr(13) +
            'S - Libera para Saida  '+ chr(10) + chr(13) +
            'A - Libera para Saida e entrada  '+ chr(10) + chr(13),
            'S');
            s := s + sRet + 'N99' ;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Digitos cartão ',
            'Numero de digitos do cartão  '+ chr(10) + chr(13) +
            'de código de barras '+ chr(10) + chr(13) +
            '00 - Aceita qualquer tamanho  '+ chr(10) + chr(13),
            '00');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Comunicação ',
            'S-local  ( checa somente na lista branca/negra ) '+ chr(10) + chr(13) +
            'N-online ( checa diretamente no servidor ) '+ chr(10) + chr(13),
            'N');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Mensag.Linha 1 ',
            'Mensagem padrão - primeira linha do display '+ chr(10) + chr(13) +
            'maximo de 16 caracteres '+ chr(10) + chr(13),
            '*    TRIXTEC   *');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Mensag.Entrada ',
            'Mensagem quando liberado para entrada '+ chr(10) + chr(13) +
            'maximo de 16 caracteres '+ chr(10) + chr(13),
            '* ENTRADA - OK *');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Mensag.Saida ',
            'Mensagem quando liberado para saída '+ chr(10) + chr(13) +
            'maximo de 16 caracteres '+ chr(10) + chr(13),
            '* SAIDA   - OK *');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);
       RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);
       s:='NNNN0N000000SAN9999S0000000000000000*    TRIXTEC  **    TRIXTEC  *';
       RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);

          if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Limite ',
            'Limite inicial do cartão maximo de 16 caracteres '+ chr(10) + chr(13),
            '0000000000000001');
          until (sRet <> '');  { ************************ }

       s:='NNNN0N000000SAN9999S'+sRet;

          if sRet <> ' ' then
          repeat
            sRet := InputBox('CONFIGURA-Limite ',
            'Limite inicial do cartão maximo de 16 caracteres '+ chr(10) + chr(13),
            '0000000000009001');
          until (sRet <> '');  { ************************ }

       s:=s + sRet + '0000000000000000';

       RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);

    end; { ************************************** }

    if LBox_NomesArquivos.ItemIndex = 7 then begin
       repeat

       if sRet <> ' ' then
          repeat
            sRet := InputBox('MESTRE-Cartão ',
            'Numero do cartão de liberação ou mestre 14 caracteres ' + chr(10) + chr(13),
            '00000000009991');
            s := s + sRet;
          until (sRet <> '');  { ************************ }

       if sRet <> ' ' then
          repeat
            sRet := InputBox('MESTRE-Tipo ',
            'S - cartão mestre' + chr(10) + chr(13) +
            'N - cartão de liberação' + chr(10) + chr(13)+
            'O cartão mestre habilita o menu no display para '+
            'cadastramento e exclusão das digitais diretamente no '+
            'equipamento A utilização da biometria necessita da lista '+
            'branca cadastrada Numero do cartão de liberação ou mestre 14 caracteres ',
            'S');
            s := s + '000000' + sRet;
          until (sRet <> '');  { ************************ }

       RichEdit.Lines.Add(s);
       MemoArq.Lines.Add(s);s:='';

       until (InputBox('REGISTRO','Inserir mais digite 1, Parar 0','0') <> '1');
    end; { ************************************** }


end; { ************************************************** }
end; { ************************************************** }

procedure TFmPrincipal.SB_LimpaClick(Sender: TObject);
begin

    RichEdit.Clear;
    MemoArq.Lines.Clear;

end; { **************************************** }

procedure TFmPrincipal.PCMainChange(Sender: TObject);
var
  Result,i:integer;
begin

    Result := ComClose(nCnt);  // Fecha Canal seria sem protocolo

    Auditorias.SocketOnLine := false;  // Inicia auditoria OffLine

    TimerOnLine.Enabled := False;      // Comunicação Serial OffLine

    ChkBxSocket.Checked:=False;        // Comunicação Serial 

    if TRIM(EditIP.Text)<>'' then ChkBxSocket.Checked:=true; // Sem IP Disable Socket

    // if ChkBxSocket.checked then TimerOnLine.Enabled := False;

    GB_ID.Enabled := True; // Desabilita mudar numero do coletor

    SP_EnviaPRG.Enabled := True;          // Habilita enviar programa
    SP_AtualizaDataHora.Enabled := True;  // Habilita enviar arquivos
    SB_Fechar.Enabled := True;            // Habilita fechar o TRIXConnect

    if (PCmain.ActivePageIndex = 3) then
        StatusBar.SimpleText := 'Sistema de Ajuda em HTML.';
    if (PCmain.ActivePageIndex = 2) then
        StatusBar.SimpleText := 'Online, com o MaxFinger!';
    if (PCmain.ActivePageIndex = 1) then
        StatusBar.SimpleText := 'Configure os dados!';
    if (PCmain.ActivePageIndex = 0) then
        StatusBar.SimpleText := 'Log, processos executados !';

{ ***************************************************************** }

    if (PCmain.ActivePageIndex = 2) and (ChkBxSocket.checked)  then begin

        Auditorias.SerialOnLine := false;
        IP:=TRIM(EditIP.Text);

        if trim(EditPortaTCP.Text)<>'' then
          PortaTCP:=StrToInt(EditPortaTCP.Text)
        else
          PortaTCP:=0;

        Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' OnLine (Socket) por Thread: ' + sIP) ;

        FmPrincipal.LstBx_OnLine.Clear;
        Sck_OnLine := TSck_OnLine.Create(True);
        Sck_OnLine.Resume;

        Auditorias.SocketOnLine := true;
        SB_Fechar.Enabled := False;
        SP_EnviaPRG.Enabled := false;
        SP_AtualizaDataHora.Enabled := false;

    end;

{ ***************************************************************** }

    if (PCmain.ActivePageIndex = 2) and (not ChkBxSocket.checked)  then begin

        if not Auditorias.SocketOnLine then begin
          Sck_OnLine.Free;
          Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' OffLine (Socket) por Thread: ' + sIP) ;

          Auditorias.SocketOnLine := false;
          Auditorias.SerialOnLine := True;
        end;

        if not TimerOnLine.Enabled then TimerOnLine.Enabled := True;

        SP_EnviaPRG.Enabled := False;
        GB_ID.Enabled := False;
        SP_AtualizaDataHora.Enabled := False;
        nCnt:=0;                                        { Porta COM }
        nColetor:=StrToInt(EditColetor.Text);           { Coletor   }
        nPorta:=2101;

       { ************************************* }

        Result := ComOpen(nCnt,9600,8,1,COM_NONEP,COM_NOFLOW,COM_NOFLOW,256,256); // Abrir Canal

        If nResult = 0 then begin

          TimerOnLine.Enabled := True;

        end;

        INC(Auditorias.Online);
        FmPrincipal.Auditoria;

    end;

{ **************************************** }
    if (PCmain.ActivePageIndex <> 2) then begin

      Auditorias.SocketOnLine := false;
      TimerOnLine.Enabled := False;
      // XPnetmPollStop(nCnt);
      // XPnetmClose(nCnt);

      LstBx_OnLine.Clear;

    end;
{
   ****************************************
}
end; // ***********************************************
{
   ******************************************************
}
procedure TFmPrincipal.TimerOnLineTimer(Sender: TObject);
var
    sBuffer:  array[0..99] of char;                 // String local
begin

     if ComGetnRx(0) > 0 then begin
        nResult:=ComRxData(0,@sBuffer,ComGetnRx(0));

        if nResult <> 0 then
           Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Err Rec.dados:' + IntToStr(nResult) )
        else begin

           Mm_LOG.Lines.Add(DateTimeToStr(Now) +' : MSG <- ' + sBuffer);
           StatusBar.SimpleText := 'MSG <-' + sBuffer;
           LstBx_OnLine.Items.Add('***************************************');
           LstBx_OnLine.Items.Add('Leitura...:'+sBuffer);

           StrPCopy(sBuffer,TRIM(Ed_Resposta.Text) );
           nResult:=ComTxData(0,@sBuffer,Length(TRIM(Ed_Resposta.Text)) );

           if nResult <> 0 then
              Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Err Envio dados:' + IntToStr(nResult) )
           else
              Mm_LOG.Lines.Add(DateTimeToStr(Now) +' : MSG -> ' + sBuffer);

        end;

    end; { ****************************************** }

end;  { ********************************************* }

procedure TFmPrincipal.SB_ResponderClick(Sender: TObject);
var
    s: String;
begin
            s := Ed_Resposta.Text;

            INC(Auditorias.Respostas);Auditoria; { ** Auditoria do Sistema ** }

            if (FmPrincipal.CB_MSG.ItemIndex>0) and
               (FmPrincipal.CB_MSG.ItemIndex<3) then begin

               FmPrincipal.SocketTRX.Socket.SendText( s );

               if (FmPrincipal.CB_MSG.ItemIndex=1) then begin

                   // FmPrincipal.SocketTRX.Active := False;
                   // Sck_OnLine.Free;
                   // Auditorias.SocketOnLine := false;
                   // sleep(1000);
                   // RecebeBiometria( s );

               end;

               sleep(1000);
               PCmain.ActivePageIndex := 0;

            end;

             if Auditorias.SocketOnLine then
                if FmPrincipal.SocketTRX.Socket.ReceiveLength > 0 then
                   FmPrincipal.Mm_LOG.Lines.Add(
                        FmPrincipal.SocketTRX.Socket.ReceiveText);

             if Auditorias.SocketOnLine then
                if TRIM(FmPrincipal.Ed_Resposta.Text)<>'' then
                   FmPrincipal.SocketTRX.Socket.SendText(
                               TRIM(FmPrincipal.Ed_Resposta.Text));


end; { ********************************************************** }

procedure TFmPrincipal.SB_Limpa_OnLine_LogClick(Sender: TObject);
begin

  LstBx_OnLine.Clear;  { ** Limpa mensagens recebidas **}

end;
{
    *************************************************************
}
procedure TFmPrincipal.SP_EnviaARQClick(Sender: TObject);
var
  S:string;
  I:integer;
begin

    ChkBxSocket.Checked:=false;

    I := LBox_NomesArquivos.ItemIndex;
    if I<0 then begin
       LBox_NomesArquivos.ItemIndex := 8;
       I:=LBox_NomesArquivos.ItemIndex;
    end;

    if TRIM(EditPortaTCP.Text)='' then EditPortaTCP.Text:='0';

    INC(Auditorias.PRG); { ** Aumenta as vezes que enviou o programa ** }
    Auditoria;           { ** Auditoria do Sistema ** }

    // LBox_NomesArquivos.ItemIndex := CB_TipoPRG.ItemIndex;

    if (LBox_NomesArquivos.ItemIndex<2) or (LBox_NomesArquivos.ItemIndex>7) then
    begin

      S := LBox_NomesArquivos.Items[I];

      sNm := TRIM(ed_Path.Text) + '\' + Trim(Copy( S, POS(':',S)+1, Length(S) ));

      EnviaComandoXP;  {Muda de socket para XPComlib}

      StatusBar.SimpleText := UPPERCASE(sNm) + ' Enviando Programa -> MXF2';

      if FileExists(sNm) then EnviaArquivo(sNm,0)
      else Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Não Encontrado Arquivo: ' + sNm );

    end; { ******************************************************  }

    ChkBxSocket.Checked:=true;

end; { ******************************************************  }

procedure TFmPrincipal.SP_AtualizaDataHoraClick(Sender: TObject);
begin

  Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Atualizado Data e Hora.');
  EnviaComandoXP;  {Muda de socket para XPComlib}
  EnviaArquivo('Data e hora',99);

end;  { ******************************************************  }

procedure TFmPrincipal.ApagarMarcas;
begin
  nCnt:=0;                                        { Porta COM }
  nColetor:=StrToInt(EditColetor.Text);           { Coletor   }
  nPorta:=StrToInt(EditPortaTCP.Text);            { Porta TCP }
  sIP:=TRIM(EditIP.Text);                         { Numero IP }

    if Length(sIP) > 0 then
      begin
        ComSetAddress(nCnt,COMCFG_IPADDR, Pchar(sIP), nPorta);  { usado Para Comunicação TCP/IP }
        nResult := XPnetmOpen(nCnt, 9600, 1024, 1024, XPN_COMIP, 2);
        Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Aberto comunicação IP:' + sIP) ;
      end
    else
      begin
        nResult := XPnetmOpen(nCnt, 9600, 1024, 1024, XPN_COMAUTO, 2);
      end;

    { *************************************************************** }

      { ** Liga Modo Remoto ** }
       if XPnetmRemote(hwnd(nil),nCnt, nColetor, 1) = 0 then begin        {Ligado Remoto}

          nResult := XPnetmTxCmd(hwnd(nil),nCnt, nColetor, 'Close 1'); {Send Command}
          if nResult<>0 then Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Erro:'+IntToStr(nResult)+'! Fechar arquivo no coletor.');

          nResult := XPnetmTxCmd(hwnd(nil),nCnt, nColetor, 'Kill 1'); {Send Command}
          if nResult<>0 then Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Erro:'+IntToStr(nResult)+'! Ao Apagar arquivo no coletor.');

       end
       else
          Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Erro colocar modo Remoto!');

       XPnetmRemote(hwnd(nil),nCnt, nColetor, 0); {Desligado}
       XPnetmClose(nCnt);

       Mm_LOG.Lines.Add(DateTimeToStr(now)+ ' : Arquivo Marcação deletado no coletor');

end; { ******************************************************  }

procedure TFmPrincipal.SB_ReceberClick(Sender: TObject);
begin

    sNm := TRIM(ed_Path.Text) + '\Marcas1.bin';

    EnviaComandoXP;      {Muda de socket para XPComlib}

    EnviaArquivo(sNm,1);

    Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Recebendo Arquivo: ' + sNm );

    // if FileExists(sNm) then ConverteArquivo(sNm,1);

    INC(Auditorias.Marcas);Auditoria; { ** Auditoria do Sistema ** }

    Mm_Marcas.Clear;
    sNm := TRIM(ed_Path.Text) + '\Marcas1.bin.txt';

    if FileExists(sNm) then begin
       // ExibeMarca(sNm); // Exibe as marcações recolhidas
       // ApagarMarcas;    // Apaga Marcações
    end;

end; { ******************************************************  }
{  ******************************** }
procedure TFmPrincipal.RichEditSelectionChange(Sender: TObject);
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(RichEdit.Handle, EM_EXLINEFROMCHAR, 0, RichEdit.SelStart);
  CharPos.X := (RichEdit.SelStart - SendMessage(RichEdit.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);

  IdentificaDado(CharPos.Y,CharPos.X);

end;
{
   **********************************************************
}
procedure TFmPrincipal.IdentificaDado(X,Y:integer);
var
  S,S1:string;
begin

  if LBox_NomesArquivos.ItemIndex > -1 then begin

     S1:= LBox_NomesArquivos.Items[LBox_NomesArquivos.ItemIndex];
     S1:= S1 + ' [Col:'+IntToStr(Y) +', Lin:'+IntToStr(X) + ']';

     {  **********  Cadastro ******** }
     if LBox_NomesArquivos.ItemIndex = 2 then begin
        If Y<11 then
           s:= S1 + ' 1->10, ID do funcionário - Será utilizado na biometria '
        else if Y<25  then s:= S1 + ' 11->24, Código Cartão'
        else if Y<27  then s:= S1 + ' 25->26, Tabela de expediente'
        else if Y=27  then s:= S1 + ' 27, Fixo 0';

     end; { ************************************** }

     {  **********  Expediente ******** }
     if LBox_NomesArquivos.ItemIndex = 3 then begin
        If Y<5 then
           s:= S1 + ' 1->4, Codigo expediente '
        else if Y=5   then s:= S1 + ' 5, Dia Semana(1-Dom,2-Seg,3-Ter,4-Qua,5-Qui,6-Sex,7-Sab)'
        else if Y<10  then s:= S1 + ' 6->9, Inicial ( minutos )'
        else if Y<14  then s:= S1 + ' 10->13, Final ( minutos )';

     end; { ************************************** }

     {  **********  ID_Matricula ******** }
     if LBox_NomesArquivos.ItemIndex = 4 then begin
        If Y<5 then
           s:= S1 + ' 1->4, ID_Matricula '
        else if Y<05  then s:= S1 + ' 1->4, Codigo identificação '
        else if Y>04  then s:= S1 + ' 5->14, Matricula ';

     end; { ************************************** }

     {  **********  SIRENE ******** }
     if LBox_NomesArquivos.ItemIndex = 5 then begin
        If Y=1 then
           s:= S1 + ' 1, Rele a ser acionado'
        else if Y=2  then s:= S1 + ' 2, Tempo de acionamento do rele - segundos'
        else if Y<8  then s:= S1 + ' 3->7, Horário inicial 1 ( HH:MM  )'
        else if Y<14 then s:= S1 + ' 9->13, Horário final 1 ( HH:MM  )'
        else if y<19 then s:= S1 + ' 14->18, Horário inicial 2 ( HH:MM  )'
        else if y<24 then s:= S1 + ' 19->23, Horário final 2 ( HH:MM  )'
        else if y<28 then s:= S1 + ' 24->28, Horário inicial 3 ( HH:MM  )'
        else if y<30 then s:= S1 + ' 25->29, Horário final 3 ( HH:MM  )'
        else if y<35 then s:= S1 + ' 30->34, Horário inicial 4 ( HH:MM  )'
        else s:= S1 + ' 35->39, Horário final 4 ( HH:MM  )';

     end; { ************************************** }

     {  **********  Configuração ******** }
     if LBox_NomesArquivos.ItemIndex = 6 then begin

        s:= S1 + ' Fixo, Veja DOC! ';

        if  X<3 Then S1:= S1 +'[Leitor '+IntToStr(X)+']';

        if  X<3 Then
            if Y < 4 then s:= S1 + ' 1->3, NNN - Fixo'
            else if Y = 4 then s:= S1 + ' 4, X - checa lista  (S - sim  N - não )'
            else if Y = 5 then s:= S1 + ' 5, 1 - fixo'
            else if Y = 6 then s:= S1 + ' 6, checa biometria (S - sim  N - não )'
            else if Y = 7 then s:= S1 + ' 7, rele entrada (0-não, 1 -rele1 ou 2-rele2)'
            else if Y = 8 then s:= S1 + ' 8, Switch entrada (0–não,  1-aguarda conf.SW1, 2-aguarda conf.SW2'
            else if Y = 9 then s:= S1 + ' 9, rele saida (0-não, 1 -rele1 ou 2-rele2)'
            else if Y = 10 then s:= S1 + ' 10, Switch saida (0–não,  1-aguarda conf.SW1, 2-aguarda conf.SW2'
            else if Y < 13 then s:= S1 + ' 11->12, Tempo de acionamento do rele  - segundos'
            else if Y = 13 then s:= S1 + ' 13, Libera teclado  S - sim  /  N - não'
            else if Y = 14 then s:= S1 + ' 13, Sentido    E - entrada,  S - Saida ou  A - Ambos'
            else if Y = 15 then s:= S1 + ' 15, N - Fixo'
            else if Y < 17 then s:= S1 + ' 16->17, 99 - Fixo'
            else if Y < 20 then s:= S1 + ' 18->19, Numero de dígitos do cartão, 00 para todos tamanho'
            else if Y = 20 then s:= S1 + ' 20, Comunicação S-local(Na lista branca/negra), N-online (Diretamente no servidor)'
            else if Y < 36 then s:= S1 + ' 21->36, Mensagem padrão - primeira linha do display'
            else if Y < 53 then s:= S1 + ' 37->52, Mensagem quando liberado para entrada'
            else if Y > 52 then s:= S1 + ' 52->68, Mensagem quando liberado para saída'
            else s:= S1 + ' **** ';

     end; { **************************** }

     {  **********  Cartão Mestre ******** }
     if LBox_NomesArquivos.ItemIndex = 7 then begin
        if  Y<15 Then
            s:= S1 + ' 1->14, Numero do cartão de liberação ou mestre'
         else if  Y<21 Then
              s:= S1 + ' 15->20, 000000 - fixo';

        if  Y=21 Then s:= S1 + ' 21->, S-cartão mestre / N-cartão de liberação';

     end; { **************************** }

     StatusBar.SimpleText := S;

  end;  { **************************** }

  INC(Auditorias.ARQ);Auditoria; { ** Auditoria do Sistema ** }

end; {  ********************************************* }

procedure TFmPrincipal.LBox_NomesArquivosClick(Sender: TObject);
var
  s:string;
  I:integer;
begin

    MemoArq.Lines.Clear;
    RichEdit.Clear;

 if LBox_NomesArquivos.ItemIndex < 8 then
    if LBox_NomesArquivos.ItemIndex > 1 then begin

       S := LBox_NomesArquivos.Items[LBox_NomesArquivos.ItemIndex];
       sNm := TRIM(ed_Path.Text) + '\' + Trim( Copy( S, POS(':',S)+1, Length(S) ) );

       if FileExists(sNm) then MemoArq.Lines.LoadFromFile(sNm);

       RichEdit.Lines.Clear;
       if MemoArq.Lines.Count > 0 then
          for I:=0 to MemoArq.Lines.Count-1 do
              RichEdit.Lines.Add(MemoArq.Lines[I]);

       Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Aberto '+ sNm);

       RichEdit.SetFocus;

    end; { ******************************************************  }
end;

procedure TFmPrincipal.SB_EnviaCMDClick(Sender: TObject);
var
  S:String;
  N:Integer;
begin

    Mm_LOG.Lines.Add(DateTimeToStr(now) +' : Formato CMD a enviar '+ CB_MSG.Text);

    // if CB_MSG.ItemIndex=4 then EnviaComandoXP;

 if (CB_MSG.ItemIndex=0) or  (CB_MSG.ItemIndex=5) then
    Ed_Resposta.Text := CB_MSG.Items[CB_MSG.ItemIndex];

 if CB_MSG.ItemIndex>0 then
    if CB_MSG.ItemIndex<3 then begin

          { ***************** }

    end
    else if ((CB_MSG.ItemIndex>2) and (CB_MSG.ItemIndex<5)) then begin
       { !CIMMMMMMMMMMCCCCCCCCCCCCCCEEIIII }

       if CB_MSG.ItemIndex=3 then Ed_Resposta.Text := '!CI';
       if CB_MSG.ItemIndex=4 then Ed_Resposta.Text := '!CE';

       S:='0000000000'+InputBox('BIOMETRIA-matricula',
          'Numero da matricula a cadastrar' + chr(10) + chr(13),
          '0000009001');

       Ed_Resposta.Text := Ed_Resposta.Text + trim(copy(S,length(S)-9,11));

       S:= '00000000000000'+InputBox('BIOMETRIA-Cartão',
          'Numero do cartão a cadastrar' + chr(10) + chr(13),
          '12345678909001');

       Ed_Resposta.Text := Ed_Resposta.Text + trim(copy(S,length(S)-13,15));

       S:= '00' + InputBox('BIOMETRIA-Expediente',
          'Numero identificando o Expediente' + chr(10) + chr(13),
          '20');

       Ed_Resposta.Text := Ed_Resposta.Text + trim(copy(S,length(S)-1,3));

       S:= '0000' + InputBox('BIOMETRIA-Identifica',
          'ID, identificando a biometria' + chr(10) + chr(13),
          '9001');

       Ed_Resposta.Text := Ed_Resposta.Text + trim(copy(S,length(S)-3,5));

    end;

    S := TRIM(Ed_Resposta.Text);
    N := Length(S);

    StatusBar.SimpleText := S +' -> Coletor';

    Mm_LOG.Lines.Add(DateTimeToStr(now) +' : CMD a enviado '+ S +' -> Coletor');

end;
{
  ********************************************************
}
procedure TFmPrincipal.ExibeMarca(Nome:string); // Exibe Marcas
var
  myFile : TextFile;
  S,text   : string;
  I:integer;
begin

  Mm_Marcas.Clear;
  PCMain.ActivePageIndex := 2; // Pagina Dados
  AssignFile(myFile, Nome);
  Reset(myFile);

  // Display the file contents
  while not Eof(myFile) do
  begin
    Readln(myFile, text);
    S:='';
    For I:=1 to Length(text) do
        if length(TRIM(text[I]))>0 then S:= S + text[I];

    Mm_Marcas.Lines.Add( S );

  end;

  // Close the file for the last time
  CloseFile(myFile);

end;
{****************************************************}
{**********   IniSuprema, Turn On Biomini.  *********}
{****************************************************}
procedure TFmPrincipal.SB_INIClick(Sender: TObject);
begin
end;
{****************************************************}
{*******  UpgrSuprema, Turn On Biomini again.  ******}
{****************************************************}
procedure TFmPrincipal.SB_UPGRADEClick(Sender: TObject);
begin
end;
{****************************************************}
{**********   UnIniSuprema, Turn Off Biomini.  *********}
{****************************************************}
procedure TFmPrincipal.SB_UNIINITClick(Sender: TObject);
begin
end;
{
  ****************************************************
}
procedure TFmPrincipal.SB_SENDClick(Sender: TObject);
begin
end;
{****************************************************}
{******** CaptureSuprema, Storage template. *********}
{****************************************************}
procedure TFmPrincipal.SB_CAPTUREClick(Sender: TObject);
begin
end;
{****************************************************}
{ ** EnrollSuprema, Storage template in the Array. **}
{****************************************************}
procedure TFmPrincipal.SB_ENROLLClick(Sender: TObject);
begin
end;
{****************************************************}
{ ****** VerifySuprema, Match between templates. ****}
{****************************************************}
procedure TFmPrincipal.SB_VERIFYClick(Sender: TObject);
begin
end;
{
  *******************************************************
}
procedure TFmPrincipal.SB_REICEIVEClick(Sender: TObject);
begin
end;
{
  ***********************************************
}
procedure TFmPrincipal.TimerTemplateTimer(Sender: TObject);
var
  // aMsg    : array[0..256] of Char;
  nNumMsg : integer;
  // s       : String;
begin

    nNumMsg := XPnetmRxBufCount(CB_COM.ItemIndex);

end;  { ******************************************************  }

procedure TFmPrincipal.EditIPChange(Sender: TObject);
begin

    if TRIM(EditIP.Text)='' then
        ChkBxSocket.Checked:=false;

end;
{
   ***************************************************************
}
procedure TFmPrincipal.CaptureFingerprint2;
begin
end;
{
 ********************************************************
}
function TFmPrincipal.CaptureFingerprint1 : String;
begin
end;

// **************

procedure TFmPrincipal.LOG1Click(Sender: TObject);
begin

    PCmain.ActivePageIndex := 0;

end;

procedure TFmPrincipal.OnLine1Click(Sender: TObject);
begin

    PCmain.ActivePageIndex := 2;

end;

procedure TFmPrincipal.Ajuda1Click(Sender: TObject);
begin

PCmain.ActivePageIndex := 3;

end;

end.{ ******************************************************  }
