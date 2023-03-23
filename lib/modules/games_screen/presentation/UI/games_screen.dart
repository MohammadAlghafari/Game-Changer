import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_changer/modules/games_screen/presentation/UI/widgets/end_drawer.dart';
import 'package:game_changer/modules/games_screen/presentation/UI/widgets/game_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors/colors.dart';
import '../../../../constants/icons/app_icons.dart';
import '../../../../constants/images/app_images.dart';
import '../../../../constants/text_styles/text_styles.dart';
import '../../../../routes/routes_names.dart';
import '../../../../routes/routes_provider.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_progress_indicator.dart';
import '../../business_logic/games_screen_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GamesScreenProvider>(context, listen: false).getGames();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    var trans = AppLocalizations.of(context)!;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[50],
      endDrawer: const EndDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.userImage,
                      width: 52.r,
                      height: 52.r,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text('${trans.hello} Syria!',
                        style: AppTextStyles.nunitoBold()),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: SvgPicture.asset(
                        AppIcons.filterIcon,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(trans.games_board, style: AppTextStyles.nunitoBold()),
                Text(trans.create_games_and_share,
                    style: AppTextStyles.nunitoRegular()),
                SizedBox(
                  height: 17.h,
                ),
                CustomButton(
                    height: 35,
                    buttonContent: Text(
                      trans.create_game_plus,
                      style: AppTextStyles.nunitoRegular(
                          color: AppColors.blueColor),
                    ),
                    onPressed: () {
                      RoutingProvider.pushNamed(
                          routeName: Routes.addGameScreen);
                    }),
                SizedBox(
                  height: 25.h,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 30.w),
            child: SizedBox(
              height: 500.h,
              child: Consumer<GamesScreenProvider>(
                  builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const CustomProgressIndicator(
                      color: AppColors.blueColor);
                } else if (provider.games.isNotEmpty) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                    itemBuilder: (context, index) =>
                        GameItemWidget(game: provider.games[index]),
                    itemCount: provider.games.length,
                  );
                } else if (provider.games.isEmpty) {
                  return Center(
                    child: Text(
                      trans.no_games_created,
                      style: AppTextStyles.nunitoBold(
                          fontSize: 20, color: AppColors.blueColor),
                    ),
                  );
                } else if (provider.isError) {
                  return Center(
                    child: Text(
                      trans.something_went_wrong,
                      style: AppTextStyles.nunitoBold(
                          fontSize: 20, color: AppColors.blueColor),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
