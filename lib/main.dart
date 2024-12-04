import 'package:ecommerce_shop/routes/app_routes.dart';
import 'package:ecommerce_shop/services/notification_service.dart';
import 'package:ecommerce_shop/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_shop/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_binding.dart';
import 'controllers/internet/network_controller.dart';
import 'controllers/theme/theme_controller.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("\n\n--------BACKGROUND MESSAGE----------");
  print("\n${message.data}");
  print(
      '\nTitle: ${message.notification?.title}\nBody: ${message.notification?.body}\n------------------------------\n');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //enable background listener
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  _initiateFCM();
  _initiateRemoteConfig();
  await GetStorage.init();
  Get.put(NetworkManager(), permanent: true);
  runApp(const MyApp());
}

_initiateRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 5),
  ));

  await remoteConfig.setDefaults(const {
    "name": 'Md. Golam Kausar',
    "age": 3.26,
  });

  await remoteConfig.fetchAndActivate();

  print(
      '-------------REMOTE CONFIG-------------\n${remoteConfig.getString('name')} is ${remoteConfig.getInt('age')} years old\n');

  remoteConfig.onConfigUpdated.listen((event) async {
    await remoteConfig.activate();
    print(
        '-------------REMOTE CONFIG UPDATE-------------\n${remoteConfig.getString('name')} is ${remoteConfig.getInt('age')} years old\n');
  });
}

_initiateFCM() async {
  try {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print('fcm token : $fcmToken');

      NotificationServices.initializeNotification();

      //enable foreground listener
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("\n\n--------FOREGROUND MESSAGE----------");
        print("\n${message.data}");
        print(
            '\nTitle: ${message.notification?.title}\nBody: ${message.notification?.body}\n------------------------------\n');

        final notification = message.notification;
        final android = notification?.android;
        if (notification != null && android != null) {
          // Show a notification using a local notification package like
          NotificationServices.showNotification(notification);
        }
      });

      //app is opening from background state
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("\n\n-------MESSAGE OPEN FROM BACKGROUND----------");
        print("\n${event.data}");
        print(
            '\nTitle: ${event.notification?.title}\nBody: ${event.notification?.body}\n------------------------------\n');
      });

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        print('fcm refresh token : $fcmToken');
      }).onError((err) {
        print('fcm refresh token : $err');
      });
    }
  } catch (error) {
    print('permission request error');
    return;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemesController themeController = Get.put(ThemesController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce app',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: getThemeMode(themeController.theme),
      getPages: Routes.routes,
      initialRoute: Routes.INITIAL,
      initialBinding: AppBinding(),
    );
  }

  ThemeMode getThemeMode(String type) {
    ThemeMode themeMode = ThemeMode.system;
    switch (type) {
      case "system":
        themeMode = ThemeMode.system;
        break;
      case "dark":
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }

    return themeMode;
  }
}
