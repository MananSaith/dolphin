import '../../../shared/app_imports/app_imports.dart';
import '../controller/blog_controller.dart';

class BlogDetailScreen extends StatelessWidget {
  final Map<String, dynamic> blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BlogController>();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final List<String> images =
        (blog['images'] as List?)?.cast<String>() ??
        (blog['image'] != null ? [blog['image']] : []);
    final List sections = (blog['sections'] as List?) ?? [];
    final String? content = blog['content']; // fallback simple content

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          blog['title'] ?? 'Blog',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle
                    if (blog['subtitle'] != null) ...[
                      Text(
                        blog['subtitle'],
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],

                    // Top image (first of two)
                    if (images.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: Image.asset(
                          images.first,
                          height: 180.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 14.h),
                    ],

                    // Structured sections (preferred)
                    if (sections.isNotEmpty)
                      ...List.generate(sections.length, (i) {
                        final s = sections[i] as Map<String, dynamic>;
                        final heading = s['heading'] as String?;
                        final text = s['text'] as String?;
                        final bullets = (s['bullets'] as List?)?.cast<String>();

                        final showSecondImage =
                            (i == 1 &&
                            images.length >=
                                2); // place 2nd image after section 2

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (heading != null) ...[
                              Text(
                                heading,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                            ],
                            if (text != null) ...[
                              Text(
                                text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                            if (bullets != null && bullets.isNotEmpty) ...[
                              ...bullets.map(
                                (b) => Padding(
                                  padding: EdgeInsets.only(bottom: 6.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '•  ',
                                        style: TextStyle(
                                          color: Colors.cyanAccent,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          b,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                            if (showSecondImage) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14.r),
                                child: Image.asset(
                                  images[1],
                                  height: 180.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 14.h),
                            ],
                          ],
                        );
                      })
                    else if (content != null) // Fallback: simple content
                      Text(
                        content,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                      ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Reward button
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Obx(() {
                return controller.isRewarding.value
                    ? SizedBox(
                        height: 48.h,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          icon: const Icon(Icons.redeem),
                          label: const Text(
                            'Claim Reward (+0.1 Dolphin)',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onPressed: () async {
                            await controller.rewardUser(uid);
                            Get.back();
                            Get.snackbar(
                              'Success',
                              '+0.1 Dolphin Coin added!',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                        ),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
