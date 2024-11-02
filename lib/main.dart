import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/navigators/app_pages.dart';
import 'data/helper/connect_helper.dart';
import 'data/repositories/data_repositories.dart';
import 'device/device_export.dart';
import 'domain/repositories/repository.dart';
import 'domain/services/common_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  Get.put(Repository(
    Get.put(
      DeviceRepository(),
      permanent: true,
    ),
    Get.put(
      DataRepository(
        Get.put(
          ConnectHelper(),
          permanent: true,
        ),
      ),
      permanent: true,
    ),
  ));

  ///Services.
  await Get.putAsync(() => CommonService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Occult Sciences App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
    );
  }
}
