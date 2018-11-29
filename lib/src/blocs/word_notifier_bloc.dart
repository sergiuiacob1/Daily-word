import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './app_utils_bloc.dart';

class WordNotifierBloc {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AppUtilsBloc _appUtilsBloc = AppUtilsBloc();

  WordNotifierBloc() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    _appUtilsBloc.addDailyWords();
  }

  Future scheduleNotification() async {
    var time = new Time(19, 20);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'DailyWords', 'Receive notification with the daily words');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        "New daily words!",
        'Check it out!',
        RepeatInterval.EveryMinute,
        platformChannelSpecifics);
  }
}
