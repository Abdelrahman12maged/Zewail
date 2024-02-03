import 'dart:io';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup('https://www.google.com/');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}
