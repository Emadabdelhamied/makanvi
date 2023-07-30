import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/images.dart';
import 'dialog_share_location.dart';

class ShareLocatinPage extends StatefulWidget {
  const ShareLocatinPage({super.key});

  @override
  State<ShareLocatinPage> createState() => _ShareLocatinPageState();
}

class _ShareLocatinPageState extends State<ShareLocatinPage> {
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
              content: DialogShareLocation(),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(mapImage),
      ),
    );
  }
}
