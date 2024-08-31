import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configures/app_colors.dart';
import '../../configures/app_spaces.dart';
import '../assets.dart';

class ReUseAbleSocialContent extends StatelessWidget {
  const ReUseAbleSocialContent({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.textFieldHintColor,
                thickness: 0.8,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              "or continue with",
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            const SizedBox(width: 8.0),
            const Expanded(
              child: Divider(
                color: AppColors.textFieldHintColor,
                thickness: 0.8,
              ),
            ),
          ],
        ),
        AppSpaces.largeSpace(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildSocialContainer(s, AppAssets.facebookIcon),
            buildSocialContainer(s, AppAssets.googleIcon),
          ],
        ),
      ],
    );
  }

  Container buildSocialContainer(Size s, String iconUrl) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: s.width * 0.13,
        vertical: s.height * 0.025,
      ),
      decoration: BoxDecoration(
        color: AppColors.textFieldColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SvgPicture.asset(
        iconUrl,
        width: 24,
        height: 24,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
