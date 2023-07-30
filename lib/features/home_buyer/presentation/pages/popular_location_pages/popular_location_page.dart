import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/widgets/error_screen.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/centralize_grid_view.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/util/paginate_loading.dart';
import '../../../../../core/util/sizedbox_extension.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../cubit/popular_location_cubit/popular_location_cubit.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../search/search_screen.dart';

class PopularLocationPage extends StatefulWidget {
  const PopularLocationPage({super.key});

  @override
  State<PopularLocationPage> createState() => _PopularLocationPageState();
}

class _PopularLocationPageState extends State<PopularLocationPage> {
  late final ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    context.read<PopularLocationCubit>().fGetPopularLocation(isFirst: true);
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        context.read<PopularLocationCubit>().fGetPopularLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PopularLocationCubit>()..fGetPopularLocation(),
      child: Scaffold(
        appBar: AppBarGeneric(
          title: tr("popular_location"),
          style: TextStyles.textViewSemiBold16.copyWith(color: textColor),
        ),
        body: BlocConsumer<PopularLocationCubit, PopularLocationState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubitList =
                context.watch<PopularLocationCubit>().popularLocationList;
            if (state is GetPopularLocationLoading) {
              return Loading();
            }
            if (state is ErrorGetPopularLocation) {
              return Center(
                  child: ErrorScreen(
                      //text: "Error Occuerd",
                      ));
            }

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GridView.builder(
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndCentralizedLastElement(
                  itemCount: cubitList.length,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                ),
                itemCount: cubitList.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = cubitList[index];
                  if (index == cubitList.length) {
                    if (state is GetPopularLocationLoading) {
                      return PaginateLoading();
                    } else {
                      return const SizedBox();
                    }
                  }
                  return InkWell(
                    onTap: () {
                      context.read<SearchCubit>().locationId = item.id;
                      sl<AppNavigator>().push(
                          screen: SearchScreen(
                        fromHome: true,
                        locationId: item.id,
                        location: item.name,
                      ));
                    },
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(25.r),
                      child: Container(
                        height: 225.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(25.r)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 170.0,
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              EndPoints.baseImages +
                                                  item.coverImagePath,
                                            ))),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 25.h,
                                      width: 27.w,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: RichText(
                                        text: TextSpan(
                                            text: "#",
                                            style: TextStyles.textViewSemiBold8
                                                .copyWith(color: white),
                                            children: [
                                              TextSpan(
                                                text: item.propertiesCount
                                                    .toString(),
                                                style: TextStyles
                                                    .textViewSemiBold12
                                                    .copyWith(color: white),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            10.sizHeight,
                            Text(
                              item.name,
                              style: TextStyles.textViewBold12
                                  .copyWith(color: textColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
