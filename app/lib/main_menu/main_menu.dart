import "dart:async";

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:timeline/main_menu/menu_data.dart";
import "package:timeline/main_menu/main_menu_section.dart";
import "package:timeline/main_menu/about_page.dart";
import "package:timeline/colors.dart";
import 'package:timeline/timeline/timeline_widget.dart';
import 'package:timeline/ui/reservations_list.dart';

/// The Main Page of the Timeline App.
///
/// This Widget lays out the search bar at the top of the page,
/// the three card-sections for accessing the main events on the Timeline,
/// and it'll provide on the bottom three links for quick access to your Favorites,
/// a Share Menu and the About Page.
class MainMenuWidget extends StatefulWidget {
  MainMenuWidget({Key key}) : super(key: key);

  @override
  _MainMenuWidgetState createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  /// 2. Section Animations:
  /// Each card section contains a Flare animation that's playing in the background.
  /// These animations are paused when they're not visible anymore (e.g. when search is visible instead),
  /// and are played again once they're back in view.
  bool _isSectionActive = true;

  /// [MenuData] is a wrapper object for the data of each Card section.
  /// This data is loaded from the asset bundle during [initState()]
  final MenuData _menu = MenuData();

  /// Helper function which sets the [MenuItemData] for the [TimelineWidget].
  /// This will trigger a transition from the current menu to the Timeline,
  /// thus the push on the [Navigator], and by providing the [item] as
  /// a parameter to the [TimelineWidget] constructor, this widget will know
  /// where to scroll to.
  navigateToCourse(MenuItemData item, Color background) {
    _pauseSection();
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) => ReservationList(item, background),
        ))
        .then(_restoreSection);
  }

  _restoreSection(v) => setState(() => _isSectionActive = true);

  _pauseSection() => setState(() => _isSectionActive = false);

  initState() {
    super.initState();

    /// The [_menu] loads a JSON file that's stored in the assets folder.
    /// This asset provides all the necessary information for the cards,
    /// such as labels, background colors, the background Flare animation asset,
    /// and for each element in the expanded card, the relative position on the [Timeline].
    _menu.loadFromBundle("assets/menu.json").then((bool success) {
      if (success) setState(() {}); // Load the menu.
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    List<Widget> tail = [];

    /// Check the current state before creating the layout for the menu (i.e. [tail]).
    ///
    /// If the app is searching, lay out the results.
    /// Otherwise, insert the menu information with all the various sections.
    tail
      ..addAll(_menu.sections
          .map<Widget>((MenuSectionData section) => Container(
              margin: EdgeInsets.only(top: 20.0),
              child: MenuSection(
                section.label,
                section.backgroundColor,
                section.textColor,
                section.items,
                navigateToCourse,
                _isSectionActive,
                assetId: section.assetId,
              )))
          .toList(growable: false))
      ..add(Container(
        margin: EdgeInsets.only(top: 40.0, bottom: 22),
        height: 1.0,
        color: const Color.fromRGBO(255, 255, 255, 0.1),
      ))
      ..add(Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FlatButton(
            onPressed: () {
              _pauseSection();
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => AboutPage()))
                  .then(_restoreSection);
            },
            color: Colors.transparent,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.only(right: 15.5),
                child: Image.asset("assets/info_icon.png",
                    height: 20.0,
                    width: 20.0,
                    color: Colors.white.withOpacity(0.9)),
              ),
              Text(
                "About",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "RobotoMedium",
                    color: Colors.white.withOpacity(0.9)),
              )
            ])),
      ))
      ..add(
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Text(
          "Bug reports and crashes at mikan@itu.dk",
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "RobotoMedium",
              color: Colors.white.withOpacity(0.9)),
        )
      ]));

    /// Wrap the menu in a [WillPopScope] to properly handle a pop event while searching.
    /// A [SingleChildScrollView] is used to create a scrollable view for the main menu.
    /// This will contain a [Column] with a [Collapsible] header on top, and a [tail]
    /// that's built according with the state of this widget.
    return Container(
        color: background,
        child: Padding(
          padding: EdgeInsets.only(top: devicePadding.top),
          child: SingleChildScrollView(
              padding:
                  EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 12.0),
                                  child: Opacity(
                                      opacity: 0.85,
                                      child: Text(
                                        "IT-UNIVERSITY OF COPENHAGEN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Arial"),
                                      ))),
                              Text("Find your schedule",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 34.0,
                                      fontFamily: "RobotoMedium"))
                            ]),
                      ] +
                      tail)),
        ));
  }
}
