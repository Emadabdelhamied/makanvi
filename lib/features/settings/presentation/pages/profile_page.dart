import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/end_points.dart';
import '../../../../core/util/navigator.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/appbar_generic.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/generic_field.dart';
import '../../../../core/widgets/get_image.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../cubit/profile_cubit/profile_cubit.dart';
import '../cubit/update_profile/update_profile_cubit.dart';
import '../widgets/shimmer/profile_shimmer.dart';
import 'change_phone/change_phone.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? specialiValue;
  int? titleValue;
  int? cityValue;
  TextEditingController name = TextEditingController();
  TextEditingController agancyName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var maibCubit = context.read<BlocMainCubit>().repository.loadAppData()!;
    name.text = maibCubit.displayName.toString();
    // agancyName.text=maibCubit.displayName.toString();
    email.text = maibCubit.email.toString();
    phone.text = maibCubit.phone.toString();
  }

  String? image;
  String? accountMode;
  String? accountType;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var maibCubit = context.read<BlocMainCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
            create: (BuildContext context) =>
                sl<ProfileCubit>()..fGetProfile()),
        BlocProvider<UpdateProfileCubit>(
            create: (BuildContext context) => sl<UpdateProfileCubit>()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            appBar: AppBarGeneric(
              title: tr("edit_profile"),
              titleColor: textColor,
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ProfileLoadingState) {
                        return const MyAccountShimmer();
                      } else if (state is ProfileLoadedState) {
                        image = state.user.profile.profilePhotoPath ?? "";
                        accountMode = state.user.profile.accountMode;
                        accountType = state.user.profile.accountType;
                        agancyName.text =
                            state.user.profile.agencyName ?? "".toString();
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(children: [
                              // BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                              //   builder: (context, state) {
                              //     return
                              BlocConsumer<UpdateProfileCubit,
                                  UpdateProfileState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  return Stack(
                                    fit: StackFit.loose,
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Material(
                                        elevation: 3,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  Color(0xffF5F4F8),
                                              radius: 50,
                                              child: context
                                                          .read<
                                                              UpdateProfileCubit>()
                                                          .avatar !=
                                                      null
                                                  ? CircleAvatar(
                                                      radius: 50,
                                                      backgroundColor:
                                                          transparent,
                                                      backgroundImage:
                                                          FileImage(context
                                                              .read<
                                                                  UpdateProfileCubit>()
                                                              .avatar!),
                                                    )
                                                  : image!.isNotEmpty
                                                      ? CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor:
                                                              Color(0xffF5F4F8),
                                                          backgroundImage:
                                                              NetworkImage(!image!
                                                                      .contains(
                                                                          "http")
                                                                  ? EndPoints
                                                                          .baseImages +
                                                                      image!
                                                                  : image!),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Color(0xffF5F4F8),
                                                          backgroundImage:
                                                              AssetImage(
                                                                  personAvatar),
                                                        )),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              elevation: 3,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )),
                                              context: context,
                                              builder: (_) {
                                                return GetImageFromCameraAndGellary(
                                                    onPickImage: (img) {
                                                  // context
                                                  //     .read<
                                                  //         UpdateProfileCubit>()
                                                  //     .setAvatar = img;
                                                });
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: textColor),
                                            child: Center(
                                                child: SvgPicture.asset(
                                                    pencilIconsSvg)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              // },
                              // ),
                              SizedBox(
                                height: 30.h,
                              ),

                              GenericField(
                                labeltext: tr("full_name"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: state.user.profile.name,
                                horizontal: 15,
                                hintColor: textColor,
                                controller: name,
                                validation: (value) =>
                                    Validator.name(name.text),
                              ),
                              (accountMode == "seller" &&
                                      accountType == "agency")
                                  ? SizedBox(
                                      height: 15.h,
                                    )
                                  : SizedBox(),

                              (accountMode == "seller" &&
                                      accountType == "agency")
                                  ? GenericField(
                                      labeltext: tr("agancy_name"),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      hintText:
                                          state.user.profile.agencyName ?? "",
                                      horizontal: 15,
                                      hintColor: textColor,
                                      controller: agancyName,
                                      validation: (accountMode == "seller" &&
                                              accountType == "agency")
                                          ? (value) =>
                                              Validator.defaultValidator(
                                                  agancyName.text)
                                          : null,
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 15.h,
                              ),
                              GenericField(
                                labeltext: tr("email_address"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: state.user.profile.email,
                                horizontal: 15,
                                hintColor: textColor,
                                controller: email,
                                validation: (value) =>
                                    Validator.email(email.text),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              GenericField(
                                labeltext: tr("phone_number"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: state.user.profile.mobileNumber,
                                horizontal: 15,
                                hintColor: textColor,
                                // controller: phone,
                                isEnable: false,
                              ),

                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                    onPressed: () {
                                      sl<AppNavigator>().push(
                                          screen: ChangePhoneNumberScreen());
                                    },
                                    child: Text(
                                      tr("change_phone_number"),
                                      style: TextStyles
                                          .textViewSemiBoldUnderlined14,
                                    )),
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                              BlocConsumer<UpdateProfileCubit,
                                  UpdateProfileState>(
                                listener: (context, state) async {
                                  if (state is UpdateProfileLoadedState) {
                                    maibCubit.updateData(state.appData);
                                    customToast(
                                        backgroundColor: Colors.green.shade400,
                                        textColor: white,
                                        content:
                                            'User profile updated successfully');
                                    await sl<AppNavigator>().pop();
                                  }
                                  if (state is UpdateProfileErrorState) {
                                    customToast(
                                        backgroundColor: Colors.red.shade300,
                                        textColor: white,
                                        content: state.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is UpdateProfileLoadingState) {
                                    return Center(
                                      child: Loading(),
                                    );
                                  } else {
                                    return GenericButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<UpdateProfileCubit>()
                                              .fUpdateProfile(
                                                  params: ProfileParams(
                                                      image: context
                                                          .read<
                                                              UpdateProfileCubit>()
                                                          .avatar,
                                                      name: name.text,
                                                      email: email.text,
                                                      agencyName: (accountMode ==
                                                                  "seller" &&
                                                              accountType ==
                                                                  "agency")
                                                          ? agancyName.text
                                                          : null));
                                        }
                                      },
                                      child: Text(
                                        tr("save_changes"),
                                        style: TextStyles.textViewSemiBold16
                                            .copyWith(color: white),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                      color: primary,
                                      width: 336.w,
                                    );
                                  }
                                },
                              )
                              // Spacer(),
                            ]),
                          ),
                        );
                      } else {
                        return ErrorScreen();
                      }
                    },
                  ),
                ]),
              ),
            )),
      ),
    );
  }
}
