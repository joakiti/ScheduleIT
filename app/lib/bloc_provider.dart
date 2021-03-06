import "package:flutter/widgets.dart";
import 'package:timeline/timeline/timeline.dart';
import 'package:timeline/timeline/timeline_entry.dart';

/// This [InheritedWidget] wraps the whole app, and provides access
/// to the user's favorites through the [FavoritesBloc] 
/// and the [Timeline] object.
class BlocProvider extends InheritedWidget {
  final Timeline timeline;

  /// This widget is initialized when the app boots up, and thus loads the resources.
  /// The timeline.json file contains all the entries' data.
  /// Once those entries have been loaded, load also all the favorites.
  /// Lastly use the entries' references to load a local dictionary for the [SearchManager].
  BlocProvider(
      {Key key,
      Timeline t,
      @required Widget child,
      TargetPlatform platform = TargetPlatform.iOS})
      : timeline = t ?? Timeline(platform),
        super(key: key, child: child) {
    timeline
        .loadFromBundle("assets/timeline.json")
        .then((List<TimelineEntry> entries) {
      timeline.setViewport(
          start: entries.first.start * 2.0,
          end: entries.first.start,
          animate: true);
      /// Advance the timeline to its starting position.
      timeline.advance(0.0, false);

    });
  }

  @override
  updateShouldNotify(InheritedWidget oldWidget) => true;


  /// static accessor for the [Timeline]. 
  /// e.g. [_MainMenuWidgetState.navigateToTimeline] uses this static getter to access build the [TimelineWidget].
  static Timeline getTimeline(BuildContext context) {
    BlocProvider bp =
        (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider);
    Timeline bloc = bp?.timeline;
    return bloc;
  }
}
