import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makanvi_web/core/custom_network.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../favourite/presentation/widgets/favourite_icon.dart';
import '../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../home_seller/presentation/pages/home_main_seller.dart';
import '../../../payment/presentation/pages/plan_payment_page.dart';
import '../../data/models/my_listings_all_model.dart';
import '../../domain/usecases/direct_upgrade_usecase.dart';
import '../cubit/direct_upgrade/direct_upgrade_cubit.dart';
import '../cubit/edit_property_cubit/edit_property_cubit.dart';
import '../cubit/get_listing_cubit/get_listing_cubit.dart';
import '../pages/edit_property/edit_property.dart';
import '../pages/property_details.dart';
import 'dialog_close.dart';
import 'dialog_feature.dart';

class CardListing extends StatelessWidget {
  CardListing(
      {super.key,
      required this.listiningTest,
      this.subscriptions,
      this.isSearch = false});
  final Active listiningTest;
  final bool isSearch;
  Subscriptions? subscriptions;
  String stutas(String stutas) {
    switch (stutas) {
      case "active":
        return tr("active");
      case "pending":
        return tr("pending");
      case "expired":
        return tr("expire");
      case "draft":
        return tr("draft");
      case "closed":
        return tr("closed");
      // etc.
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sl<AppNavigator>().push(
            screen: PropertyDetails(
          listingId: listiningTest.id.toString(),
        ));
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          height: isSearch ? 130.h : 160.h,
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.w),
                      child: listiningTest.coverImage.isEmpty
                          ? Container(
                              height: 120.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          prpoertyPlaceholderImage))),
                            )
                          : CustomImageWidgegt(
                              image: EndPoints.baseImages +
                                  listiningTest.coverImage,
                              height: 120.h,
                              width: 140.w,
                            ),
                    ),
                    isSearch
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: FavoriteIcon(
                                  id: listiningTest.id,
                                  isFavorite: listiningTest.isFav,
                                )),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      isSearch
                          ? SizedBox()
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Container(
                                    height: 18.h,
                                    width: 61.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xff3F467C).withOpacity(0.69),
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: listiningTest.status ==
                                                  "pending"
                                              ? yellow
                                              : (listiningTest.status ==
                                                          "active" ||
                                                      listiningTest.status ==
                                                          "featured")
                                                  ? green
                                                  : listiningTest.status ==
                                                          "draft"
                                                      ? Color(0xffCFD3D4)
                                                      : primary,
                                          size: 10,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                          listiningTest.status == "featured"
                                              ? tr("active")
                                              : stutas(listiningTest.status),
                                          style: TextStyles.textViewMedium8
                                              .copyWith(color: white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                // TODO------------------------>
                                (listiningTest.status == "expired" ||
                                        listiningTest.status == "closed")
                                    ? Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                context
                                                    .read<EditPropertyCubit>()
                                                    .fGetDataEditPropertyModel();
                                                context
                                                    .read<EditPropertyCubit>()
                                                    .emptyCubitData();

                                                sl<AppNavigator>().push(
                                                    screen: EditPropertyScreen(
                                                        listingId: listiningTest
                                                            .id
                                                            .toString()));
                                              },
                                              child: SizedBox(
                                                //  color: red,
                                                width: 30.w,
                                                height: 20.h,
                                                child: SvgPicture.asset(
                                                    editeIconsSvg),
                                              )),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          MultiBlocProvider(
                                            providers: [
                                              BlocProvider(
                                                create: (context) =>
                                                    sl<DirectUpgradeCubit>(),
                                              ),
                                              BlocProvider(
                                                create: (context) =>
                                                    sl<GetListingCubit>(),
                                              ),
                                            ],
                                            child: BlocConsumer<
                                                DirectUpgradeCubit,
                                                DirectUpgradeState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DirectUpgradeSuccessState) {
                                                  customToast(
                                                      backgroundColor:
                                                          Colors.green,
                                                      textColor: white,
                                                      content: state.message);
                                                  context
                                                      .read<HomeSellerCubit>()
                                                      .setcurrentIndexSellerHome = 1;
                                                  sl<AppNavigator>()
                                                      .pushToFirst(
                                                          screen:
                                                              HomeMainSeller());
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is DirectUpgradeLoadingState) {
                                                  return SizedBox(
                                                    height: 15.h,
                                                    width: 15.w,
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: primary),
                                                  );
                                                } else {
                                                  return InkWell(
                                                      onTap: () {
                                                        if ((subscriptions!
                                                                    .listing
                                                                    .consume <
                                                                subscriptions!
                                                                    .listing
                                                                    .listingCount) &&
                                                            subscriptions!
                                                                    .listing
                                                                    .expireAfter !=
                                                                0) {
                                                          context.read<DirectUpgradeCubit>().fDirectUpgrading(
                                                              directUpgradeParams: DirectUpgradeParams(
                                                                  listingId:
                                                                      listiningTest
                                                                          .id
                                                                          .toString(),
                                                                  packageId:
                                                                      subscriptions!
                                                                          .listing
                                                                          .id
                                                                          .toString()));
                                                        } else {
                                                          sl<AppNavigator>()
                                                              .push(
                                                                  screen:
                                                                      PalnPaymentPage(
                                                            listingId:
                                                                listiningTest
                                                                    .id,
                                                            purpose:
                                                                subscriptions!
                                                                    .listing
                                                                    .purpose,
                                                            target: "owner",
                                                          ));
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                          reloadIconsSvg));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (listiningTest.status == "featured" ||
                                                  listiningTest.status ==
                                                      "active")
                                              ? SizedBox()
                                              : InkWell(
                                                  radius: 20,
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            EditPropertyCubit>()
                                                        .fGetDataEditPropertyModel();
                                                    context
                                                        .read<
                                                            EditPropertyCubit>()
                                                        .emptyCubitData();

                                                    sl<AppNavigator>().push(
                                                        screen: EditPropertyScreen(
                                                            listingId:
                                                                listiningTest.id
                                                                    .toString()));
                                                  },
                                                  child: SizedBox(
                                                    width: 30.w,
                                                    height: 20.h,
                                                    child: SvgPicture.asset(
                                                        editeIconsSvg),
                                                  )),
                                          listiningTest.status == "featured"
                                              ? Container(
                                                  height: 20.h,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.w,
                                                      vertical: 4.h),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffE9ECFE),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r)),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        starColorsSvg,
                                                        color:
                                                            Color(0xff5570F1),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Text(
                                                        tr("feature"),
                                                        style: TextStyles
                                                            .textViewSemiBold8
                                                            .copyWith(
                                                                color:
                                                                    textColor),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : listiningTest.status != "active"
                                                  ? SizedBox()
                                                  : InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) {
                                                              return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(15.0.r))),
                                                                content:
                                                                    DialogFeature(
                                                                  listingId:
                                                                      listiningTest
                                                                          .id,
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: Container(
                                                        height: 20.h,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5.w,
                                                                vertical: 5.h),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                starIconsSvg),
                                                            SizedBox(
                                                              width: 1.w,
                                                            ),
                                                            Text(
                                                              tr("feature"),
                                                              style: TextStyles
                                                                  .textViewSemiBold8
                                                                  .copyWith(
                                                                      color:
                                                                          textColor),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          listiningTest.status == "draft"
                                              ? SizedBox()
                                              : PopupMenuButton(
                                                  icon: SvgPicture.asset(
                                                      moreIconsSvg),
                                                  splashRadius: 20.r,
                                                  position:
                                                      PopupMenuPosition.under,
                                                  shape:
                                                      ContinuousRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.r),
                                                  ),
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                        child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) {
                                                              return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(15.0.r))),
                                                                content:
                                                                    DialogClose(
                                                                  listingId:
                                                                      listiningTest
                                                                          .id,
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 15.h,
                                                            width: 15.w,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.close,
                                                                size: 10,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(tr("close"),
                                                              style: TextStyles
                                                                  .textViewMedium15
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey)),
                                                        ],
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                        ],
                                      ),
                              ],
                            ),
                      Text(
                        listiningTest.title,
                        style: TextStyles.textViewMedium12
                            .copyWith(color: Color(0xff252B5C)),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(locationIconsSvg),
                          Expanded(
                            child: Text(
                              listiningTest.location.country,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyles.textViewMedium10
                                  .copyWith(color: textColorLight),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "${listiningTest.currency} ${listiningTest.price}",
                        style: TextStyles.textViewSemiBold15
                            .copyWith(color: Color(0xff252B5C)),
                      ),

                      isSearch
                          ? SizedBox()
                          : (listiningTest.status == "active" ||
                                  listiningTest.status == "featured")
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 12,
                                      color: Color(0xff252B5C),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              "ar"
                                          ? "${tr("expired")} ${listiningTest.listingExpireAfter} ${tr("expires_days")}"
                                          : "${tr("expiresـin")} ${listiningTest.listingExpireAfter} ${tr("days")}",
                                      style: TextStyles.textViewSemiBold8
                                          .copyWith(color: Color(0xff252B5C)),
                                    )
                                  ],
                                )
                              : listiningTest.status == "pending"
                                  ? Text(
                                      "${tr("shooting_scheduled")} ${listiningTest.recommendeShootingDate}",
                                      style: TextStyles.textViewSemiBold8
                                          .copyWith(color: primary),
                                    )
                                  : SizedBox()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListiningTest {
  final int? id;
  final String? title;
  final String? price;
  final String? status;
  final String? description;
  final bool? IsFeatures;
  final String? images;
  final String? location;
  final String? recommendedShootingDate;
  final String? shootingDate;
  final String? date;

  ListiningTest(
      {this.id,
      this.title,
      this.price,
      this.status,
      this.description,
      this.IsFeatures,
      this.images,
      this.location,
      this.recommendedShootingDate,
      this.shootingDate,
      this.date});
}
