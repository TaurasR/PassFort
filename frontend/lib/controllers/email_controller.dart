import 'dart:io';
import 'package:passfort/assets/constants.dart' as constants;
import 'package:path_provider/path_provider.dart';

class EmailController {
  EmailController();

  Future<void> createUserIDFile() async {
    final directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/${constants.userIDFilename}');
    file.writeAsString('1');
  }
}
