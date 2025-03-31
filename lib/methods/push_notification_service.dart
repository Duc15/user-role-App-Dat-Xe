import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:provider/provider.dart';
import '../appInfo/app_info.dart';
import '../global/global_var.dart';

///Updated in June 2024
///This PushNotificationService only you have to update with below code for new FCM Cloud Messaging V1 API
class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "app-dat-xe-38f38",
      "private_key_id": "15a82ca5a1e60daf7cafdab91c083222a61e94dd",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCZt43pNafZXMWp\nLD1yQIE8NlFclInfvPA9aLKs3Z/qDaznuZoMaahXiLuma2MJ0+15yhUJ6ClMiFuG\n7MCGjsiYV/nEJm6PLYUDdCX1i98xLiur0xzz2ZIEFOAHavQVT9dAj1WvDgBmMgzv\nWZyK8ShftG3Jzrjk881p50rlmTMjT01NkH78cFx06PwLgTviSmsZ88Nofcf071M5\n94aEeOV7wv1tXEUQXnt7H+T5cIFP+8Hz1PutdXZi9yUv2vOlWKP17M7KpL5pzl0H\no4+g6Ng9uU0woETnRYDyH1za+C4Z76u7ckFhprBruLQhDaBNnpPj6ZLFPYVNp0Dk\nRfElk4MvAgMBAAECggEALs9wZkviJPW09bsUrTXKhUEPTs+nGtzJFhJLkwvclmR6\nuohRSqVkT9/CMUAzhTsl7rgk5wLtjLJbmP+A85kIqifkViDT+0MD5hTZOGjTW4Ex\naF5eSz3+0sJepLOjx9er96uOjsQHSBfGy56w5rjgsCBcbJ/Iu2QpMi5upvOb2Izl\nCaGaRNnThyAOwtwClMnB2IJXZzjDnUxHiiRs8nzixCaTkIH3uWySyU5x6kzUTy9I\npSJfSEsdlxTZQUWFyrgAeG07i3kPQSCj/z+iEG8DOEGseqOPJ/JqwtTaNXkEcDth\nwfugBn96YpWHWPsaRVfEcRh7sE3Bipln1+co7H3WuQKBgQDXCHjPN3xOMsTPasJC\nggVVwt6JPAEadyojpneElrBIsctXhY4OFgJsaoZAVEtGGJ2IS37ZBMeKLU4whKGL\n1UzEehWlxcQ3DGnQ0PFz27FcbmCQlGzXl8yAAcg40OZB6uOT3S3mc7+zhKYoSAOc\nmRiA5HNRK894WXOrHfI3ura6pwKBgQC3AJfZ9xgIAxnENxCtmF83mS3ru/occ+Ni\nH3v9z/mpHzM6WQzxiFc4Y6+OQIGMNRiw2xzp/7AfwoRSvGpl/plhgHMDBAKH6fsZ\ngd/neQjfsuJiDvwwZMpnHHVSovfQWG4mvkBuEOUffze4dfzYFJLg6maKCZ/L9CGy\nvBWd7t7sOQKBgCo8zsYdJvyROllnpfq8YWHkIiQgtjLFn3BbPXS8yKmuyrtJT4ry\nxc0X64DtTc/Z+++OrL7iEnPQzF/5XWYDIs4hEOl7/Du3430R3audRqxaPfuIPAzp\nE1E9iF+ooOHnyoX71w1CRTB06NJWuubip46B0Sjrixgfsfm1qyNJOKVXAoGAJwo0\nWuZwtPzcWVSZ9T6lSXofJsQSRlGet4cZ73qXuzGRvyfSMBCy8q+pewJd4KhPHSOR\nVoYab5wSmIfjduDKnddGMeWAGLicvcNMHdhfQUGrM9oYiMZnu3mBueBUV5kV3qQF\noLVv+7krDOn2x64T63F18Iq/EUaCjdu8DNYxrlkCgYBsf9VVvFXXgoSht0EvVpVX\nfkiFUXGRmCBK1JrfJRwe5sY6eYzadwSFcpoIodncV04+yoyk/1FFeIB2o8cOT8EY\nQFk+k3eqELh2fFjPOW6qJOSupPIb/GsoFd7c7Aap1ayydey3flan8TQ2ORTyhCp+\n3xaBFSNBCTyIwZ0rafNROg==\n-----END PRIVATE KEY-----\n",
      "client_email": "fit-hau@app-dat-xe-38f38.iam.gserviceaccount.com",
      "client_id": "106476611237389603893",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/fit-hau%40app-dat-xe-38f38.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    //get the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver(
      String deviceToken, BuildContext context, String tripID) async {
    String dropOffDestinationAddress =
        Provider.of<AppInfo>(context, listen: false)
            .dropOffLocation!
            .placeName
            .toString();
    String pickUpAddress = Provider.of<AppInfo>(context, listen: false)
        .pickUpLocation!
        .placeName
        .toString();

    final String serverAccessTokenKey =
        await getAccessToken(); // Your FCM server access token key
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/app-dat-xe-38f38/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token':
            deviceToken, // Token of the device you want to send the message/notification to
        'notification': {
          "title": "Có 1 chuyến xe đưuọc yêu cầu từ $userName",
          "body":
              "Đón khách tại địa : $pickUpAddress \n Trả khách tại: $dropOffDestinationAddress",
        },
        'data': {
          "tripID": tripID,
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessTokenKey',
      },
      body: jsonEncode(message),
    );
  }
}
