unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TfMain = class(TForm)
    mmPlaintext: TMemo;
    mmKey: TMemo;
    mmCiphertext: TMemo;
    btnLoadFile: TButton;
    btnEncryption: TButton;
    btnSaveFile: TButton;
    OpenDialog1: TOpenDialog;
    btnDecryption: TButton;
    edKey: TEdit;
    lbEnterKey: TLabel;
    SaveDialog1: TSaveDialog;
    procedure btnLoadFileClick(Sender: TObject);
    procedure btnSaveFileClick(Sender: TObject);
    procedure btnEncryptionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}


const
  RegCount=30;
  Bit30=1;
  Bit16=15;
  Bit15=16;
  Bit1=30;
  blocksize:integer=512;


type
  TRegister=array[1..RegCount] of byte;


function GenerateBit(var AReg: TRegister):byte;
var
  LastBit: byte;
  i: integer;
begin
  LastBit:= AReg[Bit30] xor AReg[Bit15] xor AReg[Bit16] xor AReg[Bit1];
  result:=AReg[1];
  for i:=1 to RegCount-1 do
    AReg[i]:=AReg[i+1];
  AReg[RegCount]:=LastBit;
end;



procedure LFSRCipher(const key:string);
var
  keylen, i, linecount: integer;
  LFSRReg: TRegister;
  str, resstr:string;
  CurrBit: byte;
begin
  keylen:=fMain.mmPlaintext.Lines.Count*8;
  for i:=1 to RegCount do
    LFSRReg[i]:=StrToInt(key[i]);
  i:=1;
  str:='';
  resstr:='';
  linecount:=0;
  while i<=keylen do
  begin
    CurrBit:= GenerateBit(LFSRReg);
    str:=str+IntToStr(CurrBit);
    resstr:=resstr+IntToStr(StrToInt(fMain.mmPlaintext.Lines[linecount][length(resstr)+1]) xor CurrBit);
    if (length(str)=8) or (i=keylen) then
    begin
      fMain.mmKey.Lines.Add(str);
      fMain.mmCiphertext.Lines.Add(resstr);
      str:='';
      resstr:='';
      inc(linecount);
    end;
    inc(i);
  end;
end;



function MakeBin(num:byte):string;
var
  str:string;
  i: integer;
begin
  str:='';
  for i:=0 to 7 do
  begin
    str:=IntToStr(num mod 2)+str;
    num:=num div 2;
  end;
  result:=str;
end;


procedure TfMain.btnLoadFileClick(Sender: TObject);
  {hexdig:array [1..16] of string[4]=('0000', '0001', '0010', '0011',
                                    '0100', '0101', '0110', '0111',
                                    '1000', '1001', '1010', '1011',
                                    '1100', '1101', '1110', '1111');
  hex: string ='0123456789ABCDEF'; }
var
  fInput: file;
  buffer: array of byte;
  size, i:integer;
begin
  if OpenDialog1.Execute then   //представить файл без типа в виде 0 и 1
  begin
    mmPlainText.Clear;
    AssignFile(fInput, OpenDialog1.FileName);
    Reset(fInput, 1);
    size:=FileSize(fInput);
    SetLength(buffer, FileSize(fInput));
    while size>0 do
    begin
      if size>blocksize then
      begin
        BlockRead(fInput, Pointer(buffer)^, blocksize);
        for i:=0 to blocksize-1 do
        begin
          //str:=hexdig[pos(IntToHex(buffer[i], 1)[1], hex)]+hexdig[pos(IntToHex(buffer[i], 1)[2], hex)];
          //mmPlainText.Text:=mmPlainText.Text+str;
          mmPlainText.Lines.Add(MakeBin(buffer[i]));
        end;
      end
      else
      begin
        BlockRead(fInput, Pointer(buffer)^, size);
        for i:=0 to size-1 do
        begin
          //str:=hexdig[pos(IntToHex(buffer[i], 1)[1], hex)]+hexdig[pos(IntToHex(buffer[i], 1)[2], hex)];
          //mmPlainText.Text:=mmPlainText.Text+str;
          mmPlainText.Lines.Add(MakeBin(buffer[i]));
        end;
      end;
      size:=size-blocksize;
    end;
    CloseFile(fInput);
    SetLength(buffer, 0);
  end;
  btnEncryption.Enabled:=true;
  btnSaveFile.Enabled:=true;
end;

procedure TfMain.btnSaveFileClick(Sender: TObject);
var
  fResult: file;
  buffer: array of byte;
  size, i, j, number: integer;
  elem: byte;
begin
  if length(mmCiphertext.Text)=0 then
    ShowMessage('Cipher file is empty(((')
  else
  begin
    if SaveDialog1.Execute then
      begin
        AssignFile(fResult, SaveDialog1.FileName);
        Rewrite(fResult, 1);
        size:=mmCipherText.Lines.Count;
        SetLength(buffer, blocksize);
        number:=0;
        while size>0 do
        begin
          if size>blocksize then
          begin
            for i:=0 to blocksize-1 do
            begin
              elem:=0;
              for j:=1 to 8 do
                elem:=elem+StrToInt(mmCipherText.Lines[number][j])*round(power(2, 8-j));
              buffer[i]:=elem;
              inc(number);
            end;
            BlockWrite(fResult, Pointer(buffer)^, blocksize);
          end
          else
          begin
            for i:=0 to size-1 do
            begin
              elem:=0;
              for j:=1 to 8 do
                elem:=elem+StrToInt(mmCipherText.Lines[number][j])*round(power(2, 8-j));
              buffer[i]:=elem;
              inc(number);
            end;
            BlockWrite(fResult, Pointer(buffer)^, size);
          end;
          size:=size-blocksize;
        end;
        SetLength(buffer, 0);
        CloseFile(fResult);
      end;
  end;
end;



procedure TfMain.btnEncryptionClick(Sender: TObject);
var
  i:integer;
  key:string;
begin
  mmKey.Clear;
  mmCipherText.Clear;
  if length(mmPlainText.Text)>0 then
  begin
    key:='';
    for i:=1 to length(edKey.Text) do
    begin
      if edKey.Text[i] in ['1', '0'] then
        key:=key+edKey.Text[i];
    end;

    if length(key)<30 then
      ShowMessage('Please, enter 30 symbols ("0" or "1")')
    else
    begin
      if length(key)>30 then
        delete(key, 31, length(key)-30);
      LFSRCipher(key);
    end;
  end
  else
    ShowMessage('Source file is empty');
end;

end.
