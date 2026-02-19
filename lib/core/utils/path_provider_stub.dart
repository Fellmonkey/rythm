// TODO: заменить на универсальную реализацию, которая будет работать и на мобильных платформах.
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

/// Скачивает файл в браузере (веб).
Future<void> downloadFileWeb(
  String content,
  String filename,
  String mimeType,
) async {
  final blob = html.Blob([content], mimeType);
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', filename)
    ..click();
  html.Url.revokeObjectUrl(url);
}
