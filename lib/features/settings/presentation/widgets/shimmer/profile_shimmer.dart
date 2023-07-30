import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import '../../../../../core/shimmer/custom_shimmer.dart';

class MyAccountShimmer extends StatelessWidget {
  const MyAccountShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                      fit: StackFit.loose,
                      alignment: AlignmentDirectional.center,
                      children: [
                        Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(100),
                          child: const CircleAvatar(
                            backgroundColor: white,
                            radius: 60,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 500.h,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: white),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
