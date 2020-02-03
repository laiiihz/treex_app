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
enum SignupResult{
  SUCCESS,
  PASSWORD_NULL,
  FAIL,
  HAVE_USER,
}

Map<int,SignupResult> signupResultMap={
  0:SignupResult.SUCCESS,
  1:SignupResult.PASSWORD_NULL,
  2:SignupResult.FAIL,
  3:SignupResult.HAVE_USER,
};
