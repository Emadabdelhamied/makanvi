import 'package:flutter/material.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/data/models/my_listings_all_model.dart';

import '../../../../seller_pages/listining_seller/data/models/my_listing_model.dart';
import '../../../../seller_pages/listining_seller/presentation/widgets/card_listing.dart';

class ListingInProjectWidget extends StatelessWidget {
  final List<Property> properties;
  const ListingInProjectWidget({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //controller: scrollController,
      shrinkWrap: false,
      physics: BouncingScrollPhysics(),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        var item = properties[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CardListing(
            listiningTest: Active(
                id: item.id,
                currency: item.currency,
                title: item.title,
                price: item.price,
                isFav: item.isFav,
                status: item.status,
                coverImage: item.coverImage,
                location: item.location,
                listingExpireAfter: item.listingExpireAfter,
                featureExpireAfter: item.featureExpireAfter,
                recommendeShootingDate: '',
                shootingDate: item.shootingDate ?? ''),
            isSearch: true,
          ),
        );
      },
    );
  }
}
