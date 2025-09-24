import 'package:dolphin/shared/app_imports/app_imports.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Get.offNamed(AppRoutes.mainScreen);
      } else {
        Get.offNamed(AppRoutes.loginScreen);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Image.asset(
                    AppImages.logo,
                    width: 120.w,
                    height: 120.w,
                  ),
                );
              },
            ),
            10.verticalSpace,
            AppText(
              text: 'Dolphin',
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.magenta,
            ),
            AppText(
              text: 'Coin',
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.magenta,
            ),
          ],
        ),
      ),
    );
  }
}
