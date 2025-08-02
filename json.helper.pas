unit json.helper;

{$mode delphi}

interface

uses
  fpjson,
  StrUtils,
  SysUtils,
  DateUtils;

type

  { TJSONObjectHelper }

  TJSONObjectHelper = class helper for TJSONObject
      private
      public
            function GetString  (const AName: string; const ADefault: string = ''): string;
            function GetFloat   (const AName: string; const ADefault: Double = 0): Double;
            function GetInt64   (const AName: string; const ADefault: Int64 = 0): Int64;
            function GetInteger (const AName: string; const ADefault: Integer = 0): Integer;
            function GetDate    (const AName: string; const ADefault: String = ''): TDate;
            function GetDateTime(const AName: string; const ADefault: String = ''): TDateTime;
            function HasValue   (const AName: string): Boolean;
  end;


implementation

function TJSONObjectHelper.GetString(const AName: string; const ADefault: string): string;
var
  Val: TJSONData;
begin
  Val := Self.Find(AName);
  if Assigned(Val) and (Val.JSONType <> jtNull) then
    Result := Val.AsString
  else
    Result := ADefault;
end;

function TJSONObjectHelper.GetFloat(const AName: string; const ADefault: Double): Double;
var
  Val: TJSONData;
begin
  Val := Self.Find(AName);
  if Assigned(Val) and (Val.JSONType <> jtNull) then
    Result := Val.AsFloat
  else
    Result := ADefault;
end;

function TJSONObjectHelper.GetInt64(const AName: string; const ADefault: Int64 ): Int64;
var
  Val: TJSONData;
begin
  Val := Self.Find(AName);
  if Assigned(Val) and (Val.JSONType <> jtNull) then
    Result := Val.AsInt64
  else
    Result := ADefault;

end;

function TJSONObjectHelper.GetInteger(const AName: string; const ADefault: Integer): Integer;
var
  Val: TJSONData;
begin
  Val := Self.Find(AName);
  if Assigned(Val) and (Val.JSONType <> jtNull) then
    Result := Val.AsInteger
  else
    Result := ADefault;
end;

function TJSONObjectHelper.GetDate(const AName: string; const ADefault: String): TDate;
var
  Val   : TJSONData;
begin
  Val := Self.Find(AName);
  if Assigned(Val) and (Val.JSONType <> jtNull) then
    begin
        if TryISOStrToDate( Val.AsString, Result ) = false then
          Result := EncodeDate(1900,01,01);
    end
  else
    TryISOStrToDate( ADefault, Result )
end;

function TJSONObjectHelper.GetDateTime(const AName: string; const ADefault: String): TDateTime;
var
  Val   : TJSONData;
begin
  Val := Self.Find(AName);
  if Assigned(Val) and (Val.JSONType <> jtNull) then
    begin
        if TryISOStrToDateTime( StringReplace(Val.AsString,' ','T',[rfReplaceAll]) , Result ) = false then
          Result := EncodeDateTime(1900,01,01,0,0,0,0);
    end
  else
    TryISOStrToDateTime( StringReplace(ADefault,' ','T',[rfReplaceAll]) , Result );

end;

function TJSONObjectHelper.HasValue(const AName: string): Boolean;
var
  Val: TJSONData;
begin
  Val := Self.Find(AName);
  Result := Assigned(Val) and (Val.JSONType <> jtNull);
end;

end.
