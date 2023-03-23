import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_changer/core/utility/utility.dart';
import 'package:game_changer/modules/custom_widgets/custom_text_field.dart';
import 'package:game_changer/modules/games_screen/business_logic/games_screen_provider.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors/colors.dart';
import '../../../../../constants/text_styles/text_styles.dart';
import '../../../../../routes/routes_names.dart';
import '../../../../../routes/routes_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameItemWidget extends StatelessWidget {
  const GameItemWidget({super.key, required this.game});
  final GameEntity game;
  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        RoutingProvider.pushNamed(
            routeName: Routes.addGameScreen, arguments: game);
      },
      child: Dismissible(
        key: Key(game.id.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: AppColors.redColor,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 50.w,
              ),
              const Icon(
                Icons.delete,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  trans.confirm,
                  style: AppTextStyles.nunitoBold(),
                ),
                content: Text(
                  trans.confirm_delete,
                  style: AppTextStyles.nunitoRegular(),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () => RoutingProvider.goBack(),
                    child: Text(
                      trans.cancel,
                      style: AppTextStyles.nunitoRegular(
                          color: AppColors.whiteColor),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<GamesScreenProvider>(context, listen: false)
                            .deleteGame(game.id);
                        RoutingProvider.goBack();
                      },
                      child: Text(
                        trans.delete,
                        style: AppTextStyles.nunitoRegular(
                            color: AppColors.whiteColor),
                      )),
                ],
              );
            },
          );
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (game.image != null)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      width: 100.r,
                      height: 100.r,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Image.memory(
                          base64Decode(game.image!),
                          width: 100.r,
                          height: 100.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (game.image != null)
                    SizedBox(
                      width: 15.w,
                    ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.title,
                          style: AppTextStyles.nunitoBold(),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '${game.maxCount} ${trans.players}',
                          style: AppTextStyles.nunitoRegular(fontSize: 12),
                        ),
                        Text(
                          '${trans.date_} ${game.date}',
                          style: AppTextStyles.nunitoRegular(fontSize: 12),
                        ),
                        if (game.address != null && game.address!.isNotEmpty)
                          Text(
                            '${trans.address_} ${game.address!}',
                            style: AppTextStyles.nunitoRegular(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
                end: 0.w,
                top: 0.h,
                child: GestureDetector(
                  onTap: () async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextEditingController numberController =
                            TextEditingController();
                        return AlertDialog(
                          title: Text(
                            trans.confirm,
                            style: AppTextStyles.nunitoBold(),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                trans.enter_friend_number,
                                style: AppTextStyles.nunitoRegular(),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextField(
                                controller: numberController,
                                textType: TextInputType.phone,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                RoutingProvider.goBack();
                              },
                              child: Text(
                                trans.cancel,
                                style: AppTextStyles.nunitoRegular(
                                    color: AppColors.whiteColor),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  String message =
                                      'I would like to invite you to my game\nPlease join\n${game.title}\n${game.description}\n${game.maxCount} ${trans.players}\n${trans.date_} ${game.date}\n${trans.address_} ${game.address}\nhttp://www.google.com/maps/place/${game.latitude},${game.latitude}';
                                  bool success =
                                      await Provider.of<GamesScreenProvider>(
                                              context,
                                              listen: false)
                                          .sendMessage(
                                              numberController.text, message);
                                  if (success) {
                                    Utility.showToast(
                                        message: trans.messsage_sent);
                                  } else {
                                    Utility.showToast(
                                        message: trans.message_not_sent);
                                  }
                                  RoutingProvider.goBack();
                                },
                                child: Text(
                                  trans.send,
                                  style: AppTextStyles.nunitoRegular(
                                      color: AppColors.whiteColor),
                                )),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(6.r)),
                    child: Icon(
                      Icons.share,
                      color: AppColors.blackColor,
                      size: 20.r,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
