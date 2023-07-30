import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/loading.dart';
import '../../../../../auth/presentation/cubit/add_property/add_property_cubit.dart';
import 'add_property_first_step.dart';
import 'add_property_fourth_loged.dart';
import 'add_property_fourth_step.dart';
import 'add_property_second_step.dart';
import 'add_property_third_step.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen(
      {super.key,
      this.isLoged = false,
      this.isPay = true,
      this.packageId,
      this.goTo = "pay"});
  final bool isLoged;
  final bool isPay;
  final String goTo;
  final int? packageId;

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddPropertyCubit>().fGetDataAddPropertyModel();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.isPay.toString());
    return
        // BlocProvider(
        //   create: (context) => sl<AddPropertyCubit>()..fGetDataAddPropertyModel(),
        //   child:
        BlocConsumer<AddPropertyCubit, AddPropertyState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingProparty) {
          return Scaffold(
            body: Center(
              child: Loading(),
            ),
          );
        }
        return PageView(
          // appBar: AppBarGeneric(
          //   title: "Add Property",
          //   titleColor: textColor,
          // ),
          physics: NeverScrollableScrollPhysics(),
          controller: context.read<AddPropertyCubit>().pageController,
          children: [
            AddPropertyFirstStep(
              isLoged: widget.isLoged,
              isPay: widget.isPay,
              packageId: widget.packageId ?? 0,
              goTo: widget.goTo,
            ),
            AddPropertySecondStep(),
            AddPropertyThirdStep(),
            widget.isLoged == true
                ? AddPropertyFourthLogedStep(
                    isPay: widget.isPay,
                    packageId: widget.packageId,
                    goTo: widget.goTo,
                  )
                : AddPropertyFourthStep(),
          ],
        );
      },
      // ),
    );
  }
}
