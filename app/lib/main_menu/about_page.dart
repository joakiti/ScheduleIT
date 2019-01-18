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
          titleSpacing:
          9.0, // Note that the icon has 20 on the right due to its padding, so we add 10 to get our desired 29
          title: Text("Back",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "RobotoMedium",
                  fontSize: 20.0,
                  color: Colors.white)),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thanks for downloading",
                style: TextStyle(
                    fontFamily: "Arial",
                    fontSize: 34.0,
                    color: Colors.white),
              ),
              SizedBox(height: 100,),
              Expanded(
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
                                text:
                                ". The graphics and animations were created using tools by ",
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
                                text: ".\n\nThe app builds on the application 'The history of everything' ",
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
                                        "www.google.com")),
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
                                  fontSize: 26.0,
                                  color: Colors.white),
                            ),
                          )
                        ])),
              )
            ],
          ),
        ));
  }
}
