import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './../blocs/internet_results_bloc.dart';
import './../blocs/words_storage_bloc.dart';
import './../models/word.dart';

class WordNotifierBloc {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  WordsStorageBloc _storageBloc = WordsStorageBloc();
  InternetResultsBloc _internetResultsBloc = InternetResultsBloc();

  WordNotifierBloc() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _internetResultsBloc.wordsStream.listen((onData) {
      for (Word _word in onData) {
        _storageBloc.addNewDailyWord(_word);
      }
    });
  }

  Future onSelectNotification(String payload) async {
    _internetResultsBloc.getDailyWords();
  }

  Future testNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    return;
    print('making notification');

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
  }

  Future scheduleNotification() async {
    return;
    var time = new Time(19, 20);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'DailyWord', 'Receive notification with the word of the day');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(0, "test", "body",
        RepeatInterval.EveryMinute, platformChannelSpecifics);

    // await flutterLocalNotificationsPlugin.showDailyAtTime(
    //     0, "New daily words!", 'Check it out!', time, platformChannelSpecifics);
  }
}
