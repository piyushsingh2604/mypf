import 'package:url_launcher/url_launcher.dart';

void downloadResumeFile() async {
  final Uri url = Uri.parse('assets/assets/Piyush_Singh_Resume_Updated.pdf');
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
