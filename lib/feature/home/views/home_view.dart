import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/configures/app_colors.dart';
import 'package:flutter_task/configures/app_spaces.dart';
import 'package:flutter_task/feature/home/models/user_details.dart';
import 'package:flutter_task/feature/home/view_model/home_view_model.dart';
import 'package:flutter_task/utils/assets.dart';
import 'package:provider/provider.dart';

import '../../../utils/customs/custom_loader.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, userDetailsNotifier, child) {
          // Handle loading state
          if (userDetailsNotifier.isLoading) {
            return Center(child: customLoader());
          } else if (userDetailsNotifier.errorMessage != null) {
            return errorWidget(userDetailsNotifier);
          } else if (userDetailsNotifier.userDetails != null) {
            return buildSuccessContent(
              context: context,
              s: s,
              userDetailsNotifier: userDetailsNotifier,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  // WIDGET : WHEN DATA IS NOT SUCCESSFULLY FETCHED
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

  // WIDGET: WHEN DATA IS SUCCESSFULLY FETCHED
  Column buildSuccessContent(
      {required BuildContext context,
      required Size s,
      required HomeViewModel userDetailsNotifier}) {
    final UserDetails userDetails = userDetailsNotifier.userDetails!;
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Column(
                children: [
                  homeHeader(context, userDetails, s),
                  AppSpaces.smallSpace(context),
                  AppSpaces.smallSpace(context),
                  buildBannerContainer(
                      context: context, s: s, userDetails: userDetails),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                AppSpaces.smallSpace(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSmallCircleAvatar(AppAssets.pic1Icon),
                    buildSmallCircleAvatar(AppAssets.pic2Icon),
                    buildSmallCircleAvatar(AppAssets.pic3Icon),
                    buildSmallCircleAvatar(AppAssets.pic4Icon),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildLargeCircleAvatar(AppAssets.pic5Icon),
                    buildLargeCircleAvatar(AppAssets.pic6Icon),
                    buildLargeCircleAvatar(AppAssets.pic3Icon),
                  ],
                ),
                AppSpaces.mediumSpace(context),
                Text(
                  "Invite your friends and get big discounts",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                AppSpaces.smallSpace(context),
                Text(
                  "Invite your other friends to our platform to get plenty of discounts waiting for you!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                AppSpaces.largeSpace(context),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: elevatedBtnContent(s, context),
                ),
                AppSpaces.mediumSpace(context),
                Text(
                  "Send to",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                AppSpaces.mediumSpace(context),
                OutlinedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: outlinedBtnContent(s, context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // WIDGET: OUTLINED CHILD WIDGET
  Row outlinedBtnContent(Size s, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: s.width * 0.03),
        const Icon(
          Icons.share,
          color: AppColors.primaryColor,
          size: 18,
        ),
        SizedBox(width: s.width * 0.03),
        Text(
          "Send Referral Link",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(width: s.width * 0.03),
      ],
    );
  }

  // WIDGET: ELEVATED CHILD WIDGET
  Row elevatedBtnContent(Size s, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: s.width * 0.03),
        const Icon(
          Icons.copy,
          color: AppColors.whiteColor,
          size: 18,
        ),
        SizedBox(width: s.width * 0.03),
        Text(
          "Copy Referral Link",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(width: s.width * 0.03),
      ],
    );
  }

  // WIDGET: LARGE CIRCLE AVATAR
  CircleAvatar buildLargeCircleAvatar(imgUrl) {
    return CircleAvatar(
      radius: 23,
      backgroundImage: AssetImage(imgUrl),
    );
  }

  // WIDGET: SMALL CIRCLE AVATAR
  CircleAvatar buildSmallCircleAvatar(String imgUrl) {
    return CircleAvatar(
      radius: 17,
      backgroundImage: AssetImage(imgUrl),
    );
  }

  // WIDGET: BANNER
  Widget buildBannerContainer(
      {required BuildContext context,
      required Size s,
      required UserDetails userDetails}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(
              color: Colors.grey,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.red,
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Earnings",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    "\$${userDetails.data!.earnings.toString()}",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              Container(
                height: s.height * 0.15,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  AppAssets.homePicture,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -1.5,
          left: -4,
          child: Container(
            width: s.width * 0.4,
            height: s.height * 0.08,
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage(AppAssets.graph),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Details",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  // WIDGET: HEADER
  Widget homeHeader(BuildContext context, UserDetails userDetails, Size s) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello!",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                  ),
            ),
            Text(
              "${userDetails.data!.firstName!} ${userDetails.data!.lastName!}",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const Spacer(),
        const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          backgroundImage: AssetImage(AppAssets.profileIcon),
        ),
        SizedBox(width: s.width * 0.02),
      ],
    );
  }
}
