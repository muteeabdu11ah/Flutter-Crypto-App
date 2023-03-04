import 'package:cryptocurrency_app/constants/keys.dart';
import 'package:cryptocurrency_app/models/markets/pair/pair.dart';
import 'package:cryptocurrency_app/provider/crypto_provider.dart';
import 'package:cryptocurrency_app/ui/widgets/details/details_widget.dart';
import 'package:cryptocurrency_app/ui/widgets/details/ohlc_section.dart';
import 'package:cryptocurrency_app/ui/widgets/details/time_bar_selector.dart';
import 'package:cryptocurrency_app/ui/widgets/title_price.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsScreen extends HookConsumerWidget {
  final Pair pair;
  DetailsScreen({required this.pair});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graph = ref.watch(graphDataProvider(pair));

    return Scaffold(
      key: Keys.DETAILS_SCREEN,
      appBar: AppBar(
        actions: [
          Container(
            width: 120,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TitlePrice(pair: pair)),
              // Row(
              //   children: [
              //     TextButton(onPressed: () {}, child: Text('Ohlc')),
              //     TextButton(onPressed: () {}, child: Text('Line')),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                height: 250,
                child: graph.when(
                    data: (data) => OHLCSection(
                          data: data,
                        ),
                    loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                    error: (error, e) => Center(
                          child: Text(error.toString().tr()),
                        ),),
              ),
              SizedBox(
                height: 20,
              ),
              TimeBarSelector(),
              SizedBox(
                height: 15,
              ),
              DetailsWidget(pair: pair),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
