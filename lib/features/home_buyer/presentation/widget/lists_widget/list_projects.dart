import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/home_buer_model.dart';
import '../../pages/project_view/project_view_screen.dart';

class ListProjects extends StatelessWidget {
  const ListProjects({super.key, required this.projects});
  final List<PopularLocation> projects;
  @override
  Widget build(BuildContext context) {
    var currentLocal = Localizations.localeOf(context).languageCode;

    return SizedBox(
      height: 130.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // itemCount: state.homeBuyerModel.projects.length,
          itemCount: projects.length,
          itemBuilder: (context, index) {
            var item = projects[index];
            return Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: InkWell(
                onTap: () {
                  sl<AppNavigator>().push(
                      screen: ProjectView(
                    projectId: item.id,
                    projectName: item.name,
                  ));
                },
                child: Stack(
                  children: [
                    Container(
                      height: 130.h,
                      width: 205.w,
                      decoration: BoxDecoration(
                          //color: black.withOpacity(0.4),
                          // color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15.r),
                          image: item.coverImagePath.isEmpty
                              ? DecorationImage(
                                  fit: BoxFit.fill, image: AssetImage(image4))
                              : DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(EndPoints.baseImages +
                                      item.coverImagePath))),
                      // child:
                    ),
                    Container(
                      height: 130.h,
                      width: 205.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.black.withOpacity(0.75),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 150.w,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Text(
                                  item.name,
                                  style: TextStyles.textViewSemiBold15
                                      .copyWith(color: white),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 5.h,
                            // ),
                            // Text(
                            //   item.description!,
                            //   maxLines: 2,
                            //   style: TextStyles.textViewMedium8
                            //       .copyWith(color: white),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 40.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: iconColor,
                            borderRadius: currentLocal == "ar"
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(20.r))
                                : BorderRadius.only(
                                    topRight: Radius.circular(20.r))),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward,
                          color: white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
