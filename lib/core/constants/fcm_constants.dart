List<String> scopes = [
  "https://www.googleapis.com/auth/userinfo.email",
  "https://www.googleapis.com/auth/firebase.database",
  "https://www.googleapis.com/auth/firebase.messaging"
];

final servicesAccountJson = {
  "type": "service_account",
  "project_id": "chatty-dev990",
  "private_key_id": "fbe1625ec259e5de821f69a28177b5d88e7ad623",
  "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCNhspg/AOyJThB\njCky869ImXaaK9W0vKfGMMwA3DhYYuF3r5uy6b8HLpvv6g5nBa+cNl/MSpDkFnh3\nWx6Z7pMj0Tg8LJTEBzKcuUaaFnRs19RkV/1qlaSSbPw7RDnnf1/h3vWJt1CFHHTS\nBhWWgwPjPM9TxWWeVVq2UsI39a1YAgJCWCFqiE0g7+XWQqijnGh2cHzSfQCTeL4F\nBWbMBhUg88hTo5I9kHRdGaxhso5aPk/vk2okvtSpLHJK2O990uzGmipHs71863as\nC7y8swbLTUbpZNSkG67DhmARS3IRsPHXMUwKCz+krlAwql4x6S4rJ6wjBSeESamw\nTOznxUrvAgMBAAECggEABZyHELJdWSZlpR+wEH+d/xRqofFD/28Nfeu4Yv5YU5TU\nGMFDPKRM+TVtZGVU3dvZWynCwaBhP1Huw9i+jV7qwZxNjQE9gspARPuJo5lpU1l5\nZ+MfPqchR9b/Z0AsxZOE0zlaZfP5QtXegedQ2s9mC5ABLnKgtVbwClOctMhOb7NR\nl28f1gJgAhiOuvLw0X3i2nxhtMdvZqWWY5iCYNma6itM8r5+zFhGdcAopn3yZhXK\njoD8Q/iLvHB9HJBVskg8i7f3nB4t4VcuK3l5qRRtASN/J36nxJkyJeK0hzW52Eoy\ntBChoeNWw+dGOLSnfdCu/Xhr/eKz5bixaqx0BmvBfQKBgQDC1NoZGHaslbpqUEqT\np2JbsgG+jNpGqJYyUL1UNtaz2zPCof+5Db7D56R5571YfFcq5Z4fAm5lplOdpvmi\nab0b1APwyZgZfoabP6snSfLIDoMttBVtMrkgWOzempQMXxxbnnkLmGRF9+H7nB0V\nZU1wu5xnlzRBeYU9TnJHryBeXQKBgQC59aw2BRrvdbm2F4NcUbh21b+oPMFMaAEh\n1AO0EXe3M+WlCwBzlLHWe/9hAvAlwYLKLQbNoD1AXTcoLbRrglV53J2t+3GyU4IE\nfYFT7ZhJng01uut7Beet+8fql1mm0RFPzeSQyKWUuBMagXOZ1WiUMMvmSHWkiOlB\ncP1N5aoBuwKBgGSf+mSrtd89FaKDBYFtGeex8CSyKqoDuE8UVDSCfjE2LW2Arcqt\nxrD3moM7pRdmYL7PCPOLFel6FgV+j7/KTNlqjv51oBDKwEq+f28zSij5FdctA0P6\nxpJmWzA9NemN1d+b4XiTpHZeqGCDKKI8R9rJiuYVue93C9G2Cl/rmxQhAoGACsJ8\nRGPnOxPEuxSBNUZFNhsIC+P4C0O5TQvHaxPXqXIHR5VrYUSpRY/HJwXUf1rDBo+0\nZRFwedjq6Bg86DuSVoq9VOPHoFnUnA3m/cQxm5DZktJN7cBZt2dqGdjIBy7xoXx4\nTShO7Fv6Pv5egfgnJOvt4FUw+WQymua+wVMYkyECgYADOdIgfc6umor7G0fcAAAu\n8XokX91Lmm+LWavmNvSL4MrPSZFqwYphukZzdD/9ubfMOECAlGFCBZ1N4OioDdoT\nZcFaXkC8Vg1LxOyREGWWVZ+p094nFowGTU8+bnEOFycIwyyhnf+BH9SK1QnwTtRt\nJA7pLAFjkTIqdssXU52+eQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "chatty-dev-eslammongy@chatty-dev990.iam.gserviceaccount.com",
  "client_id": "101384942834602942988",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/chatty-dev-eslammongy%40chatty-dev990.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};

const String fcmEndPoint =
    "https://fcm.googleapis.com/v1/projects/chatty-dev990/messages:send";
