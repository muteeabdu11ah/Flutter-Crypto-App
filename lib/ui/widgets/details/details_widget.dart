import 'package:cryptocurrency_app/models/markets/pair/pair.dart';
import 'package:cryptocurrency_app/provider/crypto_provider.dart';
import 'package:cryptocurrency_app/ui/screens/lottery.dart';
import 'package:cryptocurrency_app/ui/widgets/details/snackbar.dart';
import 'package:cryptocurrency_app/ui/widgets/details/summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';

import 'order_book_section.dart';
import 'trades_section.dart';

class DetailsWidget extends HookConsumerWidget {
  final Pair pair;
  const DetailsWidget({Key? key, required this.pair}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useTabController(initialLength: 4);
    final graph = ref.watch(graphDataProvider(pair));
    final summary = ref.watch(pairSummaryProvider(pair));
    final orderBook = ref.watch(pairOrderBookProvider(pair));
    final trades = ref.watch(tradesProvider(pair));

    balance money = balance();

    return Container(
        child: Column(children: [
      TabBar(
        labelColor: Theme.of(context).focusColor,
        unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
        unselectedLabelStyle: Theme.of(context).textTheme.headline4,
        labelStyle: Theme.of(context).textTheme.headline4,
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).focusColor,
        isScrollable: true,
        controller: _controller,
        tabs: [
          Container(
              width: 100,
              child: Tab(
                text: LocaleKeys.summary.tr(),
              )),
          Tab(
            text: LocaleKeys.orderbook.tr(),
          ),
          Tab(text: LocaleKeys.trades.tr()),
          Tab(
            text: LocaleKeys.sell.tr(),
          )
          // Tab(
          //   text: LocaleKeys.ohlc.tr(),
          // ),
        ],
      ),
      Container(
        height: 300,
        child: TabBarView(
          controller: _controller,
          children: [
            summary.when(
                data: (data) => SummarySection(data: data),
                loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, e) => Center(
                      child: Text(error.toString().tr()),
                    )),
            orderBook.when(
                data: (data) => OrderBookSection(data: data),
                loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, e) => Center(
                      child: Text(error.toString().tr()),
                    )),
            trades.when(
                data: (data) => TradesSection(data: data),
                loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, e) => Center(
                      child: Text(error.toString().tr()),
                    )),
            Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Column(
                  children: [
                    Text('Your Balance =${money.value} \$'),
                    Spacer(),
                    TextField(
                      //  obscureText: isPass,
                      keyboardType: TextInputType.number,
                      // controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Amount in USDT',
                        border: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        filled: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                   Spacer(),
                    TextField(
                      //  obscureText: isPass,
                      keyboardType: TextInputType.number,
                      // controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Amount in BTC',
                        border: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        filled: true,
                        contentPadding: EdgeInsets.all(8),
                      ),),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showsnackbar(context, 'Future not supported yet.');
                          },
                          child: Container(
                            height: 43,
                            width: MediaQuery.of(context).size.width * 1 / 4,
                            child: Text(
                              'Buy',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 45, 44, 44)),
                            ),
                            //   width: double.infinity,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showsnackbar(context, 'Future not supported yet.');
                          },
                          child: Container(
                            height: 43,
                            width: MediaQuery.of(context).size.width * 1 / 4,
                            child: Text(
                              'Sell',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 45, 44, 44)),
                            ),
                            //   width: double.infinity,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(),
                  ],
                )),
          ],
        ),
      )
    ]));
  }
}
