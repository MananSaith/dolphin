import 'package:dolphin/shared/app_imports/app_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showMenuButton;

  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    this.showBackButton = false,
    this.showMenuButton = true,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: preferredSize.height,
        child: Row(
          children: [
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            if (showMenuButton)
              InkWell(
                onTap: () {
                  final scaffoldState = Scaffold.maybeOf(context);
                  if (scaffoldState != null && scaffoldState.hasDrawer) {
                    scaffoldState.openDrawer();
                  } else {
                    debugPrint("No drawer found in the Scaffold.");
                  }
                },
                //  child: SvgPicture.asset(AppImages.menuIconSvg, height: 20),
                child: Image.asset(AppImages.logo, height: 20),
              ),
            const SizedBox(width: 12),

            /// Center part with logo (takes available space)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //  children: [Image.asset(AppImages.logoPng, scale: 4)],
                children: [Image.asset(AppImages.logo, scale: 4)],
              ),
            ),

            /// Right section with icons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(AppImages.logo, height: 30),
                  // child: SvgPicture.asset(AppImages.searchIconSvg, height: 30),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: Image.asset(AppImages.logo, height: 25),
                  // child: SvgPicture.asset(AppImages.bellIconSvg, height: 25),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(radius: 18),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: Image.asset(AppImages.logo, height: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
