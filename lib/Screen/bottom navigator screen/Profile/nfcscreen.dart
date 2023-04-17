import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

class web extends StatelessWidget {
  const web({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:

     Browser(
      initialUriString: 'https://www.instagram.com/',
    ),

      ));
  }
}
