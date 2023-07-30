import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/widgets/appbar_generic.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../injection_container.dart';
import '../cubit/static_cubit.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StaticCubit>()..fGetTerms(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarGeneric(
          title: tr("terms_and_condition"),
          titleColor: textColor,
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BlocBuilder<StaticCubit, StaticState>(
                    builder: (context, state) {
                      if (state is StaticPagesLoadingState) {
                        return Loading();
                      } else if (state is StaticPagesSuccessState) {
                        return HtmlWidget(state.message);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ))),
        ),
      ),
    );
  }
}
