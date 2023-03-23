import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_changer/modules/games_screen/presentation/UI/games_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../constants/colors/colors.dart';
import '../../../../constants/icons/app_icons.dart';
import '../../../../constants/text_styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true, padding: const NavBarPadding.all(10),
        navBarHeight: 60,
        backgroundColor: AppColors.whiteColor, 
        handleAndroidBackButtonPress: true, 
        resizeToAvoidBottomInset:
            true, 
        stateManagement: false,
        hideNavigationBarWhenKeyboardShows:
            true, 
        decoration: NavBarDecoration(
            colorBehindNavBar: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                spreadRadius: 3,
                blurRadius: 1,
              )
            ]),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style7, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const GamesScreen(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    var trans = AppLocalizations.of(context)!;
    return [
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppIcons.tasksIconBottom,
            color: AppColors.whiteColor,
          ),
          inactiveIcon: SvgPicture.asset(
            AppIcons.tasksIconBottom,
            color: CupertinoColors.systemGrey,
          ),
          title: trans.your_games,
          textStyle: AppTextStyles.nunitoRegular(),
          activeColorPrimary: AppColors.blueColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.whiteColor),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppIcons.historyIconBottom,
            color: AppColors.whiteColor,
          ),
          inactiveIcon: SvgPicture.asset(
            AppIcons.historyIconBottom,
          ),
          title:trans.history,
          textStyle: AppTextStyles.nunitoRegular(),
          activeColorPrimary: AppColors.blueColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.whiteColor),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppIcons.searchIconBottom,
            color: AppColors.whiteColor,
          ),
          inactiveIcon: SvgPicture.asset(
            AppIcons.searchIconBottom,
          ),
          title: trans.search,
          textStyle: AppTextStyles.nunitoRegular(),
          activeColorPrimary: AppColors.blueColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.whiteColor),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppIcons.notificationIconBottom,
            color: AppColors.whiteColor,
          ),
          inactiveIcon: SvgPicture.asset(
            AppIcons.notificationIconBottom,
          ),
          title: trans.notifications,
          textStyle: AppTextStyles.nunitoRegular(),
          activeColorPrimary: AppColors.blueColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.whiteColor),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppIcons.userIconBottom,
            color: AppColors.whiteColor,
          ),
          inactiveIcon: SvgPicture.asset(
            AppIcons.userIconBottom,
          ),
          title: trans.profile,
          textStyle: AppTextStyles.nunitoRegular(),
          activeColorPrimary: AppColors.blueColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: AppColors.whiteColor),
    ];
  }
}
