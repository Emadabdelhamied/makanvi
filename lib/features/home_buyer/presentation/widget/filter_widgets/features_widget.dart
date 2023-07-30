import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../cubit/search_cubit/search_cubit.dart';

class FeatureFilterPropertyWidget extends StatefulWidget {
  FeatureFilterPropertyWidget({
    super.key,
  });

  @override
  State<FeatureFilterPropertyWidget> createState() =>
      _FeaturePropertyWidgetrState();
}

class _FeaturePropertyWidgetrState extends State<FeatureFilterPropertyWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (state is SucessProparty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr("features"),
              style: TextStyles.textViewBold16.copyWith(color: black1),
            ),
            SizedBox(
              height: context.read<SearchCubit>().featuresList.length * 40,
              child: ListView.builder(
                  // shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: context.read<SearchCubit>().featuresList.length,
                  itemBuilder: (context, index) {
                    if (context.read<SearchCubit>().getFeaturesAdd.length <
                        context.read<SearchCubit>().featuresList.length) {
                      context.read<SearchCubit>().setFeatureAdd(
                          context.read<SearchCubit>().featuresList[index].id,
                          0);
                    }
                    var item = context.read<SearchCubit>().featuresList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            item.title,
                            style: TextStyles.textViewMedium14
                                .copyWith(color: textColor),
                          ),
                          Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Localizations.localeOf(context).languageCode ==
                                      "ar"
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<SearchCubit>()
                                              .incrementCounterList(index);
                                        });
                                      },
                                      child: Container(
                                        height: 25.w,
                                        width: 25.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            color: secondry2),
                                        child: Icon(
                                          Icons.add,
                                          size: 20.sp,
                                          color: white,
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<SearchCubit>()
                                              .decrementCounterList(index);
                                        });
                                      },
                                      child: Container(
                                        height: 25.w,
                                        width: 25.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            color: secondry2),
                                        child: Icon(
                                          Icons.remove,
                                          color: white,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                tr(context
                                    .read<SearchCubit>()
                                    .getFeaturesAdd[index]
                                    .count
                                    .toString()),
                                style: TextStyles.textViewMedium14
                                    .copyWith(color: textColor),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Localizations.localeOf(context).languageCode ==
                                      "ar"
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<SearchCubit>()
                                              .decrementCounterList(index);
                                        });
                                      },
                                      child: Container(
                                        height: 25.w,
                                        width: 25.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            color: secondry2),
                                        child: Icon(
                                          Icons.remove,
                                          color: white,
                                          size: 20.sp,
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<SearchCubit>()
                                              .incrementCounterList(index);
                                        });
                                      },
                                      child: Container(
                                        height: 25.w,
                                        width: 25.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            color: secondry2),
                                        child: Icon(
                                          Icons.add,
                                          size: 20.sp,
                                          color: white,
                                        ),
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
