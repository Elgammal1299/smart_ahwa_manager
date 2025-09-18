import 'package:flutter/material.dart';
import 'package:smart_ahwa_manager/core/router/app_routes.dart';
import 'package:smart_ahwa_manager/core/router/route.dart';

void main() {
  runApp(const SmartAhwaManager());
}

class SmartAhwaManager extends StatelessWidget {
  const SmartAhwaManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ahwa Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splasahRouter,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
