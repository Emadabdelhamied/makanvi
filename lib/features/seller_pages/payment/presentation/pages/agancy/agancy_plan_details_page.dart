import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/images.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/loading.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../../../injection_container.dart';
import '../../cubit/agancy_create/agancy_create_cubit.dart';
import 'agancy_dialog_sucess.dart';

class AgancyPlanDetails extends StatelessWidget {
  const AgancyPlanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: transparentColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
                height: 250.h, child: Image.asset(imageAgancySelectImage)),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 123.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: transparent,
                  border: Border.all(color: primary, width: 2)),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(

                    //   height: 30.h,
                    // ),
                    Text(
                      tr("agancy_package"),
                      style: TextStyles.textViewMedium18
                          .copyWith(color: textColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      tr("customize_your_package_to_fit"),
                      style: TextStyles.textViewMedium14
                          .copyWith(color: textColor),
                    ),
                  ]),
            ),
            SizedBox(
              height: 40.h,
            ),
            BlocProvider(
              create: (context) => sl<AgancyCreateCubit>(),
              child: BlocConsumer<AgancyCreateCubit, AgancyCreateState>(
                listener: (context, state) async {
                  if (state is ErrorAgancyCreate) {
                    customToast(
                        backgroundColor: red,
                        textColor: textColor,
                        content: state.message);
                  }
                  if (state is SucessAgancyCreate) {
                    await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0.r))),
                            content: AgancyDialogSucessCnofirm(),
                          );
                        });
                  }
                },
                builder: (context, state) {
                  if (state is AgancyCreateLoading) {
                    return Loading();
                  }
                  return GenericButton(
                    onPressed: () {
                      context.read<AgancyCreateCubit>().fAgancyCreate();
                    },
                    child: Text(
                      tr("select"),
                      style: TextStyles.textViewMedium15.copyWith(color: white),
                    ),
                    color: primary,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(15.r),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
