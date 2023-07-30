import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import 'agancy_dialog_all_listing_used.dart';

class AgancyListingUsedScreen extends StatefulWidget {
  const AgancyListingUsedScreen({
    super.key,
  });
  @override
  State<AgancyListingUsedScreen> createState() =>
      _AgancyListingUsedScreenState();
}

class _AgancyListingUsedScreenState extends State<AgancyListingUsedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0.r))),
              content: AgancyDialogAllListingUsed(),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBarGeneric(
          title: tr("my_properties"),
          titleColor: textColor,
        ),
      ),
    );
  }
}
