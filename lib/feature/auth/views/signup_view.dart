import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/configures/app_spaces.dart';
import 'package:flutter_task/feature/auth/widgets/consumer_tab.dart';
import 'package:flutter_task/feature/auth/widgets/service_provider_tab.dart';

import '../../../configures/app_colors.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              AppSpaces.smallSpace(context),
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_outlined,
                    ),
                  ),
                  SizedBox(width: s.width * 0.03),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              AppSpaces.mediumSpace(context),
              Container(
                height: s.height * 0.046,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      blurRadius: 4, // Spread radius
                      spreadRadius: 2, // Blur radius
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.textPrimaryColor,
                  splashBorderRadius: BorderRadius.circular(6),
                  tabs: [
                    SizedBox(
                      height: s.height * 0.04,
                      child: const Tab(
                        child: Text(
                          'Consumer',
                          style: TextStyle(
                            fontSize: 13,
                            // color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: s.height * 0.04,
                      child: const Tab(
                        child: Text(
                          'Service Provider',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    const ConsumerTab(),
                    ServiceProviderTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
