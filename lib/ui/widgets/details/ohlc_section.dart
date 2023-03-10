import 'package:cryptocurrency_app/models/graph/graph/graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
class OHLCSection extends StatelessWidget {
  final Graph data;
  const OHLCSection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: 
        InteractiveViewer(
          maxScale: 4,
          alignPanAxis: true, 
          child: new 
          OHLCVGraph(
              data: data.pairs[0].points
                  .map((e) => {
                        "open": e.openTime,
                        "high": e.highPrice,
                        "low": e.lowPrice,
                        "close": e.closePrice,
                        "volumeto": e.volume
                      })
                  .toList(),
              enableGridLines: true,
              volumeProp: 0.2,
              gridLineAmount: 7,
              gridLineColor: Colors.grey[300]!,
              gridLineLabelColor: Colors.grey),
        )
            );
  }
}
