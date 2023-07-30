import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../data/models/user_role.dart';

class UserTypeWidget extends StatelessWidget {
  final bool isSelected;
  final UserRoleModel userRoleModel;
  final Function() onTap;
  const UserTypeWidget(
      {super.key,
      required this.isSelected,
      required this.userRoleModel,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 252.5.h,
          width: 336.w,
          decoration: BoxDecoration(
            color: isSelected ? transparent : white,
            borderRadius: BorderRadius.circular(
              15.r,
            ),
            border: Border.all(
              color: isSelected ? primary : black,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(userRoleModel.image),
              SizedBox(
                height: 12.h,
              ),
              Text(
                userRoleModel.role,
                style: TextStyles.textViewMedium16.copyWith(color: black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
