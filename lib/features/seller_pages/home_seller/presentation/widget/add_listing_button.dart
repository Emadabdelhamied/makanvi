import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/widgets/button.dart';

class AddListingButton extends StatelessWidget {
  const AddListingButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GenericButton(
        color: white,
        borderRadius: BorderRadius.circular(12.r),
        borderColor: primary,
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Localizations.localeOf(context).languageCode == "en"
                ? Icon(
                    Icons.add,
                    size: 18,
                    color: primary,
                  )
                : SizedBox(),
            Text(
              tr("add_new_property"),
              style: TextStyles.textViewMedium12.copyWith(color: primary),
            ),
            Localizations.localeOf(context).languageCode == "ar"
                ? Icon(
                    Icons.add,
                    size: 18,
                    color: primary,
                  )
                : SizedBox(),
          ],
        ));
  }
}
