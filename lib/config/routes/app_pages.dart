import 'package:dolphin/shared/app_imports/app_imports.dart';

class AppPages {
  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.splashView: (_) => const SplashView(),
    AppRoutes.loginScreen: (_) => const LoginScreen(),
    AppRoutes.signUpScreen: (_) => const SignUpScreen(),
    AppRoutes.mainScreen: (_) => MainScreen(),
    //   AppRoutes.getStart: (_) => const GetStartScreen(),
    //   AppRoutes.favoriteScreen: (_) => const FavoriteScreen(),
    //   AppRoutes.productDetail: (context) {
    //     final product =
    //         ModalRoute.of(context)!.settings.arguments as ProductModel;
    //     return ProductDetail(product: product);
    //   },
    //
    //   AppRoutes.bottomNavigationBarWidget: (_) =>
    //       const BottomNavigationBarWidget(),
  };
}
