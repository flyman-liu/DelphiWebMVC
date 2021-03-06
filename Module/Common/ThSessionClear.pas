unit ThSessionClear;

interface

uses
  System.Classes, System.SysUtils, uConfig, Winapi.Windows, command, superobject;

type
  TThSessionClear = class(TThread)
  private
    procedure clearMap;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    isstop: boolean;
  end;

implementation

{ TThSession }
procedure TThSessionClear.clearMap();
var
  i: integer;
  k: integer;
  s: string;
begin
  try
    if SessionListMap <> nil then
    begin
      k := SessionListMap.SessionLs_timerout.Count;
      for i := 0 to k - 1 do
      begin
        s := SessionListMap.SessionLs_timerout.ValueFromIndex[i];
        if Now() >= StrToDateTime(s) then
        begin
          log('����Session' + SessionListMap.SessionLs_timerout.KeyNames[i]);
          SessionListMap.deleteSession(i);
          break;
        end;
      end;

    end;
  except
    Exit;
  end;
end;

procedure TThSessionClear.Execute;
begin
  FreeOnTerminate := true;
  while not Terminated do
  begin
    try
      Synchronize(clearMap);
    finally
      Sleep(5000);
    end;

  end;
end;

end.

