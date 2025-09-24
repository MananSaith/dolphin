import 'package:dolphin/shared/app_imports/app_imports.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: AppColors.darkPurple,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Image.asset(AppImages.logo, scale: 6),
              3.verticalSpace,
              SizedBox(
                height: screenHeight < 700 ? 60.h : 70.h,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      profileScreenTitleWidget(
                        icons: AppImages.logo,
                        title: 'updateProfile',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  profileScreenTitleWidget({
    String? icons,
    String? title,
    VoidCallback? onTap,
    double height = 18,
    double width = 18,
  }) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            SvgPicture.asset(icons!, height: height, width: width),
            10.horizontalSpace,
            AppText(
              text: title!,
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
