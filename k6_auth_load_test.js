import grpc from 'k6/net/grpc';
import { check, sleep } from 'k6';
import exec from 'k6/execution';

const client = new grpc.Client();
client.load(['backend'], ['protobuf/auth/v1/authentication.proto']);

export const options = {
  scenarios: {
    small_test: {
      executor: 'constant-arrival-rate',
      rate: 2,             
      timeUnit: '1s',    
      duration: '30s',    
      preAllocatedVUs: 2, 
      maxVUs: 10, 
    },
  },
  thresholds: {
    'grpc_req_duration{method:auth.v1.AuthenticationService/SignIn}': ['p(95)<400'],
    'checks': ['rate>0.99'],
  },
};

const TARGET = __ENV.GRPC_TARGET || 'localhost:50051';

export default () => {
  client.connect(TARGET, { plaintext: true, timeout: '5s' });

  const email = `load${__VU}_${exec.scenario.iterationInTest}@example.com`;
  const password = 'k6IsGreat#2024';

  let res = client.invoke('auth.v1.AuthenticationService/SignUp', { email, password }, { timeout: '3s' });
  check(res, {
    'signup ok or already': (r) => r.status === grpc.StatusOK || r.status === grpc.StatusAlreadyExists,
  });

  res = client.invoke('auth.v1.AuthenticationService/SignIn', { email, password }, { timeout: '3s' });
  check(res, {
    'signin ok': (r) => r.status === grpc.StatusOK,
    'has access token': (r) => r.message?.tokens?.accessToken,
  }); 

  const accessToken = res.message.tokens.accessToken;
  const refreshToken = res.message.tokens.refreshToken;

  const v = client.invoke('auth.v1.AuthenticationService/ValidateToken', {
    access_token: accessToken,
  }, {
    metadata: { Authorization: `Bearer ${accessToken}` },
    timeout: '3s',
  });

  check(v, {
    'validate ok': (r) => r.status === grpc.StatusOK,
  });

  const rv = client.invoke('auth.v1.AuthenticationService/RevokeToken', {
    refresh_token: refreshToken,
  }, {
    metadata: { Authorization: `Bearer ${accessToken}` },
    timeout: '3s',
  });

  check(rv, {
    'revoke token ok': (r) => r.status === grpc.StatusOK,
  });

  const rpr = client.invoke('auth.v1.AuthenticationService/RequestPasswordReset', {
    email: email,
  });

  check(rpr, {
    'request password reset ok': (r) => r.status === grpc.StatusOK,
  });

  const new_password = "123456789"

  const rsp = client.invoke('auth.v1.AuthenticationService/ResetPassword', {
    reset_token: "abcABC",
    new_password: new_password
  });

  check(rsp, {
    'reset password ok': (r) => r.status === grpc.StatusOK,
  });

  const si2 = client.invoke('auth.v1.AuthenticationService/SignIn', { email, password: new_password }, { timeout: '3s' });
  check(si2, {
    'signin after reset passwork ok': (r) => r.status === grpc.StatusOK,
    'after has access token': (r) => r.message?.tokens?.accessToken,
  });

  const new_accessToken = si2.message.tokens.accessToken;
  const refresh_token = si2.message.tokens.refreshToken;
  const rv1 = client.invoke('auth.v1.AuthenticationService/RevokeToken', {
    refresh_token: refreshToken,
  }, {
    metadata: { Authorization: `Bearer ${new_accessToken}` },
    timeout: '3s',
  });

  check(rv1, {
    'after revoke token ok': (r) => r.status === grpc.StatusOK,
  });

  const rpr1 = client.invoke('auth.v1.AuthenticationService/RequestPasswordReset', {
    email: email,
  });

  check(rpr1, {
    'after request password reset ok': (r) => r.status === grpc.StatusOK,
  });

  const rsp1 = client.invoke('auth.v1.AuthenticationService/ResetPassword', {
    reset_token: "abcABC",
    new_password: password
  });

  check(rsp1, {
    'after reset password ok': (r) => r.status === grpc.StatusOK,
  });


  const rf = client.invoke('auth.v1.AuthenticationService/RefreshToken', {
    refresh_token: refresh_token,
  }, {
    metadata: { Authorization: `Bearer ${new_accessToken}` },
    timeout: '3s',
  });

  check(rf, {
    'refresh token reset ok': (r) => r.status === grpc.StatusOK,
    'refresh has access token': (r) => r.message?.tokens?.accessToken,
  });

  client.close();
  sleep(0.1);
};
