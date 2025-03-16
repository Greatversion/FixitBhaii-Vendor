import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixitbhaiivendor/routes/app.routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fixitbhaiivendor/utils/themes/app.dimensions.dart';
import 'package:fixitbhaiivendor/utils/themes/app.theme.dart';
// import 'package:fixitbhaiivendor/views/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      builder: (context) => FixitBhaiiVendor(),
    ),
  );
  //  runApp(
  //   FixitBhaiiVendor(),
  // );
}

class FixitBhaiiVendor extends StatelessWidget {
  const FixitBhaiiVendor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dimensions.init(context); // Initialize dimensions here
    final AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FixitBhaii Vendor',
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      routerConfig: appRouter.config(),
      themeMode: ThemeMode.system,
    );
  }
}
