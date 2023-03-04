import 'package:cryptocurrency_app/constants/keys.dart';
import 'package:cryptocurrency_app/logIn_SignUp.dart/firebase_auth.dart';
import 'package:cryptocurrency_app/logIn_SignUp.dart/text_field_input.dart';
import 'package:cryptocurrency_app/models/exchanges/exchange/exchange.dart';
import 'package:cryptocurrency_app/models/markets/pair/pair.dart';
import 'package:cryptocurrency_app/provider/crypto_provider.dart';
import 'package:cryptocurrency_app/provider/settings_provider.dart';
import 'package:cryptocurrency_app/ui/screens/lottery.dart';
import 'package:cryptocurrency_app/ui/widgets/details/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../generated/locale_keys.g.dart';
import 'lottery.dart';

class SettingScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    balance money = balance();
    final settings = ref.watch(cryptoSettings);
    final exchanges = ref.watch(exchangesProvider);
    final pairs = ref.watch(pairsProvider);

    final details =
        settings.maybeWhen(data: (details) => details, orElse: () => null);
    final TextEditingController _numberController = TextEditingController();

    return details != null
        ? Container(
            key: Keys.SETTINGS_SCREEN,
            child: Column(
              children: [
                AppBar(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.walletTitle.tr(),
                    ),
                    TextButton(
                        onPressed: () async {
                          await authMethods().SignOut(context);
                        },
                        child: Text(
                          'LogOut',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ))
                  ],
                )),
                Column(children: [
                  Text(
                    'Your Balance',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    ' ${money.value}\$',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.all(25)),
                  Text('Enter your Lucky number'),
                  Padding(padding: EdgeInsets.all(25)),
                  text_field(
                      textEditingController: _numberController,
                      hintText: 'Six digit code',
                      textInputType: TextInputType.number),
                  Padding(padding: EdgeInsets.all(25)),
                  GestureDetector(
                    onTap: () {
                      showsnackbar(context, 'Try again later.');
                    },
                    child: Container(
                      height: 43,
                      child: Text(
                        'Enter ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
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
                  Padding(padding: EdgeInsets.all(25)),
                ]),
                Expanded(
                  child: SettingsList(
                    contentPadding: EdgeInsets.zero,
                    sections: [
                      SettingsSection(
                        title: Text(LocaleKeys.dataSection.tr()),
                        tiles: [
                          SettingsTile(
                            title: Text(LocaleKeys.exchange.tr()),
                            value: Text(details.favoriteExchange),
                            leading: Icon(Icons.graphic_eq),
                            onPressed: (BuildContext context) =>
                                showExchangeSelectDialog(
                                    context, ref, exchanges),
                          ),
                          SettingsTile(
                              title: Text(LocaleKeys.topPair.tr()),
                              value: Text(details.favoritePair),
                              leading: Icon(Icons.language),
                              onPressed: (BuildContext context) =>
                                  showTopPairSelectDialog(context, ref, pairs)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : CircularProgressIndicator();
  }

  void showExchangeSelectDialog(BuildContext context, WidgetRef ref,
      AsyncValue<List<Exchange>> exchanges) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 300,
              width: 200,
              child: exchanges.maybeWhen(
                  data: (data) => ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(cryptoSettings.notifier)
                                  .setFavoriteExchange(data[index].symbol);

                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                data[index].name,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        },
                      ),
                  orElse: () => CircularProgressIndicator()),
            ),
          );
        });
  }

  void showTopPairSelectDialog(
      BuildContext context, WidgetRef ref, AsyncValue<List<Pair>> pairs) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                height: 300,
                width: 200,
                child: pairs.maybeWhen(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(cryptoSettings.notifier)
                                        .setFavoritePair(data[index].pair);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    child: Text(data[index].pair,
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    orElse: () => Center(
                          child: CircularProgressIndicator(),
                        ))),
          );
        });
  }
}
