import 'package:url_launcher/url_launcher.dart';

void launchUserPage(String username) async {
  final userUrl = Uri.parse("https://unsplash.com/@${username}?utm_source=pxSera&utm_medium=referral");
  try {
    if (await canLaunchUrl(userUrl)) {
      await launchUrl(
        userUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  } catch (e) {
    print(e);
  }
}

void launchUnsplashHome() async {
  final unsplashUrl = Uri.parse("https://unsplash.com/?utm_source=your_app_name&utm_medium=referral");
  try {
    if (await canLaunchUrl(unsplashUrl)) {
      await launchUrl(
        unsplashUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  } catch (e) {
    print(e);
  }
}
