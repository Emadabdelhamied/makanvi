import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/cubit/edit_property_cubit/edit_property_cubit.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../data/models/get_data_add_probalty_model.dart';
import '../../cubit/add_property/add_property_cubit.dart';

class EditFeaturePropertyWidget extends StatefulWidget {
  EditFeaturePropertyWidget({super.key, required this.features});
  final List<Amenity> features;

  @override
  State<EditFeaturePropertyWidget> createState() =>
      _EditFeaturePropertyWidgetState();
}

class _EditFeaturePropertyWidgetState extends State<EditFeaturePropertyWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyCubit, AddPropertyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // if (state is SucessProparty) {
        return Expanded(
          child: ListView.builder(
              // shrinkWrap: true,
              itemCount: widget.features.length,
              itemBuilder: (context, index) {
                var item = widget.features[index];
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                context
                                    .read<EditPropertyCubit>()
                                    .decrementCounterList(index);
                              });
                            },
                            child: Container(
                              height: 25.w,
                              width: 25.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
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
                            context
                                    .read<EditPropertyCubit>()
                                    .featuresAdd
                                    .where((element) => element.id == item.id)
                                    .isEmpty
                                ? '0'
                                : context
                                    .read<EditPropertyCubit>()
                                    .featuresAdd
                                    .where((element) => element.id == item.id)
                                    .first
                                    .count
                                    .toString(),
                            style: TextStyles.textViewMedium14
                                .copyWith(color: textColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                context
                                    .read<EditPropertyCubit>()
                                    .incrementCounterList(index);
                              });
                            },
                            child: Container(
                              height: 25.w,
                              width: 25.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
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
        );
      },
    );
  }
}
