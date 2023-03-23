import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_changer/core/extensions/date_extensions.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors/colors.dart';
import '../../../../constants/consts/consts.dart';
import '../../../../constants/icons/app_icons.dart';
import '../../../../constants/text_styles/text_styles.dart';
import '../../../../core/utility/custom_validator.dart';
import '../../../../core/utility/utility.dart';
import '../../../../routes/routes_provider.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_progress_indicator.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../games_screen/business_logic/games_screen_provider.dart';
import '../../business_logic/add_game_screen_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key, this.game});

  final GameEntity? game;

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _maxCountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  double? addressLat;
  double? addressLong;
  String? encodedImage;

  @override
  void initState() {
    if (widget.game != null) {
      _titleController.text = widget.game!.title;
      _descriptionController.text = widget.game!.description ?? '';
      _maxCountController.text = widget.game!.maxCount.toString();
      _addressController.text = widget.game!.address ?? '';
      _dateController.text = widget.game!.date;
      if (widget.game!.latitude != null && widget.game!.longitude != null) {
        addressLat = double.parse(widget.game!.latitude!);
        addressLong = double.parse(widget.game!.longitude!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            RoutingProvider.goBack();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.blackColor,
                          )),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            RoutingProvider.goBack();
                          },
                          child: Text(
                            trans.cancel,
                            style: AppTextStyles.nunitoBold(
                                color: AppColors.blueColor, fontSize: 14),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    widget.game != null ? trans.edit_game : trans.create_game,
                    style: AppTextStyles.nunitoBold(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Consumer<AddGameScreenProvider>(
                          builder: (context, provider, _) {
                        return GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            // Pick an image
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              var imageBytes = await image.readAsBytes();
                              encodedImage = base64Encode(imageBytes);
                              provider.updateUI();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            width: 100.r,
                            height: 100.r,
                            child: widget.game?.image != null ||
                                    encodedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(6.r),
                                    child: Image.memory(
                                      base64Decode(widget.game?.image != null
                                          ? widget.game!.image!
                                          : encodedImage!),
                                      width: 100.r,
                                      height: 100.r,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.attachment_outlined,
                                      color: AppColors.blackColor,
                                      size: 30.r,
                                    ),
                                  ),
                          ),
                        );
                      }),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trans.attach_image,
                            style: AppTextStyles.nunitoBold(fontSize: 14),
                          ),
                          Text(
                            trans.supported_formats,
                            style: AppTextStyles.nunitoRegular(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.tagIcon),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        trans.title,
                        style: AppTextStyles.nunitoRegular(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomTextField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    onValid: (value) => CustomValidator.isRequired(value),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.descriptionIcon),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        trans.description,
                        style: AppTextStyles.nunitoRegular(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomTextField(
                    controller: _descriptionController,
                    textInputAction: TextInputAction.next,
                    minLines: 5,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.numbers,
                                size: 20.r,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                trans.number_players,
                                style: AppTextStyles.nunitoRegular(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomTextField(
                            controller: _maxCountController,
                            textInputAction: TextInputAction.next,
                            width: 170.w,
                            textType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onValid: (value) =>
                                CustomValidator.isRequired(value),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppIcons.dateIcon),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                trans.date,
                                style: AppTextStyles.nunitoRegular(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomTextField(
                            enableField: false,
                            width: 170.w,
                            controller: _dateController,
                            textInputAction: TextInputAction.next,
                            onValid: (value) =>
                                CustomValidator.isRequired(value),
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 30)));

                              if (date != null) {
                                // ignore: use_build_context_synchronously
                                TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (time != null) {
                                  date = DateTime(date.year, date.month,
                                      date.day, time.hour, time.minute);
                                  _dateController.text = date.ddMMyyyyhhmm();
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        size: 20.r,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        trans.address,
                        style: AppTextStyles.nunitoRegular(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomTextField(
                    controller: _addressController,
                    textInputAction: TextInputAction.next,
                    enableField: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            apiKey: Consts.mapKey,
                            onPlacePicked: (result) {
                              _addressController.text =
                                  result.formattedAddress!;
                              addressLat = result.geometry!.location.lat;
                              addressLong = result.geometry!.location.lng;
                              RoutingProvider.goBack();
                            },
                            initialPosition: LatLng(
                                addressLat ?? 25.2048, addressLong ?? 55.2708),
                            useCurrentLocation: true,
                            resizeToAvoidBottomInset: false,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Consumer<AddGameScreenProvider>(
                      builder: (context, provider, _) {
                    var gamesProvider = Provider.of<GamesScreenProvider>(
                        context,
                        listen: false);
                    return CustomButton(
                        buttonContent: provider.isLoading
                            ? const CustomProgressIndicator(
                                color: AppColors.blueColor)
                            : Text(
                                widget.game != null
                                    ? trans.edit_game
                                    : trans.save_and_create,
                                style: AppTextStyles.nunitoBold(
                                    color: AppColors.blueColor),
                              ),
                        onPressed: provider.isLoading
                            ? () {}
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  bool success = await provider.addGame(
                                    model: GameEntity(
                                      id: widget.game != null
                                          ? widget.game!.id
                                          : Random().nextInt(1000000),
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      date: _dateController.text,
                                      maxCount:
                                          int.parse(_maxCountController.text),
                                      address: _addressController.text,
                                      image: encodedImage,
                                      latitude: addressLat?.toString(),
                                      longitude: addressLong?.toString(),
                                    ),
                                  );
                                  if (success) {
                                    Utility.showToast(
                                        message: widget.game != null
                                            ? trans.game_updated
                                            : trans.game_created);
                                    RoutingProvider.goBack();
                                    gamesProvider.getGames();
                                  }
                                }
                              });
                  }),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _maxCountController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
