import 'package:cashkeeper/pages/details/details.dart';
import 'package:cashkeeper/pages/home/home.dart';
import 'package:cashkeeper/pages/random/random.dart';
import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:cashkeeper/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Aqui você chama a função de notificação
    final notificationHelper = NotificationHelper();
    await notificationHelper.scheduleNotification();
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final NotificationHelper notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    initializeDatabase();
    initializeWorkManager();
  }

  void initializeDatabase() async {
    await databaseHelper.getDatabase();
  }

  void initializeWorkManager() {
    // Inicializa o WorkManager
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    notificationHelper.initialize();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashKeeper',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => DetailsPage(),
        '/random': (context) => RandomPage(),
      },
      initialRoute: '/',
    );
  }
}
