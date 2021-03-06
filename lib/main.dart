import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/MainUI/Home.dart';
import 'package:treex_app/UI/MainUI/extra/DevTool.dart';
import 'package:treex_app/UI/MainUI/extra/Message.dart';
import 'package:treex_app/UI/MainUI/extra/Profiles.dart';
import 'package:treex_app/UI/MainUI/extra/SafetySettings.dart';
import 'package:treex_app/UI/MainUI/extra/Settings.dart';
import 'package:treex_app/UI/MainUI/extra/About.dart';
import 'package:treex_app/UI/MainUI/extra/Network.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/FilesAll.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/FilesType.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/FilesShared.dart';
import 'package:treex_app/UI/MainUI/extraPages/friends/FriendsList.dart';
import 'package:treex_app/UI/MainUI/extraPages/file/RecycleBin.dart';
import 'package:treex_app/UI/MainUI/extraPages/friends/Group.dart';
import 'package:treex_app/UI/MainUI/extraPages/transfer/Transfer.dart';
import 'package:treex_app/UI/MainUI/tools/ScanTool.dart';
import 'package:treex_app/UI/auth/Login.dart';
import 'package:treex_app/UI/splash/FirstInit.dart';
import 'package:treex_app/UI/splash/Splash.dart';
import 'package:treex_app/licenses/GPLView.dart';
import 'package:treex_app/provider/AppProvider.dart';
import 'package:treex_app/theme/ThemeData.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.black));

  runApp(ChangeNotifierProvider(
    create: (_) => AppProvider(),
    child: BotToastInit(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      title: 'treex',
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: provider.themeMode,
      initialRoute: 'splash',
      routes: {
        'first': (context) => FirstInitPage(),
        'splash': (context) => SplashPage(),
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        'scan': (context) => ScanToolPage(),
        'settings': (context) => SettingsPage(),
        'profile': (context) => ProfilesPage(),
        'about': (context) => AboutPage(),
        'licenses': (context) => LicensePage(),
        'licenses_gpl': (context) => GPLViewPage(),
        'network': (context) => NetworkPage(),
        'safety': (context) => SafetySettingsPage(),
        'message': (context) => MessageSettingsPage(),
        'transfer': (context) => TransferPage(),
        'recycle': (context) => RecycleBinPage(),
        'filesAll': (context) => FilesAllPage(),
        'filesType': (context) => FilesTypePage(),
        'filesShared': (context) => FilesSharedPage(),
        'friendsList': (context) => FriendsListPage(),
        'groupChannel': (context) => GroupPage(),
        'devTool': (context) => DevToolPage(),
      },
    );
  }
}
