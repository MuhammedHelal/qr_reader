import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:qr_reader/core/utils/assets.dart';
import 'package:qr_reader/core/utils/colors.dart';
import 'package:qr_reader/features/generate_qr/presentation/views/generate_qr_view.dart';
import 'package:qr_reader/features/history/presentation/views/history_view.dart';
import 'package:qr_reader/features/scan_qr/manager/scan_qr_cubit/scan_qr_cubit.dart';
import 'package:qr_reader/features/scan_qr/presentation/views/scan_qr_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late final PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      margin: const EdgeInsets.only(left: 43, right: 43, bottom: 33),
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.grey.shade900,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style15,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const GenerateQrView(),
    BlocProvider(
      create: (context) => ScanQrCubit(),
      child: const ScanQrView(),
    ),
    const HistoryView(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.qr_code_2_outlined),
      title: ("Generate"),
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset(Assets.assetsImagesQrReaderIcon),
      inactiveColorPrimary: Colors.white,
      activeColorPrimary: AppColors.primary,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.history),
      title: ("History"),
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: Colors.white,
    ),
  ];
}
