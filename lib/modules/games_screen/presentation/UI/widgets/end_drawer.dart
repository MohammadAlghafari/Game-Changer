import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_changer/constants/colors/colors.dart';
import 'package:game_changer/constants/text_styles/text_styles.dart';
import 'package:game_changer/modules/games_screen/business_logic/games_screen_provider.dart';
import 'package:game_changer/modules/settings/business_logic/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Consumer<SettingsProvider>(builder: (context, provider, _) {
              return GestureDetector(
                onTap: () {
                  bool language =
                      provider.setting.mobileLanguage.languageCode == 'en';
                  provider.changeLanguage(language ? 'ar' : 'en');
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 9.w,
                    ),
                    Icon(
                      Icons.language,
                      color: AppColors.blueColor,
                      size: 30.r,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      provider.setting.mobileLanguage.languageCode == 'en'
                          ? 'العربية'
                          : 'English',
                      style: AppTextStyles.nunitoBold(),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Consumer<GamesScreenProvider>(builder: (context, provider, _) {
              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: provider.sortByTitle,
                          onChanged: (value) {
                            if (value!) {
                              provider.sortGamesByTitle();
                            }
                          }),
                      Text(
                        trans.sort_by_title,
                        style: AppTextStyles.nunitoRegular(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: provider.sortByDate,
                          onChanged: (value) {
                            if (value!) {
                              provider.sortGamesByDate();
                            }
                          }),
                      Text(
                        trans.sort_by_date,
                        style: AppTextStyles.nunitoRegular(),
                      ),
                    ],
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
