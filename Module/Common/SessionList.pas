unit SessionList;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles;

type
  TSessionList = class
    SessionLs_vlue: THashedStringList;
    SessionLs_timerout: THashedStringList;
  public
    function getValueByKey(sessionid: string): string;
    function getTimeroutByKey(sessionid: string): string;
    function setValueByKey(sessionid: string; value: string): boolean;
    function setTimeroutByKey(sessionid: string; timerout: string): boolean;
    function deleteSession(k: Integer): boolean;
    constructor Create();
    destructor Destroy; override;
  end;

implementation

{ TSessionList2 }

constructor TSessionList.Create();
begin

  SessionLs_vlue := THashedStringList.Create;
  SessionLs_timerout := THashedStringList.Create;
end;

function TSessionList.deleteSession(k: Integer): boolean;
begin
  SessionLs_vlue.Delete(k);
  SessionLs_timerout.Delete(k);
end;

destructor TSessionList.Destroy;
begin
  SessionLs_vlue.Clear;
  SessionLs_timerout.Clear;
  SessionLs_vlue.Free;
  SessionLs_timerout.Free;
  inherited;
end;

function TSessionList.getTimeroutByKey(sessionid: string): string;
begin
  Result := SessionLs_timerout.Values[sessionid];
end;

function TSessionList.getValueByKey(sessionid: string): string;
begin
  Result := SessionLs_vlue.Values[sessionid];
end;

function TSessionList.setTimeroutByKey(sessionid, timerout: string): boolean;
begin
  SessionLs_timerout.Values[sessionid] := timerout;
end;

function TSessionList.setValueByKey(sessionid, value: string): boolean;
begin
  SessionLs_vlue.Values[sessionid] := value;
end;

end.

