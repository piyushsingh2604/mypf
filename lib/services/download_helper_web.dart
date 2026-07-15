// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

void downloadResumeFile() {
  final html.AnchorElement anchor = html.AnchorElement(
    href: 'assets/assets/Piyush_Singh_Resume_Updated.pdf',
  );
  anchor.download = 'Piyush_Singh_Resume_Updated.pdf';
  anchor.click();
}
