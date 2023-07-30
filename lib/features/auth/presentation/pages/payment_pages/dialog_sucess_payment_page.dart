import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../widgets/payment_widgets/dialog_payment_sucess.dart';

class DialogSucessPaymentPage extends StatefulWidget {
  const DialogSucessPaymentPage(
      {super.key,
      required this.listingId,
      required this.goto,
      this.isAgentFirst = false});
  final String listingId;
  final String goto;
  final bool isAgentFirst;
  @override
  State<DialogSucessPaymentPage> createState() =>
      _DialogSucessPaymentPageState();
}

class _DialogSucessPaymentPageState extends State<DialogSucessPaymentPage> {
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
              content: DialogPaymentSucsses(
                listingId: widget.listingId,
                goTo: widget.goto,
                isAgentFirst: widget.isAgentFirst,
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
