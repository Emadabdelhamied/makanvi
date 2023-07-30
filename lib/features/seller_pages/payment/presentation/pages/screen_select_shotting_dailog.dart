import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/seller_pages/payment/presentation/widget/dialog_select_shoting.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/widgets/appbar_generic.dart';

class ScreenSelectShottingDateDialog extends StatefulWidget {
  const ScreenSelectShottingDateDialog({
    super.key,
    required this.listingId,
  });
  final String listingId;
  @override
  State<ScreenSelectShottingDateDialog> createState() =>
      _ScreenSelectShottingDateDialogState();
}

class _ScreenSelectShottingDateDialogState
    extends State<ScreenSelectShottingDateDialog> {
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
              content: DialogSelectShotting(
                listingId: widget.listingId,
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(
        title: tr("my_properties"),
        titleColor: textColor,
      ),
    );
  }
}
