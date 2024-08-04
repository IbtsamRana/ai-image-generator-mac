import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imagecreator_mac/src/core/navigation/navigation.dart';
import 'package:imagecreator_mac/src/ui/screens/splash/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

import 'src/core/model/purchase_model/purchase_model.dart';
import 'src/core/service/storage_service.dart';
import 'src/core/service/subscription_service.dart';
import 'src/core/service/user_service.dart';
import 'src/ui/screens/mainscreens/main_screen.dart';

late final StorageService storageService;
late final SubscriptionsController subscriptionsController;
late final UserController user;
final appstateKey = GlobalKey<MainScreenState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.

  storageService = HiveService();
  await storageService.init();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1400, 800),
    minimumSize: Size(1400, 800),
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  user = UserController(const PurchaseModel());
  if (Platform.isMacOS) {
    subscriptionsController = SubscriptionsController(InAppModel());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Image Generator',
      navigatorKey: NavigationService.navigationKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
