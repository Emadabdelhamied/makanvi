import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class PaginateLoading extends StatelessWidget {
  const PaginateLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset('assets/images/paginate.json'));
  }
}
