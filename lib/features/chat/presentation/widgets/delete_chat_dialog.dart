import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/widgets/loading.dart';
import 'package:makanvi_web/core/widgets/toast.dart';
import 'package:makanvi_web/features/chat/domain/usecases/remove_one_list_usecase.dart';
import 'package:makanvi_web/features/chat/presentation/cubit/remove_list_cubit/remove_list_cubit.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';

class DeleteChat extends StatelessWidget {
  final int channelId;

  const DeleteChat({
    super.key,
    required this.channelId,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              sl<AppNavigator>().pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.close),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Are you sure you want to delete this chat?",
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocProvider(
                  create: (context) => sl<RemoveListCubit>(),
                  child: BlocConsumer<RemoveListCubit, RemoveListState>(
                    listener: (context, state) {
                      if (state is RemoveListOneSucess) {
                        customToast(
                            backgroundColor: Colors.green,
                            textColor: white,
                            content: state.message);
                        Navigator.of(context).pop(true);
                      }
                    },
                    builder: (context, state) {
                      if (state is RemoveListOneLoading) {
                        return Loading();
                      } else {
                        return GenericButton(
                            width: 220.w,
                            onPressed: () {
                              context.read<RemoveListCubit>().fRemoveOneList(
                                  removeOneListParams: RemoveOneListParams(
                                      channelId: channelId));
                            },
                            color: primary,
                            // height: 45.h,
                            borderRadius: BorderRadius.circular(10),
                            child: Text(
                              "Delete Chat",
                              style: TextStyles.textViewSemiBold16
                                  .copyWith(color: white),
                            ));
                      }
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'No, Keep chat',
                      style:
                          TextStyles.textViewSemiBold16.copyWith(color: black),
                    ))
              ]),
        ],
      ),

      // ),
    );
  }
}
