import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //Initialize Instance and BD
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  static Future<void> onDidReceiveNotificationResponse (NotificationResponse notificationResponse) async {


  }


  //Initialize Notifications Plugin
  static Future<void> init() async
  {
    //Android Inititialization Settings
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/launcher_icon");

    //iOS Inititialization Settings

    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    //Combine Android and iOS initialization Settings

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings, 
      iOS: iOSInitializationSettings
    );

    //Initialize the plugin with the initialization settings

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
    );

    //Request Permission for Notifications for android

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

 Future<void> scheduleNotificationsIfNeeded() async {
  final now = DateTime.now();

  // Verifique se os dados de hoje não foram preenchidos
  if (!(await hasTodayRecord())) {
    final scheduledDate = DateTime(now.year, now.month, now.day, 20); 

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "daily_reminder",
        "Daily Reminder",
        channelDescription: "Notificação para lembrar de preencher os dados do dia.",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    // Agende a notificação para as 20h
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Lembrete diário',
      'Ainda não preencheu os dados de hoje!',
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}



  Future<bool> hasTodayRecord() async {
  final db = await databaseHelper.getDatabase();
  final now = DateTime.now();
  // Filtra registros para o mesmo ano, mês e dia
  final List<Map<String, dynamic>> records = await db.query(
    'registo',
    where: 'ano = ? AND mes = ? AND dia = ?',
    whereArgs: [now.year, now.month, now.day],
  );

  return records.isNotEmpty;
}


}
