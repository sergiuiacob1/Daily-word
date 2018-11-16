import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'api.dart';
import 'word.dart';

class WordNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  WordNotifier() {
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
    print(payload);
  }

  Future scheduleNotification() async {
    var time = new Time(19, 0, 15);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'DailyWord', 'Receive notification with the word of the day');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    List<Word> _words = await Api.getDailyWords();
    await flutterLocalNotificationsPlugin.showDailyAtTime(0, _words[0].name,
        _words[0].definition, time, platformChannelSpecifics);
  }
}
