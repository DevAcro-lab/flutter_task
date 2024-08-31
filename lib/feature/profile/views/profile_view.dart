import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/configures/app_colors.dart';
import 'package:flutter_task/configures/app_spaces.dart';
import 'package:flutter_task/feature/home/models/user_details.dart';
import 'package:flutter_task/feature/home/view_model/home_view_model.dart';
import 'package:flutter_task/utils/assets.dart';
import 'package:flutter_task/utils/customs/custom_loader.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            child: Consumer<HomeViewModel>(
              builder: (context, userDetailsNotifier, child) {
                if (userDetailsNotifier.isLoading) {
                  return Center(
                    child: customLoader(),
                  );
                } else if (userDetailsNotifier.errorMessage != null) {
                  return errorWidget(userDetailsNotifier);
                } else {
                  return buildSuccessContent(
                      context: context,
                      s: s,
                      userDetails: userDetailsNotifier.userDetails!);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Center errorWidget(HomeViewModel userDetailsNotifier) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            userDetailsNotifier.errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () {
              userDetailsNotifier.getUserDetailsNotifier();
            },
            child: const Text(
              'Retry',
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }

  Column buildSuccessContent(
      {required BuildContext context,
      required Size s,
      required UserDetails userDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(context),
        buildProfileContainer(s, context, userDetails),
        AppSpaces.mediumSpace(context),
        Row(
          children: [
            Expanded(
              child: buildCard(
                context: context,
                s: s,
                title: "Earnings",
                subtitle: userDetails.data!.earnings.toString(),
                subtitleWidget: const SizedBox(),
              ),
            ),
            SizedBox(width: s.width * 0.05),
            Expanded(
              child: buildCard(
                context: context,
                s: s,
                title: "Ratings",
                subtitle: userDetails.data!.ratings.toString(),
                showSubtitleWidget: true,
                subtitleWidget: const Icon(
                  Icons.star_half,
                  size: 24,
                  color: Color(0xffe8c62b),
                ),
              ),
            ),
          ],
        ),
        AppSpaces.mediumSpace(context),
        Text(
          "About Me",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        aboutMeTextContent(userDetails),
        AppSpaces.smallSpace(context),
        const Divider(),
        buildListTile(
          context: context,
          title: "Business Location",
          leading: const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          trailingIcon: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: Colors.blue,
          ),
        ),
        const Divider(),
        buildListTile(
          context: context,
          title: "Bookings",
          leading: const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          trailingIcon: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: Colors.blue,
          ),
        ),
        const Divider(),
        buildListTile(
          context: context,
          title: "My Services",
          leading: const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          trailingIcon: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: Colors.blue,
          ),
        ),
        const Divider(),
      ],
    );
  }

  ListTile buildListTile(
      {required BuildContext context,
      required String title,
      required Widget leading,
      required Widget trailingIcon}) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: leading,
      trailing: trailingIcon,
    );
  }

  ReadMoreText aboutMeTextContent(UserDetails userDetails) {
    return ReadMoreText(
      userDetails.data!.bio!,
      style: const TextStyle(fontSize: 12),
      trimMode: TrimMode.Line,
      trimLines: 3,
      colorClickableText: AppColors.primaryColor,
      trimCollapsedText: 'view more',
      trimExpandedText: ' view less',
      lessStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      moreStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }

  Card buildCard({
    required Size s,
    required BuildContext context,
    required String title,
    required String subtitle,
    required Widget subtitleWidget,
    bool showSubtitleWidget = false,
  }) {
    return Card(
      child: Container(
        height: s.height * 0.09,
        decoration: BoxDecoration(
          color: AppColors.borderSideColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            showSubtitleWidget
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subtitleWidget,
                      SizedBox(width: s.width * 0.02),
                      Text(
                        "\$$subtitle",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                      ),
                    ],
                  )
                : Text(
                    "\$$subtitle",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                  ),
          ],
        ),
      ),
    );
  }

  Container buildProfileContainer(
      Size s, BuildContext context, UserDetails userDetails) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: s.height * 0.2,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppAssets.profileContainer,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: s.height * 0.06,
                backgroundImage: NetworkImage(userDetails.data!.avatar!),
              ),
              Positioned(
                right: 4,
                bottom: 5,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: AppColors.whiteColor,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppSpaces.smallSpace(context),
          Text(
            "${userDetails.data!.firstName} ${userDetails.data!.lastName}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            userDetails.data!.email!,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
          ),
        ],
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "My Profile",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 19,
              ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }
}
