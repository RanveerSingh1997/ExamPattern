import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';



Future<File> pickFile() async {
  FilePickerResult result = await FilePicker.platform.pickFiles();
  if (result != null) {
     return File(result.files.single.path);
  }
}

Future<File> downloadFile(String url, String filename) async {
  http.Client client = new http.Client();
  var req = await client.get(Uri.parse(url));
  var bytes = req.bodyBytes;
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}

Future<File> pdfFilePicker() async {
  var result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf']);
  if (result != null) {
    var file = File(result.files.single.path);

    return file;
  }
}
