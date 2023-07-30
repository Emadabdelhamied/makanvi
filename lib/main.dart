import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/app/makanvi_app.dart';
import 'core/notification_service/notification_service.dart';
import 'core/util/bloc_observer.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDNmbUUM29l3-TYdwyyiGuoc-HrvsIegSk",
        authDomain: "makanvi-10592.firebaseapp.com",
        projectId: "makanvi-10592",
        storageBucket: "makanvi-10592.appspot.com",
        messagingSenderId: "324895378902",
        appId: "1:324895378902:web:3d092f70966f7790f56877",
        measurementId: "G-X24BLW96PK"),
  );
  NotificationService.instance!.initNotificationService();
  NotificationService().setupLocator();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  // String release;
  // if (Platform.isAndroid) {
  //   var androidInfo = await DeviceInfoPlugin().androidInfo;
  //   release = androidInfo.version.release;
  //   var sdkInt = androidInfo.version.sdkInt;
  //   var manufacturer = androidInfo.manufacturer;
  //   var model = androidInfo.model;
  //   log('Android $release (SDK $sdkInt), $manufacturer $model');
  //   // Android 9 (SDK 28), Xiaomi Redmi Note 7
  // }

  // if (Platform.isIOS) {
  //   var iosInfo = await DeviceInfoPlugin().iosInfo;
  //   release = iosInfo.utsname.machine.split('e')[1].split(',')[0];

  //   log(iosInfo.utsname.machine);
  //   // iOS 13.1, iPhone 11 Pro Max iPhone
  // }
  await di.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'lang',
      saveLocale: true,
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MakanviApp(release: "1"),
    ),
  );
}
