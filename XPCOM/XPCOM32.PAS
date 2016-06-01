{-------------------------------------------------------------------------------
 TRIX Tecnologia Ltda.
--------------------------------------------------------------------------------
 Projeto.........: Biblioteca de Comunicacao XPCOMLIB
 Modulo..........: XPCOM32.PAS (arquivo de interface para Delphi)
 Versao..........: 2.30
 Compilacao......: Delphi 2.0 / 3.0
 Ambientes.......: Windows 95/NT
 Ultima alteracao: 10/10/2003
 Responsavel.....: VM
-------------------------------------------------------------------------------}

unit XPCom32;

interface

uses WinTypes;

{-------------------------------------------------------------------------------
 Numeros de Canais de Comunicacao
-------------------------------------------------------------------------------}

const
   COM1          = 0;
   COM2          = 1;
   COM3          = 2;
   COM4          = 3;
   COM5          = 4;
   COM6          = 5;
   COM7          = 6;
   COM8          = 7;
   COM9          = 8;
   COM10         = 9;
   COM11         = 10;
   COM12         = 11;
   COM13         = 12;
   COM14         = 13;
   COM15         = 14;
   COM16         = 15;
   COMCHANNELS   = 128;
   COMLAST       = 127;
   IPCHANNELS    = 256;

{-------------------------------------------------------------------------------
 Mascaras de Erros de Comunicacao
-------------------------------------------------------------------------------}

const
   COM_RXOVER  = 1;                             { Receive Queue overflow }
   COM_OVERUN  = 2;                             { Erro de overrun na recepcao   }
   COM_PARITY  = 4;                             { Erro de paridade na recepcao }
   COM_FRAME   = 8;                             { Erro de framing na recepcao }
   COM_BREAK   = 16;                            { Deteccao de break }
   COM_RXBFUL  = 128;                           { Erro de buffer de recepcao cheio }
   COM_TXFULL  = 256;                           { TX Queue is full }
   COM_MODE    = 32768;                         { Requested mode unsupported }

{-------------------------------------------------------------------------------
 Codigos para obtencao de configuracao do canal
-------------------------------------------------------------------------------}

const
   COMCFG_OPEN    = 1;                          { canal aberto }
   COMCFG_RATE    = 2;                          { taxa de comunicacao }
   COMCFG_NBITS   = 3;                          { numero de bits}
   COMCFG_NSTOP   = 4;                          { numero de stop-bits}
   COMCFG_PAR     = 5;                          { paridade }
   COMCFG_TXFLOW  = 6;                          { controle de fluxo na transmissao }
   COMCFG_RXFLOW  = 7;                          { controle de fluxo na recepcao }
   COMCFG_BUFRX   = 8;                          { tamanho do buffer de recepcao }
   COMCFG_BUFTX   = 9;                          { tamanho do buffer de transmissao }
   COMCFG_IPADDR  = 10;                         { endereco para acessar uma porta via IP }

{-------------------------------------------------------------------------------
 Constantes Diversas
-------------------------------------------------------------------------------}

const
   COM_NONEP      = 0;                          { Sem paridade }
   COM_ODDP       = 1;                          { Paridade impar }
   COM_EVENP      = 2;                          { Paridade par }
   COM_NOFLOW     = 0;                          { Sem controle de fluxo }
   COM_RTSCTS     = 1;                          { Controle de fluxo RTS/CTS }
   COM_XONXOFF    = 2;                          { Controle de fluxo XON/XOFF }
   COM_OFF        = 0;                          { Sinal desativo }
   COM_ON         = 1;                          { Sinal ativo }
   COM_MINRXB     = 16;                         { Tamanho minimo do buffer de recepcao }
   COM_MAXRXB     = 65500;                      { Tamanho maximo do buffer de recepcao }
   COM_MINTXB     = 16;                         { Tamanho minimo do buffer de transmissao }
   COM_MAXTXB     = 65500;                      { Tamanho maximo do buffer de transmissao }
   COM_MAXIPLEN   = 100;                        { tamanho maximo de um endereco IP }
   COM_MINIPPORT  = 0;                          { endereco minimo de uma porta IP }
   COM_MAXIPPORT  = 65535;                      { endereco maximo de uma porta IP }

{-------------------------------------------------------------------------------
 Tipos de Comunicacao atraves da rede XPnet
-------------------------------------------------------------------------------}

const
   XPN_COMHALF    = 0;                          { operacao half-duplex }
   XPN_COMFULL    = 1;                          { operacao full-duplex }
   XPN_COMAUTO    = 2;                          { operacao half-duplex automatica }
   XPN_COMIP      = 3;                          { operacao com socket }

{-------------------------------------------------------------------------------
 Status de Comunicacao de Rede XPnet
-------------------------------------------------------------------------------}

const
   XPN_STATIDLE   = 0;                          { comunicacao inativa }
   XPN_STATACTIVE = 1;                          { comunicacao ativa }
   XPN_STATOK     = 2;                          { comunicacao inativa OK }
   XPN_STATERROR  = 3;                          { comunicacao inativa com erro }

{-------------------------------------------------------------------------------
 Codigos para Obtencao da Configuracao da Rede XPnet
-------------------------------------------------------------------------------}

const
   XPNCFG_OPEN       = 1;                       { verificar se rede esta aberta no canal }
   XPNCFG_RATE       = 2;                       { taxa de comunicacao }
   XPNCFG_BUFRXMSG   = 3;                       { tamanho do buffer de recepcao de mensagens }
   XPNCFG_BUFTXMSG   = 4;                       { tamanho do buffer de transmissao de mensagens }
   XPNCFG_POLLSTART  = 5;                       { verificacao se polling esta ativo }
   XPNCFG_POLLINT    = 6;                       { verificacao de intervalo entre pollings }
   XPNCFG_POLLTERM   = 7;                       { verificacao de polling de terminal }

{-----------------------------------------------------------------------------
 Codigos para alteracao do valor do timeout da rede
-----------------------------------------------------------------------------}

   XPNWAIT_ACK       = 1;                       { tempo maximo de espera de ACK ou SOH }
   XPNWAIT_CHAR      = 2;                       { tempo maximo de espera de caractere }
   XPNWAIT_POLL      = 3;                       { tempo maximo de espera de pooling }

{-------------------------------------------------------------------------------
 Codigos para retorno de estatisticas na funcao XPnetTermStat
-------------------------------------------------------------------------------}

const
   XPNSTAT_ERROR     = 0;                       { erro de comunicacao corrente }
   XPNSTAT_LASTERROR = 1;                       { ultimo erro de comunicacao }
   XPNSTAT_CHIPERROR = 2;                       { erro do driver de comunicacao }
   XPNSTAT_STATUS    = 3;                       { ultimo status do terminal }
   XPNSTAT_POLLS     = 4;                       { numero de mensagens de requisicao de dados transmitidas }
   XPNSTAT_TXMSGS    = 5;                       { numero de mensagens de comando transmitidas }
   XPNSTAT_TXDATA    = 6;                       { numero de bytes de dados transmitidos }
   XPNSTAT_RXMSGS    = 7;                       { numero de mensagens de dados recebidas do terminal }
   XPNSTAT_RXDATA    = 8;                       { numero de bytes de dados recebidos do terminal }
   XPNSTAT_ERRORS    = 9;                       { numero de erros }
   XPNSTAT_RETRIES   = 10;                      { numero de tentativas }

{-------------------------------------------------------------------------------
 Codigos de Tipos de Transferencia de Programa/Arquivo
-------------------------------------------------------------------------------}

const
   XPNXFER_TXPROG    = 0;                       { Transmissao de programa }
   XPNXFER_RXPROG    = 1;                       { Recepcao de programa }
   XPNXFER_TXFILE    = 2;                       { Transmissao de arquivo }
   XPNXFER_RXFILE    = 3;                       { Recepcao de arquivo }

{-------------------------------------------------------------------------------
 Codigos de erro retornados pelas funcoes do Driver de Comunicacao
-------------------------------------------------------------------------------}

const
   COM_OK         = 0;                          { Resultado OK }
   COM_INVPRM     = -1;                         { Parametros invalidos (Clipper)}
   COM_INVCOM     = -2;                         { Canal de comunicacao invalido }
   COM_INVINT     = -3;                         { Numero de interrupcao invalido }
   COM_INVNBT     = -4;                         { Numero de bits invalido }
   COM_INVRAT     = -5;                         { Taxa de comunicacao invalida }
   COM_INVNSB     = -6;                         { Numero de stop-bits invalido }
   COM_INVPAR     = -7;                         { Paridade invalida }
   COM_INVBUF     = -8;                         { Tamanho de buffer invalido }
   COM_INVFLW     = -9;                         { Tipo de controle de fluxo invalido }
   COM_ISOPEN     = -10;                        { Canal de comunicacao ja' esta' aberto }
   COM_NTOPEN     = -11;                        { Canal de comunicacao nao esta' aberto }
   COM_NOMEM      = -12;                        { Memoria insuficiente para a operacao }
   COM_TXBFUL     = -13;                        { Buffer de transmissao cheio }
   COM_RXBEMP     = -14;                        { Buffer de recepcao vazio }
   COM_INVSTE     = -15;                        { Estado de sinal invalido }
   COM_INVPORT    = -16;                        { Porta invalida ou erro de hardware }
   COM_INVCFG     = -17;                        { Codigo de configuracao invalido }
   COM_RXERROR    = -18;                        { Erro de recepcao de caractere }
   COM_CLOSE      = -19;                        { Erro no fechamento do canal }
   COM_TXERROR    = -20;                        { Erro na transmissao }
   COM_APIERROR   = -21;                        { Erro retornado pela API do WIndows }
   COM_INVSOCK    = -22;                        { Socket invalido }
   COM_INVADDR    = -23;                        { Endereco IP ou URL de host invalido }
   COM_SOCKET_ERROR = -24;                      { Erro ao acessar o Socket. Obter detalhes com ComGetErrors }

{-------------------------------------------------------------------------------
 Codigos de erro retornados pelas funcoes da XPnet
-------------------------------------------------------------------------------}

const
   XPN_INVCOM     = -100;                       { canal de comunicacao invalido }
   XPN_INVTYPE    = -101;                       { tipo de comunicacao invalido }
   XPN_INVRETRIES = -102;                       { numero de tentativas de comunicacao invalido }
   XPN_ISOPEN     = -103;                       { rede ja esta aberta para canal especificado }
   XPN_NOMEM      = -104;                       { sem memoria para operacao da rede }
   XPN_NOTOPEN    = -105;                       { rede nao esta aberta para canal especificado }
   XPN_INVADDR    = -106;                       { endereco de terminal invalido }
   XPN_INVTERM    = -107;                       { numero de terminal invalido }
   XPN_NOTIMERS   = -108;                       { sem timers disponiveis }
   XPN_TXBFULL    = -109;                       { buffer de transmissao de mensagens cheio }
   XPN_RXBEMPTY   = -110;                       { buffer de recepcao    de mensagens vazio }
   XPN_RXBFULL    = -111;                       { buffer de recepcao    de mensagens cheio }
   XPN_RXTIMEOUT  = -112;                       { time-out durante recepcao }
   XPN_RXCRC1     = -113;                       { erro no CRC1 }
   XPN_RXCRC2     = -114;                       { erro no CRC2 }
   XPN_POLLON     = -115;                       { polling ja esta ativo }
   XPN_POLLOFF    = -116;                       { polling esta desativo }
   XPN_POLLINVINT = -117;                       { intervalo de polling e' invalido }
   XPN_POLLINVN   = -118;                       { numero de requisicoes de polling invalido }
   XPN_TXTMOUT    = -119;                       { timeout de transmissao }
   XPN_ACKTIMEOUT = -120;                       { timeout de espera de ACK }
   XPN_INVCFG     = -121;                       { consulta de configuracao invalida }
   XPN_THREADPRI  = -122;                       { erro no estabelecimendo da prioridade de thread }
   XPN_COMACTIVE  = -123;                       { comunicacao continua ativa apos varias verificacoes }

{-------------------------------------------------------------------------------
 Codigos de erro retornados pelas funcoes de Transmissao / Recepcao de Arquivos
-------------------------------------------------------------------------------}

const
   XPN_NOTTXMSG   = -200;                       { Mensagem nao foi transmitida }
   XPN_OPENFILE   = -201;                       { Abertura de arquivo }
   XPN_NOMEMOP    = -202;                       { Memoria insuficiente para operacao }
   XPN_READFILE   = -203;                       { Problema na leitura do arquivo }
   XPN_WRITEFILE  = -204;                       { Problema na escrita do arquivo }
   XPN_ERRRXMSG   = -205;                       { Recepcao de mensagens }
   XPN_USRABT     = -206;                       { Aborto pelo usuario }
   XPN_REMTMOUT   = -207;                       { Time-out de modo remoto }
   XPN_TRANSFER   = -208;                       { Transferencia ativa no canal especificado }

{-------------------------------------------------------------------------------
 Definicao de Tipos de Campos para Conversao de Arquivos e outras constantes
-------------------------------------------------------------------------------}

const
   XPFLD_INT      =   1;                        { campo inteiro }
   XPFLD_FLO      =   2;                        { campo numerico em ponto flutuante }
   XPFLD_STR      =   4;                        { campo string }
   XPBHDRSIZE     =   128;                      { tamanho do header de arquivo XPbasic }
   XPBMAXFIELDS   =   10;                       { numero maximo de campos por registro }
   XPBMAXRECORDS  =   65000;                    { numero maximo de registros de arquivo XPBASIC }

   XPLTERM_CRLF   =   0;                        { terminador CRLF }
   XPLTERM_CR     =   1;                        { terminador CR }
   XPLTERM_LF     =   2;                        { terminador LF }

{*------------------------------------------------------------------------------
 Codigos de Erros Retornados pelas Funcoes de Conversao de Arquivos
-------------------------------------------------------------------------------}

const
   XPN_ERRFILE    =  -300;                      { Problema em acesso a arquivo }
   XPN_INVFILE    =  -301;                      { Formato do arquivo a ser convertido nao foi reconhecido. }
   XPN_ERRMAXF    =  -302;                      { Numero de campos maior que 10 }
   XPN_ERRMAXR    =  -303;                      { Numero de registros maior que o maximo }
   XPN_ERRSTRUC   =  -304;                      { Estruturas incompativeis }
   XPN_NOFLOAT    =  -305;                      { Ponto flutuante nao suportado }

{-------------------------------------------------------------------------------
 Codigos de Erros Retornados pelas Funcoes de Protocolo XMODEM
-------------------------------------------------------------------------------}

const
   XPM_ACTIVE     =  1;                         { comunicacao ativa }
   XPM_ISOPEN     =  -400;                      { protocolo ja  esta' aberto }
   XPM_NOTOPEN    =  -401;                      { protocolo nao esta' aberto }
   XPM_NOMEM      =  -402;                      { sem memoria para operacao }
   XPM_NAKTIMEOUT =  -403;                      { timeout de espera de NAK inicial }
   XPM_ACKTIMEOUT =  -404;                      { timeout de espera de ACK }
   XPM_RXNAK      =  -405;                      { recepcao de NAK apos transmissao de bloco }
   XPM_ERRFILE    =  -406;                      { problema no acesso ao arquivo }
   XPM_USERABORT  =  -407;                      { aborto pelo usuario }
   XPM_REMABORT   =  -408;                      { aborto remoto }
   XPM_RXINVBLK   =  -409;                      { recepcao de bloco invalido (apos N tentativas) }
   XPM_SOHTIMEOUT =  -410;                      { timeout de recepcao de SOH }
   XPM_RXTIMEOUT  =  -411;                      { timeout de recepcao de caractere }
   XPM_INVCONFIG  =  -412;                      { configuracao invalida }

{------------------------------------------------------------------------------
 Constantes de Configuracao do Protocolo XMODEM
------------------------------------------------------------------------------}

const
   XPM_TXINIT_TIMEOUT      =  1;                { time-out de espera inicial da transmissao }
   XPM_TXACK_TIMEOUT       =  2;                { time-out de espera de ACK apos transmissao de bloco }
   XPM_TXACKEOT_TIMEOUT    =  3;                { time-out de espera de ACK apos EOT }
   XPM_RXNAKINIT_TIMEOUT   =  4;                { time-out entre envio de NAKs iniciais }
   XPM_RXSOH_TIMEOUT       =  5;                { time-out de espera de SOH apos envio de ACK ou NAK }
   XPM_RXERRSOH_TIMEOUT    =  6;                { time-out de espera de SOH apos erro na recepcao de SOH }
   XPM_RXBLOCK_TIMEOUT     =  7;                { time-out de espera de bloco apos SOH }
   XPM_RXMAXERRORS         =  8;                { numero maximo de erros de recepcao antes de abortar comunicacao }

{-------------------------------------------------------------------------------
 Estrutura de Status de Cada Terminal da Rede XPnet (em relacao ao Concetrador
--------------------------------------------------------------------------------}

type
   PXPNETMSTATS = ^XPNETMSTATS;                 { Ponteiro para XPNETMSTATS }
   XPNETMSTATS  = record
   nError:     longint;                         { erro corrente de comunicacao }
   nLastError: longint;                         { ultimo erro de comunicacao }
   nChipError: longint;                         { erro do driver de comunicacao }
   dwStatus:   longint;                         { ultimo status do terminal }
   dwTxPolls:  longint;                         { numero de mensagens de requisicao de dados }
   dwTxMsgs:   longint;                         { numero de mensagens de comando transmitidas }
   dwTxData:   longint;                         { numero de bytes de dados transmitidos }
   dwRxMsgs:   longint;                         { numero de mensagens de dados recebidas do terminal }
   dwRxData:   longint;                         { numero de bytes de dados recebidos do terminal }
   dwErrors:   longint;                         { numero de erros }
   dwRetries:  longint;                         { numero de tentativas }
  end;

{-------------------------------------------------------------------------------
 Estrutura Descritora de Formato de Arquivo a ser Gerado pelas Conversoes
-------------------------------------------------------------------------------}
type
   CONVFILEFIELD = record
      cName:   array[0..10] of Char;            { nome do campo }
      cType:   Byte;                            { tipo do campo }
      cLength: Byte;                            { tamanho do campo }
      cDec:    Byte;                            { numero de casas decimais }
end;

type
   PCONVFILEFORMAT = ^CONVFILEFORMAT;
   CONVFILEFORMAT = record
      cFields: Byte;                            { numero de campos }
      Field:  array[0..9] of CONVFILEFIELD;     { campos }
end;

{----------------------------------------------------------------------------
 Estrutura de Status de Protocolo XMODEM
----------------------------------------------------------------------------}

type
   PXMODEMSTATS = ^XMODEMSTATS;
   XMODEMSTATS = record
   nStatus:    longint;                         { Status / Erro corrente }
   nTxTotal:   longint;                         { Numero total de blocos a transmitir }
   nTxBlocks:  longint;                         { Numero total de blocos transmitidos }
   nRxBlocks:  longint;                         { Numero de blocos recebidos }
   end;

{-------------------------------------------------------------------------------
 Estrutura de Status de Transferencia de Arquivo atraves de Rede XPnet
-------------------------------------------------------------------------------}

type
   PXPNET_TRANSFER_STAT = ^XPNET_TRANSFER_STAT;
   XPNET_TRANSFER_STAT = record
   nActive:    longint;                         { Status / Erro corrente }
   nType:      longint;                         { Tipo de transferencia }
   nTerm:      longint;                         { Terminal sendo utilizado }
   nError:     longint;                         { Ultimo erro ocorrido }
   nTxTotal:   longint;                         { Numero total de blocos a transmitir }
   nTxBlocks:  longint;                         { Numero de blocos transmitidos }
   nRxTotal:   longint;                         { Numero total de blocos a receber }
   nRxBlocks:  longint;                         { Numero de blocos recebidos }
   end;

{-------------------------------------------------------------------------------
 Tipos de ponteiros utilizados por algumas funcoes da biblioteca
-------------------------------------------------------------------------------}

type
   PDOUBLE = ^double;                          { Ponteiro para double }

{-------------------------------------------------------------------------------
 Declaracao das Funcoes Publicas da Biblioteca
-------------------------------------------------------------------------------}

Procedure XPComVersion(szVersion: PChar); stdcall;

Function ComSetAddress(nChannel: Longint; nInfoType: Longint; pInfo: Pointer; nInfo: Longint): Longint; stdcall;
Function ComOpen(nChannel: longint; wRate: Longint; nBits: longint; nStop: longint; nParid: Longint; nTxFlow:   Longint; nRxFlow: Longint; wTxBuffer: Longint; wRxBuffer:   Longint): Longint; stdcall;
function ComConfig(nChannel: Longint; nRate: Longint; nBits: Longint; nStop: Longint; nParid: Longint; nTxFlow: Longint; nRxFlow:   Longint): Longint; stdcall;
function ComClose(nChannel: Longint): Longint; stdcall;
function ComGetConfig(nChannel: Longint; nInfo: Longint): longint; stdcall;
function ComGetnRx(nChannel: Longint): longint; stdcall;
function ComGetnTx(nChannel: Longint): longint; stdcall;
function ComGetfRx(nChannel: Longint): longint; stdcall;
function ComGetfTx(nChannel: Longint): longint; stdcall;
function ComGetErrors(nChannel: Longint):Longint; stdcall;
function ComClearErrors(nChannel: Longint):Longint; stdcall;
function ComClearRxBuffer(nChannel: Longint): Longint; stdcall;
function ComClearTxBuffer(nChannel: Longint):Longint; stdcall;
function ComClearTxRx(nChannel: Longint): Longint; stdcall;
function ComRxChar(nChannel: Longint): Longint; stdcall;
function ComRxData(nChannel: Longint; cBuffer:   PChar; wBytes: Longint): Longint; stdcall;
function ComTxChar(nChannel: Longint; cTx: Char): Longint; stdcall;
function ComTxData(nChannel: Longint; cBuffer:   PChar; wBytes: Longint): Longint; stdcall;
function ComGetCTS(nChannel: Longint): Longint; stdcall;
function ComGetDCD(nChannel: Longint): Longint; stdcall;
function ComGetDSR(nChannel: Longint): Longint; stdcall;
function ComGetRI(nChannel: Longint): Longint; stdcall;
function ComSetDTR(nChannel: Longint; nState: Longint):Longint; stdcall;
function ComSetRTS(nChannel: Longint; nState: Longint): Longint; stdcall;
function ComSetBREAK(nChannel: Longint; nState: Longint): Longint; stdcall;

Function XPnetmOpen(nChannel: Longint; nRate: Longint; wTxBuffer: Longint; wRxBuffer: Longint; nComType: Longint; nMaxRetries: Longint): Longint; stdcall;
Function XPnetmClose(nChannel: Longint): Longint; stdcall;
Function XPnetmComStatus(nChannel: Longint): Longint; stdcall;
Function XPnetmComError(nChannel: Longint): Longint; stdcall;
Function XPnetmTxMsg(nChannel: Longint; nTerm: Longint; pMsg: PChar; wBytes: Longint): Longint; stdcall;
Function XPnetmTxMsgPoll(nChannel: Longint; nTerm: Longint): Longint; stdcall;
Function XPnetmTxMsgAttention(nChannel: Longint; nTerm: Longint): Longint; stdcall;
Function XPnetmTxMsgStatus(nChannel: Longint; nTerm: Longint): Longint; stdcall;
Function XPnetmTxBufCount(nChannel: Longint): Longint; stdcall;
Function XPnetmTxBufBytes(nChannel: Longint): Longint; stdcall;
Function XPnetmTxBufFree(nChannel: Longint): Longint; stdcall;
Function XPnetmTxBufClear(nChannel: Longint): Longint; stdcall;
Function XPnetmRxMsgBytes(nChannel: Longint): Longint; stdcall;
Function XPnetmRxMsg(nChannel: Longint; sMsg: PChar): Longint; stdcall;
Function XPnetmRxBufCount(nChannel: Longint): Longint; stdcall;
Function XPnetmRxBufBytes(nChannel: Longint): Longint; stdcall;
Function XPnetmRxBufFree(nChannel: Longint): Longint; stdcall;
Function XPnetmRxBufClear(nChannel: Longint): Longint; stdcall;
Function XPnetmPollStart(nChannel: Longint; wInterval: Longint): Longint; stdcall;
Function XPnetmPollStop(nChannel: Longint): Longint; stdcall;
Function XPnetmPollTerm(nChannel: Longint; nTerm: Longint; nPolls: Longint): Longint; stdcall;
Function XPnetmTermInfo(nChannel: Longint; nTerm: Longint; pStat: PXPNETMSTATS): Longint; stdcall;
Function XPnetmTermInfoClear(nChannel: Longint; nTerm: Longint): Longint; stdcall;
Function XPnetmGetConfig(nChannel: Longint; nInfo: Longint; nParm: Longint): Longint; stdcall;
Function XPnetmSetTimeout(nChannel: Longint; nTipo: Longint; wTime: Longint): Longint; stdcall;

Function XPnetmWaitCom(nChannel: Longint): Longint; stdcall;
Function XPnetmRemote(Wnd: hWnd; nChannel: Longint; nTerm: Longint; nActive: Longint): Longint; stdcall;
Function XPnetmTxClock(Wnd: hWnd; nChannel: Longint; nTerm: Longint): Longint; stdcall;
Function XPnetmTxCmd(Wnd: hWnd; nChannel: Longint; nTerm: Longint; pCmd: PChar): Longint; stdcall;

Function XPnetmTxProg(Wnd: hWnd; nChannel: Longint; nTerm: Longint; pProg: PChar): Longint; stdcall;
Function XPnetmTxProgStart(nChannel: Longint; nTerm: Longint; pProg: PChar; pText: PChar): Longint; stdcall;
Function XPnetmTxProgAbort(nChannel: Longint): Longint; stdcall;

Function XPnetmRxProg(Wnd: hWnd; nChannel: Longint; nTerm: Longint; pProg: PChar): Longint; stdcall;
Function XPnetmRxProgStart(nChannel: Longint; nTerm: Longint; pProg: PChar; pText: PChar): Longint; stdcall;
Function XPnetmRxProgAbort(nChannel: Longint): Longint; stdcall;

Function XPnetmTxFile(Wnd: hWnd; nChannel: Longint; nTerm: Longint; pFile: PChar; nFile: Longint): Longint; stdcall;
Function XPnetmTxFileStart(nChannel: Longint; nTerm: Longint; pProg: PChar; nFile: Longint; pText: PChar): Longint; stdcall;
Function XPnetmTxFileAbort(nChannel: Longint): Longint; stdcall;

Function XPnetmRxFile(Wnd: hWnd; nChannel: Longint; nTerm: Longint; pFile: PChar; nFile: Longint): Longint; stdcall;
Function XPnetmRxFileStart(nChannel: Longint; nTerm: Longint; pProg: PChar; nFile: Longint; pText: PChar): Longint; stdcall;
Function XPnetmRxFileAbort(nChannel: Longint): Longint; stdcall;

Function XPnetmTransferStatus(nChannel: Longint; pS: PXPNET_TRANSFER_STAT): Longint; stdcall;

Procedure FXPBasicConvToDouble    (pcF1: PChar;  pdF2: PDOUBLE);  stdcall;
Procedure FXPBasicConvFromDouble  (dVal: double; pbF:  PChar);  stdcall;

Function FXPBasicConvToDBF    (pFileOrg: PChar; pFileDest: PChar ; pF: PCONVFILEFORMAT): Longint;  stdcall;
Function FXPBasicConvFromDBF  (pFileOrg: PChar; pFileDest: PChar ; pF: PCONVFILEFORMAT): Longint;  stdcall;
Function FXPBasicConvToAsc    (pFileOrg: PChar; pFileDest: PChar ; nLineTerm: Longint): Longint;  stdcall;
Function FXPBasicConvFromAsc  (pFileOrg: PChar; pFileDest: PChar ; pF: PCONVFILEFORMAT): Longint;  stdcall;
Function FXPBasicConvToText   (pFileOrg: PChar; pFileDest: PChar ; nLineTerm: Longint): Longint;  stdcall;
Function FXPBasicConvFromText (pFileOrg: PChar; pFileDest: PChar ; pF: PCONVFILEFORMAT): Longint;  stdcall;

Function XModemTxConfig       (nChannel: longint; nConfig: Longint; nValue: Longint): Longint;  stdcall;
Function XModemTxFileStart    (nChannel: Longint; pszFile: PChar): Longint;  stdcall;
Function XModemTxAbort        (nChannel: Longint): Longint ; stdcall;
Function XModemTxStatus       (nChannel: Longint; pStat: PXMODEMSTATS): Longint; stdcall;
Function XModemRxConfig       (nChannel: longint; nConfig: Longint; nValue: Longint): Longint;  stdcall;
Function XModemRxFileStart    (nChannel: Longint; pszFile: PChar): Longint;  stdcall;
Function XModemRxAbort        (nChannel: Longint): Longint ; stdcall;
Function XModemRxStatus       (nChannel: Longint; pStat: PXMODEMSTATS): Longint; stdcall;

{-------------------------------------------------------------------------------
 Status de Comunicacao de comandos para Base RF, retornados por RFnetWairResult
-------------------------------------------------------------------------------}

const
RFN_STATIDLE               =  0;     { comunicacao inativa }
RFN_STATACTIVE             =  1;     { comunicacao ativa }
RFN_STATOK                 =  2;     { comunicacao inativa OK }
RFN_STATERROR              =  3;     { comunicacao inativa com erro }

{-------------------------------------------------------------------------------
 Codigos de retorno da funcao RFnetGetResult e RFnetWaitResult
-------------------------------------------------------------------------------}

const
RFN_ACTIVE                 = -2;     { esperando resposta }
RFN_RESULTERR              = -1;     { retornou erro de comando/parametro }
RFN_RESULTIDLE             =  0;     { nao tem pedido pendente }

RFN_RV                     =  1;     { retornou numero da versao }

RFN_TM                     =  2;     { retornou mensagem aceita }
RFN_TP                     =  3;     { retornou Ping aceito }

RFN_CP                     =  4;     { retornou configure-param. OK }
RFN_VP                     =  5;     { retornou visualize-parameter }

RFN_RTS                    =  6;     { retornou Estatisitca de coletor }
RFN_ITS                    =  7;     { retornou Reset-stat-de-coletor OK }

RFN_RRS                    =  8;     { retornou Estatistica de repetidor }
RFN_IRS                    =  9;     { retornou Reset-stat-de repet. OK }

RFN_CR                     = 10;     { retornou visualize-parameter }
RFN_VR                     = 11;     { retornou visualize-parameter }

{-------------------------------------------------------------------------------
 Codigos de retorno da funcao RFnetRxMsg
-------------------------------------------------------------------------------}

RFN_ERRMSG                 = -4;     { chegou mensagem com erro de formatacao em RFnetRxMsg }
RFN_RM                     = 12;     { chegou mensagem }
RFN_MT                     = 13;     { retornou mensagem transmitida c/ sucesso }
RFN_ETM                    = 14;     { retornou erro  na transmissao de Msg }
RFN_PR                     = 15;     { Ping tranmitido com sucesso }
RFN_ETP                    = 16;     { retornou erro  na transmissao de Ping }
RFN_EV                     = 17;     { chegou msg de evento }

{-------------------------------------------------------------------------------
 Codigos para configuracao da rede RF
-------------------------------------------------------------------------------}

const
RFNCFG_NETID               =  1;     { Configura numero de identificacao desta  rede de Radio (0 a 255). }
RFNCFG_RFRETRIES           =  2;     { Configura numero de tentativas de retransmissao do radio da Base (0 a 255) }
RFNCFG_RFTIMEOUTACK        =  3;       { Configura tempo para retransmissao de msgs do radio da Base (0 a 255) }
RFNCFG_RFTIMEOUTPONG       =  4;       { Configura tempo de espera de Pong do radio da Base. }
RFNCFG_RADIO0              =  5;       { Ativa/Desativa o Radio 0 da Base. }
RFNCFG_RADIO1              =  6;       { Ativa/Desativa o Radio 1 da base. }
RFNCFG_HOSTMODE            =  7;       { Ativa/desativa modo de comunicacao com Host, na Base. }
RFNCFG_HOSTECHO            =  8;       { Ativa/desativa modo ECHO da Base. }
RFNCFG_HOSTPROT            =  9;       { Ativa/desativa o protocolo de comunicacao na base com correcao de erros. }
RFNCFG_HOSTRATE            = 10;     { Configura a taxa de comunicacao com Host setada na Base. }
RFNCFG_HOSTTIMEOUT         = 11;     { Configura intervalo de tentativas de retransmissao da base para o Host. }
RFNCFG_HOSTRETRIES         = 12;     { Configura numero de tentativas de retransmissao da Base para o Host. }
RFNCFG_NETRETRIES          = 13;     { Configura numero de tentativas de retransmissao da Base para Repetidores. }
RFNCFG_NETTIMEOUT          = 14;     { Configura  o intervalo de retransmissoes de mensagens da Base para Repetidores. }
RFNCFG_NETRATE             = 15;     { Configura a taxa de comunicacao entre Base e Repetidores. }
RFNCFG_REPEAT              = 16;     { Ativa/desativa quais repetidores para conversacao com a Base (estrutura de bits) }
RFNCFG_DEBUGFLAGS          = 17;     { Configura estado dos flags de debug na Base (estrutura de bits) }
RFNCFG_SWITCHES            = 18;     { Configuração das dip-switches da Base RF }

{-------------------------------------------------------------------------------
 Codigos para configuracao do radio da Base
-------------------------------------------------------------------------------}

const
RFNRAD_PREAMBLE            =  1;     { configura nPreamble, ciclos de preambulo }
RFNRAD_WAKEUP              =  2;     { configura nWakeup, tempo de Wake Up do radio }
RFNRAD_SLEEP               =  3;     { configura nSleep, tempo de Sleep do radio }
RFNRAD_TXRX                =  4;     { configura nTxRx, Delay entre Tx e Rx do radio }
RFNRAD_PWR                 =  5;     { configura nPwr, tempo de power up do radio }
RFNRAD_TXBACKOFF           =  6;     { configura nTxBackoff, tempo maxio de Tx Back-off do radio }
RFNRAD_TXSLOT              =  7;     { configura nTxSlot, numero de slot do radio }
RFNRAD_RESSTATE            =  8;     { configura nResetState, estado do switches register do radio apos reset }
RFNRAD_DIAG                =  9;     { configura nDiag }

{-------------------------------------------------------------------------------
 Codigos de Erros retornados pelas funcoes da rede RF
-------------------------------------------------------------------------------}

const
RFN_INVCOM                 = -500;   { canal de comunicacao invalido }
RFN_INVRETRIES             = -501;   { numero de tentativas de comunicacao invalido }
RFN_ISOPEN                 = -502;   { rede ja esta aberta para canal especificado }
RFN_NOMEM                  = -503;   { sem memoria para operacao da rede }
RFN_NOTOPEN                = -504;   { rede nao esta aberta para canal especificado }
RFN_INVTERM                = -505;   { numero de terminal invalido }
RFN_INVPARM                = -506;   { parametro para funcao invalido }
RFN_TXBFULL                = -508;   { buffer de transmissao de mensagens cheio }
RFN_RXBEMPTY               = -509;   { buffer de recepcao    de mensagens vazio }
RFN_RXBFULL                = -510;   { buffer de recepcao    de mensagens cheio }
RFN_RXTIMEOUT              = -511;   { time-out durante recepcao }
RFN_RXCRC1                 = -512;   { erro no CRC }
RFN_TXTMOUT                = -514;   { timeout de transmissao }
RFN_ACKTIMEOUT             = -515;   { timeout de espera de ACK }
RFN_INVCFG                 = -516;   { consulta de configuracao invalida }
RFN_THREADPRI              = -517;   { erro no estabelecimendo da prioridade de thread }
RFN_NOBASE                 = -518;   { Base nao responde a comunicacao inicial }

{-------------------------------------------------------------------------------
 Estrutura de Status de Cada Terminal RF
-------------------------------------------------------------------------------}

type
 PRFNETSTAT = ^RFNETSTAT;
   RFNETSTAT = record
   nTerm:             Longint;          { Numero do terminal }
   dwTxMsgs:          Longint;          { Numero de mensagens de dados transmitidas com sucesso }
   dwTxBytes:         Longint;          { Numero de bytes de dados transmitidos com sucesso }
   dwRetries:         Longint;          { Numero de tentativas de retransmissao da base para coletor }
   dwErrors:          Longint;          { Numero de erros ocorridos de transmissao ocorridos }
   dwRxMsgs:          Longint;          { Numero de mensagens de dados recebidas do terminal }
   dwRxBytes:         Longint;          { Numero de bytes de dados recebidos do terminal }
   dwRepeat:          Longint;          { Estrutura de bits indicando os repetidores no alcance do terminal. }
   dwRfErrors:        Longint;          { Numero de mensagens recebidas com erro pelo radio da base. }
   dwNetIDErrors:     Longint;          { Numero de msgs recebidas com NetID errado pelo radio dabase. }
   dwTxHostMsg:       Longint;          { Numero de mensagens Transmitidas pela base ao Host. }
   dwRxHostMsg:       Longint;          { Numero de mensagens Recebidas pela base vindas do Host. }
   end;

{-------------------------------------------------------------------------------
 Estrutura de Status de Cada Repetidor RF
-------------------------------------------------------------------------------}

type
PRFNETREPSTAT = ^RFNETREPSTAT;
   RFNETREPSTAT = record
   nRep:              Longint;          { Numero do repetidor }
   dwTxPolls:         Longint;          { Numero de mensagens de requisicao de dados transmitidos }
   dwTxMsgs:          Longint;          { Numero de mensagens de dados transmitidas com sucesso }
   dwTxBytes:         Longint;          { Numero de bytes de dados transmitidos com sucesso }
   dwRetries:         Longint;          { Numero de tentativas de retransmissao da base para repetidor }
   dwErrors:          Longint;          { Numero de erros ocorridos de transmissao ocorridos }
   dwRxMsgs:          Longint;          { Numero de mensagens de dados recebidas pela base do repetidor }
   dwRxBytes:         Longint;          { Numero de bytes de dados recebidos pela base do repetidor }
   bStat:             Boolean;          { Estado do repetidor: TRUE = ativo. FALSE = inativo/fora do ar. }
   end;

{-------------------------------------------------------------------------------
 Estrutura de Configuracao da Base RF
-------------------------------------------------------------------------------}

type
PRFNETCONFIG = ^RFNETCONFIG;
   RFNETCONFIG = record
   dwOpen:                 Longint;     { se o canal de comunicacao esta aberto; }
   dwRate:                 Longint;     { valor da taxa de comunicacao, na qual a rede esta operando; }
   dwBufRxMsg:             Longint;     { tamanho do buffer de recepcao de mensagens do Host; }
   dwBufTxMsg:             Longint;     { tamanho do buffer de transmissao de mensagens do Host; }
   dwNetID:                Longint;     { numero de identificacao desta  rede de Radio. }
   dwRFRetries:            Longint;     { numero de tentativas de retransmissao do radio da Base }
   dwRFTimeoutAck:         Longint;     { intervalo de retransmissao do radio da Base, p/ mensagens }
   dwRFTimeoutPong:        Longint;     { intervalo de retransmissao do radio da Base, para Ping. }
   dwRadio0:               Longint;     { Status de funcionamento do Radio 0 da Base. }
   dwRadio1:               Longint;     { status de funcionamento do Radio 1 da base. }
   dwHostMode:             Longint;     { modo de comunicacao com Host setado na Base. }
   dwHostEcho:             Longint;     { se o canal de comunicacao com Host esta em modo ECHO }
   dwHostProt:             Longint;     { se o protocolo de comunicacao e' com correcao de erros. }
   dwHostRate:             Longint;     { taxa de comunicacao com Host setada na Base. }
   dwHostTimeout:          Longint;     { intervalo de tentativas de retransmissao da base para o Host. }
   dwHostRetries:          Longint;     { numero de tentativas de retransmissao da Base para o Host. }
   dwNetRetries:           Longint;     { numero de tentativas de retransmissao da Base para Repetidores }
   dwNetTimeout:           Longint;     { intervalo de retransmissoes de msgs da Base para Repetidores. }
   dwNetRate:              Longint;     { taxa de comunicacao entre Base e Repetidores. }
   dwRepeat:               Longint;     { quais repetidores estao ativos para transmissao de RF (estrut.de bits) }
   dwDebugFlags:           Longint;     { estado dos flags de debug na Base (estrutura de bits) }
   dwSwitches:             Longint;     { estado das dip-switches da Base RF }
   end;

{-------------------------------------------------------------------------------
 Estrutura de Configuracao de cada Radio da Base RF
-------------------------------------------------------------------------------}

type
PRFNETRADIOCONFIG = ^RFNETRADIOCONFIG;
   RFNETRADIOCONFIG = record
   nRadio:                 Longint;       { numero do radio (0 ou 1) }
   nPreamble:              Longint;       { ciclos de preambulo }
   nWakeup:                Longint;       { tempo de Wake Up do radio }
   nSleepTime:             Longint;     { tempo de Sleep do radio }
   nTxRx:                  Longint;       { Delay entre Tx e Rx do radio }
   nPwr:                   Longint;       { tempo de power up do radio }
   nTxBackoff:             Longint;       { tempo maxio de Tx Back-off do radio }
   nTxSlot:                Longint;       { numero de slot do radio }
   nResetState:            Longint;       { estado do switches register do radio apos reset }
   end;

{-------------------------------------------------------------------------------
 Estrutura de Resposta a requisicao de transmissao de mensagem
-------------------------------------------------------------------------------}

type
PRFNETMSGRES = ^RFNETMSGRES;
   RFNETMSGRES = record
   nTerm: Longint;                      { qual terminal }
   cMsg: Char;                          { numero da mensagem anviada }
   end;

{-------------------------------------------------------------------------------
 Estrutura de mensagem de coletor, recebida por RFnetRxMsg
-------------------------------------------------------------------------------}
type
PRFNETMESSAGE = ^RFNETMESSAGE;
   RFNETMESSAGE = record
   nType:      Longint;                 { tipo de msg: RFN_RM, RFN_MT, RFN_ETM, RFN_PR, RFN_ETP, RFN_EV }
   nTerm:      Longint;                   { nro do terminal ou do repetidor }
   nMsg:       Longint;                 { nro da mensagem }
   nStatus:    Longint;                 { estado do repetidor: 1= desativo, 2 = ativo }
   nTimeout:   Longint;                 { tempo de timeout, quando erro de Tx }
   nBytes:     Longint;                 { tamanho da msg recebida }
   sMsg:       array[0..128] of Char;   { mensagem recebida }
   end;

{------------------------------------------------------------------------------
 Declaracoes de Funcoes Publicas de RF
------------------------------------------------------------------------------}
Function RFnetOpen (nChannel:    Longint;
                    wBaud:       Longint;
                    wTxBuffer:   Longint;
                    wRxBuffer:   Longint;
                    nMaxRetries: Longint
                    ): Longint; stdcall;

Function RFnetClose (nChannel: Longint): Longint; stdcall;
Function RFnetTermInfoClear (nChannel: Longint; nTerm: Longint): Longint; stdcall;
Function RFnetTermInfo (nChannel: Longint; nTerm: Longint): Longint; stdcall;
Function RFnetRepInfoClear (nChannel: Longint; nRep: Longint): Longint; stdcall;
Function RFnetRepInfo (nChannel: Longint; nRep: Longint): Longint; stdcall;
Function RFnetGetConfig (nChannel: Longint): Longint; stdcall;
Function RFnetSetConfig (nChannel: Longint; nParm: Longint; lValue: Cardinal): Longint; stdcall;
Function RFnetGetRadioConfig (nChannel: Longint; nRadio: Longint): Longint; stdcall;
Function RFnetSetRadioConfig (nChannel: Longint;nRadio: Longint; nParm: Longint; nValue: Longint): Longint; stdcall;
Function RFnetGetBaseVersion(nChannel: Longint): Longint; stdcall;
Function RFnetTxMsg (nChannel: Longint;nTerm: Longint; pbMsg: PChar; wTamMsg: Longint): Longint; stdcall;
Function RFnetTxPing (nChannel: Longint; nTerm: Longint; pbMsg: PChar; wTamMsg: Longint): Longint; stdcall;
Function RFnetRxMsg (nChannel: Longint; pbDest: PRFNETMESSAGE): Longint; stdcall;
Function RFnetGetResult (nChannel: Longint; pbDest: Pointer): Longint; stdcall;
Function RFnetWaitResult (nChannel: Longint): Longint; stdcall;
Function RFnetTxBufCount (nChannel: Longint): Longint; stdcall;
Function RFnetTxBufBytes (nChannel: Longint): Longint; stdcall;
Function RFnetTxBufFree (nChannel: Longint): Longint; stdcall;
Function RFnetTxBufClear (nChannel: Longint): Longint; stdcall;
Function RFnetRxMsgBytes(nChannel: Longint): Longint; stdcall;
Function RFnetRxBufCount (nChannel: Longint): Longint; stdcall;
Function RFnetRxBufBytes (nChannel: Longint): Longint; stdcall;
Function RFnetRxBufFree (nChannel: Longint): Longint; stdcall;
Function RFnetRxBufClear (nChannel: Longint): Longint; stdcall;

implementation

Procedure XPComVersion;          external 'xpcom32.dll';

Function ComSetAddress;          external 'xpcom32.dll';
Function ComOpen;                external 'xpcom32.dll';
function ComConfig;              external 'xpcom32.dll';
function ComClose;               external 'xpcom32.dll';
function ComGetConfig;           external 'xpcom32.dll';
function ComGetnRx;              external 'xpcom32.dll';
function ComGetnTx;              external 'xpcom32.dll';
function ComGetfRx;              external 'xpcom32.dll';
function ComGetfTx;              external 'xpcom32.dll';
function ComGetErrors;           external 'xpcom32.dll';
function ComClearErrors;         external 'xpcom32.dll';
function ComClearRxBuffer;       external 'xpcom32.dll';
function ComClearTxBuffer;       external 'xpcom32.dll';
function ComClearTxRx;           external 'xpcom32.dll';
function ComRxChar;              external 'xpcom32.dll';
function ComRxData;              external 'xpcom32.dll';
function ComTxChar;              external 'xpcom32.dll';
function ComTxData;              external 'xpcom32.dll';
function ComGetCTS;              external 'xpcom32.dll';
function ComGetDCD;              external 'xpcom32.dll';
function ComGetDSR;              external 'xpcom32.dll';
function ComGetRI;               external 'xpcom32.dll';
function ComSetDTR;              external 'xpcom32.dll';
function ComSetRTS;              external 'xpcom32.dll';
function ComSetBREAK;            external 'xpcom32.dll';

Function XPnetmOpen;             external 'xpcom32.dll';
Function XPnetmClose;            external 'xpcom32.dll';
Function XPnetmComStatus;        external 'xpcom32.dll';
Function XPnetmComError;         external 'xpcom32.dll';
Function XPnetmTxMsg;            external 'xpcom32.dll';
Function XPNetmTxMsgPoll;        external 'xpcom32.dll';
Function XPnetmTxMsgAttention;   external 'xpcom32.dll';
Function XPnetmTxMsgStatus;      external 'xpcom32.dll';
Function XPnetmTxBufCount;       external 'xpcom32.dll';
Function XPnetmTxBufBytes;       external 'xpcom32.dll';
Function XPnetmTxBufFree;        external 'xpcom32.dll';
Function XPnetmTxBufClear;       external 'xpcom32.dll';
Function XPnetmRxMsgBytes;       external 'xpcom32.dll';
Function XPnetmRxMsg;            external 'xpcom32.dll';
Function XPnetmRxBufCount;       external 'xpcom32.dll';
Function XPnetmRxBufBytes;       external 'xpcom32.dll';
Function XPnetmRxBufFree;        external 'xpcom32.dll';
Function XPnetmRxBufClear;       external 'xpcom32.dll';
Function XPnetmPollStart;        external 'xpcom32.dll';
Function XPnetmPollStop;         external 'xpcom32.dll';
Function XPnetmPollTerm;         external 'xpcom32.dll';
Function XPnetmTermInfo;         external 'xpcom32.dll';
Function XPnetmTermInfoClear;    external 'xpcom32.dll';
Function XPnetmGetConfig;        external 'xpcom32.dll';
Function XPnetmSetTimeout;       external 'xpcom32.dll';

Function XPnetmWaitCom;          external 'xpcom32.dll';
Function XPnetmRemote;           external 'xpcom32.dll';
Function XPnetmTxClock;          external 'xpcom32.dll';
Function XPnetmTxCmd;            external 'xpcom32.dll';
Function XPnetmTxProg;           external 'xpcom32.dll';
Function XPnetmTxProgStart;      external 'xpcom32.dll';
Function XPnetmTxProgAbort;      external 'xpcom32.dll';
Function XPnetmRxProg;           external 'xpcom32.dll';
Function XPnetmRxProgStart;      external 'xpcom32.dll';
Function XPnetmRxProgAbort;      external 'xpcom32.dll';
Function XPnetmTxFile;           external 'xpcom32.dll';
Function XPnetmTxFileStart;      external 'xpcom32.dll';
Function XPnetmTxFileAbort;      external 'xpcom32.dll';
Function XPnetmRxFile;           external 'xpcom32.dll';
Function XPnetmRxFileStart;      external 'xpcom32.dll';
Function XPnetmRxFileAbort;      external 'xpcom32.dll';
Function XPnetmTransferStatus;   external 'xpcom32.dll';

Procedure FXPBasicConvToDouble;   external 'xpcom32.dll';
Procedure FXPBasicConvFromDouble; external 'xpcom32.dll';

Function FXPBasicConvToDBF;      external 'xpcom32.dll';
Function FXPBasicConvFromDBF;    external 'xpcom32.dll';
Function FXPBasicConvToAsc;      external 'xpcom32.dll';
Function FXPBasicConvFromAsc;    external 'xpcom32.dll';
Function FXPBasicConvToText;     external 'xpcom32.dll';
Function FXPBasicConvFromText;   external 'xpcom32.dll';

Function XModemTxConfig;         external 'xpcom32.dll';
Function XModemTxFileStart;      external 'xpcom32.dll';
Function XModemTxAbort;          external 'xpcom32.dll';
Function XModemTxStatus;         external 'xpcom32.dll';
Function XModemRxConfig;         external 'xpcom32.dll';
Function XModemRxFileStart;      external 'xpcom32.dll';
Function XModemRxAbort;          external 'xpcom32.dll';
Function XModemRxStatus;         external 'xpcom32.dll';

Function RFnetOpen;              external 'xpcom32.dll';
Function RFnetClose;             external 'xpcom32.dll';
Function RFnetTermInfoClear;     external 'xpcom32.dll';
Function RFnetTermInfo;          external 'xpcom32.dll';
Function RFnetRepInfoClear;      external 'xpcom32.dll';
Function RFnetRepInfo;           external 'xpcom32.dll';
Function RFnetGetConfig;         external 'xpcom32.dll';
Function RFnetSetConfig;         external 'xpcom32.dll';
Function RFnetGetRadioConfig;    external 'xpcom32.dll';
Function RFnetSetRadioConfig;    external 'xpcom32.dll';
Function RFnetGetBaseVersion;    external 'xpcom32.dll';
Function RFnetTxMsg;             external 'xpcom32.dll';
Function RFnetTxPing;            external 'xpcom32.dll';
Function RFnetRxMsg;             external 'xpcom32.dll';
Function RFnetGetResult;         external 'xpcom32.dll';
Function RFnetWaitResult;        external 'xpcom32.dll';
Function RFnetTxBufCount;        external 'xpcom32.dll';
Function RFnetTxBufBytes;        external 'xpcom32.dll';
Function RFnetTxBufFree;         external 'xpcom32.dll';
Function RFnetTxBufClear;        external 'xpcom32.dll';
Function RFnetRxMsgBytes;        external 'xpcom32.dll';
Function RFnetRxBufCount;        external 'xpcom32.dll';
Function RFnetRxBufBytes;        external 'xpcom32.dll';
Function RFnetRxBufFree;         external 'xpcom32.dll';
Function RFnetRxBufClear;        external 'xpcom32.dll';

end.


