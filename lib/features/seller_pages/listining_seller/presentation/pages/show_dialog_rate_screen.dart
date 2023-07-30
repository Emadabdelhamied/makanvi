import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../widgets/rate_shooting/dialog_rating_shoot.dart';

class ShowDialogRateScreen extends StatefulWidget {
  const ShowDialogRateScreen({super.key, required this.propertyId});
  final int propertyId;
  @override
  State<ShowDialogRateScreen> createState() => _ShowDialogRateScreenState();
}

class _ShowDialogRateScreenState extends State<ShowDialogRateScreen> {
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
              content: DialogRateShotting(
                propertyId: widget.propertyId,
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(
        title: "My properties",
        titleColor: textColor,
        onPressed: () {},
      ),
    );
  }
}
