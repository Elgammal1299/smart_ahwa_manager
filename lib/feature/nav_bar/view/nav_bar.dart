import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_ahwa_manager/core/utils/app_colors.dart';
import 'package:smart_ahwa_manager/core/utils/app_images.dart';
import 'package:smart_ahwa_manager/core/utils/app_styles.dart';
import 'package:smart_ahwa_manager/feature/home/report_screen.dart';
import 'package:smart_ahwa_manager/feature/home/view/home_screen.dart';
import 'package:smart_ahwa_manager/feature/home/view_model/order_cubit/order_cubit.dart';
import 'package:smart_ahwa_manager/feature/nav_bar/view_model/nav_bar_cubit.dart';
import 'package:smart_ahwa_manager/feature/home/view/order_screen.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: [
              HomeScreen(),
              OrderScreen(),
              ReportsScreen(),

              // ProfileScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: AppColors.secondary,
                  blurRadius: 20,
                  spreadRadius: 0.1,
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedFontSize: 14,
              unselectedFontSize: 14,
              backgroundColor: Colors.white,
              selectedLabelStyle: AppStyles.styleBold16(context),
              unselectedLabelStyle: AppStyles.styleBold16(context),
              currentIndex: state,
              onTap: (value) {
                BlocProvider.of<NavBarCubit>(context).changeTab(value);
              },
              items: [
                _buildBottomNavigationBarItem(
                  'Order',
                  AppImages.homeSelected,
                  AppImages.home,
                ),

                _buildBottomNavigationBarItem(
                  'الحساب',
                  AppImages.chefSelecdted,
                  AppImages.chef,
                ),
                _buildBottomNavigationBarItem(
                  'الحساب',
                  AppImages.coffeSelected,
                  AppImages.coffe,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String title,
    String selectedIcon,
    String unselectedIcon,
  ) {
    return BottomNavigationBarItem(
      activeIcon: Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary,

          borderRadius: BorderRadius.circular(100),
        ),
        child: SvgPicture.asset(selectedIcon, width: 30, height: 30),
      ),
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),

        child: SvgPicture.asset(unselectedIcon, width: 30, height: 30),
      ),
      label: title,
    );
  }
}
