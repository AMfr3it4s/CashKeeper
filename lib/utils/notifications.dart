import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cashkeeper/utils/databasehelper.dart';

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> initialize() async {
    // Configurações do Android para as notificações
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = DarwinInitializationSettings();
    var initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Solicitar permissão para notificações no Android
    if (Platform.isAndroid) {
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }

    // Solicitar permissão para notificações no iOS
    if (Platform.isIOS) {
      await Permission.notification.request();
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


  Future <void> scheduleNotification() async {
    final now = DateTime.now();
    if (now.hour >= 18 && !(await hasTodayRecord())) {
      var androidDetails = AndroidNotificationDetails(
        'daily_reminder',
        'Daily Reminder',
        channelDescription: 'Notificação para lembrar de preencher os dados do dia.',
        importance: Importance.high,
        priority: Priority.high,
      );
      var iosDetails = DarwinNotificationDetails();
      var generalDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

      await flutterLocalNotificationsPlugin.show(
        0,
        'Lembrete diário',
        'Ainda não preencheu os dados de hoje!',
        generalDetails,
      );
    }
  }

}
