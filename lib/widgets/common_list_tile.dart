import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonListTile extends StatelessWidget {
  final String? title;
  final String? details;
  const CommonListTile({Key? key, this.title, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.3),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          title ?? '',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Html(
          data: details ?? '',
          onLinkTap: (url, _, __, ___) async {
            if (url != null) {
              if (await canLaunch(url)) {
                await launch(url);
              }
            }
          },
          onImageTap: (src, _, __, ___) async {
            if (src != null) {
              if (await canLaunch(src)) {
                await launch(src);
              }
            }
          },
        ),
      ),
    );
  }
}
