import 'dart:io';

CheckInternet() async {
  try {
    print('1');
    var result = await InternetAddress.lookup("google.com");
    print('2');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('3');
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}
