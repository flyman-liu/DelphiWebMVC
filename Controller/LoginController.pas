unit LoginController;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, Data.DB, superobject,
  BaseController;

type
  TLoginController = class(TBaseController)
  public
    procedure index();
    procedure check();
    procedure checknum();
  end;

implementation

uses
  uTableMap, UsersService, UsersInterface;

var
  users_service: IUsersInterface;

procedure TLoginController.check();
var
  json: string;
  sdata, ret, wh: ISuperObject;
  username, pwd: string;
  sql: string;
begin
  ret := SO();

  with View do
  begin
    users_service := TUsersService.Create(Db);
    try
      username := Input('username');
      pwd := Input('pwd');
      Sessionset('username', username);
      wh := SO();
      wh.S['username'] := username;
      wh.S['pwd'] := pwd;
      sdata := users_service.checkuser(wh);
      if (sdata <> nil) then
      begin
        json := sdata.AsString;
        Sessionset('username', username);
        Sessionset('name', sdata.S['name']);
        SessionSet('user', sdata.AsString);
        json := Sessionget('user');
        ret.I['code'] := 0;
        ret.S['message'] := '��¼�ɹ�';
      end
      else
      begin
        ret.I['code'] := -1;
        ret.S['message'] := '��¼ʧ��';
      end;
      ShowJson(ret);
    except
      on e: Exception do
        ShowText(e.ToString);
    end;

  end;
end;

procedure TLoginController.checknum;
var
  num: string;
begin
  Randomize;
  num := inttostr(Random(9)) + inttostr(Random(9)) + inttostr(Random(9)) + inttostr(Random(9));
  View.ShowCheckIMG(num, 60, 30);
end;

procedure TLoginController.index();
var
  ret: boolean;
begin
  with View do
  begin
    ShowHTML('Login');
  end;
end;

end.

