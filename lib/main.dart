import 'package:flutter/material.dart';
import 'package:flutter_task/feature/auth/view_model/auth_model_view.dart';
import 'package:flutter_task/feature/home/view_model/home_view_model.dart';
import 'package:flutter_task/feature/home/views/home_view.dart';
import 'package:flutter_task/utils/widgets/default_nav_bar.dart';
import 'package:provider/provider.dart';
import 'configures/route.dart';
import 'configures/theme.dart';
import 'feature/auth/views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (BuildContext context) => AuthViewModel(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => HomeViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
