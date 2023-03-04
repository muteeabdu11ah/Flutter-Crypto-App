import 'package:cryptocurrency_app/constants/keys.dart';
import 'package:cryptocurrency_app/logIn_SignUp.dart/login_screen.dart';
import 'package:cryptocurrency_app/provider/navigation_provider.dart';
import 'package:cryptocurrency_app/ui/screens/home.dart';
import 'package:cryptocurrency_app/ui/screens/lottery.dart';
import 'package:cryptocurrency_app/ui/screens/lucky.dart';
import 'package:cryptocurrency_app/ui/screens/search.dart';
import 'package:cryptocurrency_app/ui/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../generated/locale_keys.g.dart';

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageModel navigation = ref.watch(navigationProvider);
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return loginScreen();
    } else
      return Scaffold(
        body: currentScreen(navigation.index),
        bottomNavigationBar: BottomNavigationBar(
            key: Keys.NAV_BAR,
            currentIndex: navigation.index,
            onTap: (index) {
              ref.read(navigationProvider.notifier).selectPage(index);
            },
            items: [
              BottomNavigationBarItem(
                label: LocaleKeys.homeTitle.tr(),
                icon: Icon(
                  Icons.home,
                  color: Colors.black45,
                  key: Keys.NAV_HOME,
                ),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.searchTitle.tr(),
                icon: Icon(
                  Icons.search,
                  key: Keys.NAV_SEARCH,
                  color: Colors.black45,
                ),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.lotteryTitle.tr(),
                icon: Icon(
                  CupertinoIcons.wand_rays,
                  color: Colors.black45,
                  key: Keys.NAV_BINANCE,
                ),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.walletTitle.tr(),
                icon: Icon(
                  Icons.wallet,
                  color: Colors.black45,
                  key: Keys.NAV_SETTINGS,
                ),
              ),
            ]),
      );
  }

  Widget currentScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      case 2:
        return luckynumber();
      case 3:
        return SettingScreen();
      default:
        return HomeScreen();
    }
  }
}
