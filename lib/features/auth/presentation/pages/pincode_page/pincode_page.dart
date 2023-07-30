import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/hive/hive_helper.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../../seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../../../../seller_pages/listining_seller/domain/usecases/create_listings_usecase.dart';
import '../../../data/models/add_probalty_model.dart';
import '../../../data/models/update_location_model.dart';
import '../../../domain/usecases/send_otp_phone_usecase.dart';
import '../../../domain/usecases/update_location_usecase.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import '../../cubit/add_property/add_property_cubit.dart';
import '../../cubit/pincode_cubit/pincode_cubit.dart';
import '../../cubit/update_location/update_location_cubit.dart';
import '../../cubit/verfiy_phone_cubit/verfiy_phone_cubit.dart';
import '../payment_pages/dialog_sucess_payment_page.dart';

class PinCodePage extends StatefulWidget {
  PinCodePage(
      {super.key,
      required this.number,
      required this.mobileCounteryId,
      this.isLogin = false,
      this.modeUser});
  final String number;
  final String mobileCounteryId;
  final bool isLogin;
  final String? modeUser;

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  int secondsRemaining = 120;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // log("Build Completed");
    // context.read<PinCodeCubit>().fGetOtp(context: context);
    // });
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 120;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController verFicationCode = TextEditingController();
  Map<String, dynamic> creatListingsModel = {};

  @override
  Widget build(BuildContext context) {
    int minutes = (secondsRemaining ~/ 60) % 60;
    int seconds = secondsRemaining % 60;

    return MultiBlocProvider(
      providers: [
        BlocProvider<PincodeCubit>(
            create: (BuildContext context) => sl<PincodeCubit>()),
        BlocProvider<VerfiyPhoneCubit>(
            create: (BuildContext context) => sl<VerfiyPhoneCubit>()),
        // BlocProvider<AddListingsCubit>(
        //     create: (BuildContext context) => sl<AddListingsCubit>()),
      ],

      // create: (context) => sl<PincodeCubit>(),
      child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
              appBar: AppBarGeneric(isback: true),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.tr("phone_verfication"),
                            style: TextStyles.textViewSemiBold16
                                .copyWith(color: textColor),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RichText(
                            text: TextSpan(
                                text: tr.tr("a_4_digits_verfication_code"),
                                style: TextStyles.textViewMedium15.copyWith(
                                  color: textColorLight,
                                  fontFamily: Localizations.localeOf(context)
                                              .languageCode ==
                                          "en"
                                      ? "Montserrat"
                                      : "Almarai",
                                ),
                                children: [
                                  TextSpan(
                                    text: "${widget.number}",
                                    style: TextStyles.textViewBold14
                                        .copyWith(color: textColor),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              length: 4,
                              appContext: context,
                              // controller: _pincodeController,
                              animationType: AnimationType.fade,
                              keyboardType: TextInputType.phone,
                              inputFormatters: const [
                                // FilteringTextInputFormatter.digitsOnly
                              ],
                              enableActiveFill: true,
                              cursorColor: focus,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                fieldHeight: 72.h,
                                fieldWidth: 75.w,
                                activeColor: transparentColor,
                                disabledColor: transparentColor,
                                selectedColor: focus,
                                selectedFillColor: white,
                                activeFillColor: gray3,
                                inactiveColor: transparentColor,
                                borderRadius: BorderRadius.circular(10),
                                inactiveFillColor: gray3,
                              ),

                              textInputAction: TextInputAction.done,
                              pastedTextStyle: const TextStyle(
                                color: focus,
                                fontWeight: FontWeight.bold,
                              ),
                              textStyle: TextStyles.textViewSemiBold16
                                  .copyWith(color: textColor),
                              controller: verFicationCode,

                              onChanged: (String value) {},
                              onCompleted: (value) {
                                // log(verFicationCode.text);
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Pin Code";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: Text(
                              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                              style: TextStyles.textViewMedium16,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr.tr("didint_recive_code"),
                                style: TextStyles.textViewMedium16
                                    .copyWith(color: black1),
                              ),
                              const SizedBox(width: 5),
                              BlocConsumer<VerfiyPhoneCubit, VerfiyPhoneState>(
                                listener: (context, state) {
                                  if (state is SendOtpPhoneSuccess) {
                                    customToast(
                                        backgroundColor: Colors.green,
                                        textColor: white,
                                        content: state.sendOtpModel.message);
                                  }
                                },
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: enableResend
                                        ? () {
                                            context
                                                .read<VerfiyPhoneCubit>()
                                                .fSendOtpPhone(
                                                    sendOtpParams: SendOtpParams(
                                                        mobileConteryId: widget
                                                            .mobileCounteryId,
                                                        mobileNumber:
                                                            widget.number));
                                            _resendCode();
                                          }
                                        : null,
                                    child: Text(
                                      tr.tr("resend"),
                                      style: TextStyles
                                          .textViewMedium15Underline
                                          .copyWith(
                                              color:
                                                  enableResend ? focus : gray),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          BlocConsumer<PincodeCubit, PincodeState>(
                            listener: (context, state) async {
                              if (state is VerfyOtpError) {
                                customToast(
                                    backgroundColor: red,
                                    textColor: white,
                                    content: state.errorMessage);
                              }
                              if (state is VerfyOtpSuccess) {
                                BlocProvider.of<BlocMainCubit>(context,
                                        listen: false)
                                    .verfied();
                                if (widget.isLogin == true) {
                                  widget.modeUser == "seller"
                                      ? sl<AppNavigator>()
                                          .pushToFirst(screen: HomeMainSeller())
                                      : sl<AppNavigator>()
                                          .pushToFirst(screen: HomeMainBuyer());
                                } else if (widget.modeUser == "buyer") {
                                  var data = await HiveHelper.getFromBox(
                                      boxName: BoxNames.updateLocation,
                                      key: 'update_location');
                                  // final prefs =
                                  //     await SharedPreferences.getInstance();
                                  // final jsonData = prefs
                                  //         .containsKey("update_location")
                                  // ? jsonDecode(
                                  //     prefs.getString('update_location') ??
                                  //         '')
                                  // : "";
                                  if (data != null) {
                                    final jsonData = jsonDecode(data ?? '{}');

                                    UpdateLocationModel map =
                                        UpdateLocationModel.fromJson(jsonData);
                                    context
                                        .read<UpdateLocationCubit>()
                                        .fUpdateLocation(
                                            updateLocationParams:
                                                UpdateLocationParams(
                                                    countery: map.country,
                                                    city: map.city,
                                                    state: map.state,
                                                    lang: map.longitude,
                                                    lat: map.latitude));
                                    context
                                        .read<BlocMainCubit>()
                                        .updateLocation(
                                            location:
                                                "${map.country},${map.city}",
                                            lat: map.latitude,
                                            lang: map.longitude);

                                    HiveHelper.deleteFromBox(
                                        boxName: BoxNames.updateLocation,
                                        key: 'update_location');
                                  }
                                  // prefs.remove("update_location");
                                  await sl<AppNavigator>()
                                      .pushToFirst(screen: HomeMainBuyer());
                                } else {
                                  var data = await HiveHelper.getFromBox(
                                      boxName: BoxNames.addProperty,
                                      key: 'add_property');

                                  // final prefs =
                                  //     await SharedPreferences.getInstance();
                                  if (data != null) {
                                    final jsonData = jsonDecode(data ?? '{}');

                                    AddPropartyModel map =
                                        AddPropartyModel.fromJson(jsonData);

                                    await context
                                        .read<PincodeCubit>()
                                        .fCreateListings(
                                            createListingParms:
                                                CreateListingParms(
                                          creatListingsModel: map.toJsonApi(),
                                        ));
                                    log(context
                                        .read<PincodeCubit>()
                                        .listingIdValue
                                        .toString());

                                    context
                                        .read<AddPropertyCubit>()
                                        .removeAllField();
                                    HiveHelper.deleteFromBox(
                                        boxName: BoxNames.addProperty,
                                        key: 'add_property');
                                    // if (state is SucessAddProparty) {
                                    await sl<AppNavigator>().pushToFirst(
                                        screen: DialogSucessPaymentPage(
                                      listingId: context
                                          .read<PincodeCubit>()
                                          .listingIdValue!,
                                      goto: "pay",
                                      isAgentFirst: true,
                                    ));
                                  } else {
                                    sl<AppNavigator>()
                                        .pushToFirst(screen: HomeMainSeller());
                                  }

                                  // }
                                }
                              }
                            },
                            builder: (context, state) {
                              if (state is VerfyOtpLoading) {
                                return const Center(
                                  child: Center(
                                    child: Loading(),
                                  ),
                                );
                              }
                              return GenericButton(
                                onPressed: () async {
                                  if (verFicationCode.text.isEmpty) {
                                    customToast(
                                        backgroundColor: red,
                                        textColor: white,
                                        content: "Enter Otp");
                                  } else {
                                    context.read<PincodeCubit>().fVerfiyOtp(
                                        verifyOtpParams: VerifyOtpParams(
                                            mobileConteryId:
                                                widget.mobileCounteryId,
                                            mobileNumber: widget.number,
                                            otp: verFicationCode.text));
                                  }

                                  // sl<AppNavigator>()
                                  //     .push(screen: VerfiyPhoneNumberPage());
                                  // sl<AppNavigator>()
                                  //     .push(screen: DialogSucessPaymentPage());
                                },
                                child: Text(
                                  tr.tr("verify"),
                                  style: TextStyles.textViewMedium15
                                      .copyWith(color: white),
                                ),
                                color: primary,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(15.r),
                              );
                            },
                          ),
                        ]),
                  ),
                ),
              ))),
    );
  }
}

// getSP() async {
//   final prefs = await SharedPreferences.getInstance();
//   final jsonData = jsonDecode(prefs.getString('add_property') ?? '{}');

//   AddPropartyModel map = AddPropartyModel.fromJson(jsonData);
//   log(map.toString());
//   return map;
// }
