import 'package:cashkeeper/pages/details/details.dart';
import 'package:cashkeeper/pages/home/home.dart';
import 'package:cashkeeper/pages/random/random.dart';
import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:cashkeeper/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await NotificationService.init();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final NotificationService notificationHelper = NotificationService();

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  void initializeDatabase() async {
    await databaseHelper.getDatabase();
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
