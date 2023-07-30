import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makanvi_web/core/widgets/error_screen.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/util/paginate_loading.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/property_details.dart';
import '../../../../seller_pages/listining_seller/presentation/widgets/empty_listing.dart';
import '../../cubit/recently_all_cubit/recently_all_cubit.dart';
import '../../widget/feature_and_recent_widget/card_recent_all.dart';
import '../featue_all_pages/show_featured_property_on_map.dart';

class RecentAllPage extends StatefulWidget {
  const RecentAllPage({super.key});

  @override
  State<RecentAllPage> createState() => _RecentAllPageState();
}

class _RecentAllPageState extends State<RecentAllPage> {
  late final ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    context.read<RecentlyAllCubit>().getBytesFromAsset();
    context.read<RecentlyAllCubit>().fGetRecentlyAll(isFirst: true);
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        context.read<RecentlyAllCubit>().fGetRecentlyAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RecentlyAllCubit>()..fGetRecentlyAll(),
      child: Scaffold(
        appBar: AppBarGeneric(
          title: tr("recently_listed"),
          style: TextStyles.textViewSemiBold16.copyWith(color: textColor),
        ),
        body: BlocConsumer<RecentlyAllCubit, RecentlyAllState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetRecentlyAllLoading) {
              return const Loading();
            }
            if (state is ErrorGetRecentlyAll) {
              return const Center(
                  child: ErrorScreen(
                      // text: "Error Occuerd",
                      ));
            }
            final cubitList =
                context.watch<RecentlyAllCubit>().recentlyDataList;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${cubitList.length} ${cubitList.length > 10 ? tr("place") : tr("listings")}",
                    style: TextStyles.textViewSemiBold18
                        .copyWith(color: textColor),
                  ),
                  Expanded(
                      child: cubitList.isEmpty
                          ? const Center(
                              child: EmptyListingScreen(
                              text: "No Recently Property Founded",
                              image: manImage,
                              subText: "",
                            ))
                          : ListView.builder(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubitList.length,
                              itemBuilder: ((context, index) {
                                if (index == cubitList.length) {
                                  if (state
                                      is GetRecentlyAllPaginationLoading) {
                                    return const PaginateLoading();
                                  } else {
                                    return const SizedBox();
                                  }
                                }
                                var item = cubitList[index];
                                return CardRecentAll(item: item);
                              })))
                ],
              ),
            );
          },
        ),
        floatingActionButton: InkWell(
          onTap: () {
            var items = context.read<RecentlyAllCubit>().recentlyDataList;
            sl<AppNavigator>().push(
              screen: FeaturedPropertyShowOnMap(
                //images: images,
                markerIcon: context.read<RecentlyAllCubit>().markerIcon!,
                properties: items,
                title: tr("feature_all"),
                markers: {
                  for (var element in items)
                    Marker(
                      markerId: MarkerId("${element.id}".toString()),
                      position: LatLng(double.parse(element.location.latitude),
                          double.parse(element.location.longitude)),
                      infoWindow: InfoWindow(
                          title: "${element.currency} ${element.price}",
                          onTap: () {
                            sl<AppNavigator>().push(
                                screen: PropertyDetails(
                                    listingId: element.id.toString()));
                          },
                          snippet:
                              "${element.location.city},${element.location.state},${element.location.country}"),
                      icon: context.read<RecentlyAllCubit>().markerIcon == null
                          ? BitmapDescriptor.defaultMarker
                          : BitmapDescriptor.fromBytes(
                              context.read<RecentlyAllCubit>().markerIcon!),
                    )
                },
                latitude: double.parse(items.first.location.latitude),
                longitude: double.parse(items.first.location.longitude),
              ),
            );
          },
          child: Container(
            height: 65.h,
            width: 65.h,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: iconColor),
            child: SvgPicture.asset(
              mapIcon,
              height: 20.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
