import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/size_config.dart';
import '../../../../seller_pages/listining_seller/data/models/my_listing_model.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../project_view/property_card.dart';

class MyWidget extends StatelessWidget {
  final int count;
  const MyWidget({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: count,
      // carouselController: buttonCarouselController,
      options: CarouselOptions(
          aspectRatio: SizeConfig.screenWidth / 250.w,
          height: 220.h,
          scrollDirection: Axis.horizontal,
          scrollPhysics: const BouncingScrollPhysics(),
          autoPlayCurve: Curves.easeInOut,
          viewportFraction: .75,
          disableCenter: true,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale),
      itemBuilder: (context, index, realIdx) {
        var search = context.watch<SearchCubit>().searchDataList;
        return PropertyCard(
          fromMap: true,
          property: Property(
              id: search[index].id,
              title:
                  "${search[index].location.city},${search[index].location.state},${search[index].location.country}",
              currency: search[index].currency,
              price: search[index].price,
              isFav: search[index].isFav,
              status: search[index].status,
              images: [],
              location: search[index].location,
              listingExpireAfter: search[index].listingExpireAfter,
              featureExpireAfter: search[index].featureExpireAfter,
              area: 0,
              isNegotiable: 0,
              description: '',
              recommendedShootingDate: DateTime.now(),
              shootingDate: search[index].shootingDate,
              coverImage: search[index].coverImage),
        );
      },
    );
  }
}
