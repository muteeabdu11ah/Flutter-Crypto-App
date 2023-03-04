import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeGraphData {
  String name;
  String periods;
  String after;
 // String after;
  TimeGraphData(this.name, this.periods, this.after);
}

final timeList = [
  TimeGraphData("1M", "60", "1",),
  TimeGraphData("3M", "180", "3",),
  TimeGraphData("5M", "300", "5",),
  TimeGraphData("1H", "3600", "80,",),
  TimeGraphData("1D", "7200", "250",),
  TimeGraphData("1W", "14400", "500",)
];

final timeDataProvider =
    StateProvider<TimeGraphData>((ref) => TimeGraphData("1M", "60", "1",));
