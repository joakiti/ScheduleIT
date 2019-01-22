import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timeline/colors.dart';
import 'package:timeline/main_menu/menu_data.dart';
import 'package:url_launcher/url_launcher.dart';

/// This widget is visible when opening the about page from the [MainMenuWidget].
///
/// It displays all the information about the development of the application,
/// the inspiration sources and tools and SDK used throughout the development process.
///
/// This page uses the package `url_launcher` available at https://pub.dartlang.org/packages/url_launcher
/// to open up urls in a WebView on both iOS & Android.
class AboutPage extends StatelessWidget {
  /// Sanity check before opening up the url.
  _launchUrl(String url) {
    canLaunch(url).then((bool success) {
      if (success) {
        launch(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: lightGrey,
          iconTheme: IconThemeData(color: Colors.black.withOpacity(0.54)),
          elevation: 0.0,
          leading: IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.arrow_back),
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.white70,
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          titleSpacing: 9.0,
          // Note that the icon has 20 on the right due to its padding, so we add 10 to get our desired 29
          title: Text("Back",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "RobotoMedium",
                  fontSize: 20.0,
                  color: Colors.white)),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thanks for downloading",
                  style: TextStyle(
                      fontFamily: "Arial", fontSize: 34.0, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Column(children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontSize: 17.0,
                              height: 1.5),
                          children: [
                        TextSpan(
                          text: "Theres alot of hard work in keeping the app updated for everybody to use, so i encourage everyone capable to help out at"
                        ),
                        TextSpan(
                          text: "github",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => _launchUrl("https://www.flutter.io")
                        ),
                        TextSpan(
                          text: "This schema app is built using the ",
                        ),
                        TextSpan(
                            text: "Flutter",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => _launchUrl("https://www.flutter.io")),
                        TextSpan(
                          text: " language. ",
                        ),
                        TextSpan(
                          text: "The graphics and animations were created by ",
                        ),
                        TextSpan(
                            text: "2Dimensions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  _launchUrl("https://www.2dimensions.com")),
                        TextSpan(
                          text:
                              ".\n\nThe app builds on the application 'The history of everything' ",
                        ),
                        TextSpan(
                            text: "which can be found here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl(
                                  "https://github.com/2d-inc/HistoryOfEverything")),
                        TextSpan(
                          text: ".",
                        ),
                        TextSpan(
                            text: "\n\nCredits",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl(
                                  "https://schedule-flutter-2.herokuapp.com/credits/")),
                        TextSpan(
                          text: ".",
                        )
                      ]))
                ])),
                Text(
                  "Built with",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 17.0,
                      height: 1.5,
                      color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => _launchUrl("https://www.flutter.io"),
                  child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/flutter_logo.png",
                                height: 45.0, width: 37.0),
                            Container(
                              margin: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Flutter",
                                style: TextStyle(
                                    fontSize: 26.0, color: Colors.white),
                              ),
                            )
                          ])),
                ),
                Text(
                  "License\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                ),
                Text('''
MIT License

Copyright (c) 2018 2D, Inc

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.''', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ));
  }
}
