enum LoginResult{
  NO_USER,
  SUCCESS,
  PASSWORD_WRONG,
}
Map<int,LoginResult> loginResultMap= {
  0:LoginResult.NO_USER,
  1:LoginResult.SUCCESS,
  2:LoginResult.PASSWORD_WRONG,
};