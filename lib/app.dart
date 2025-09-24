import 'package:dolphin/shared/app_imports/app_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dolphin',
          theme: ThemeData.dark(),
          initialRoute: AppRoutes.splashView,
          routes: AppPages.routes,
        );
      },
    );
  }
}
