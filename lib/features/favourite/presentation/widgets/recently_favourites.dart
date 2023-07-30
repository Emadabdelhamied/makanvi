import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:makanvi_web/core/constant/images.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/widgets/empty_listing.dart';

import '../../../seller_pages/listining_seller/data/models/my_listings_all_model.dart';
import '../../../seller_pages/listining_seller/presentation/widgets/card_listing.dart';

class RecentFavouritesTab extends StatelessWidget {
  final List<Active> recently;
  const RecentFavouritesTab({super.key, required this.recently});

  @override
  Widget build(BuildContext context) {
    return recently.isEmpty
        ? EmptyListingScreen(
            text: tr('no_fav'),
            subText: tr("no_fav_sub"),
            image: noFavImage,
          )
        : ListView.builder(
            itemCount: recently.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardListing(
                  listiningTest: recently[index],
                  isSearch: true,
                ),
              );
            },
          );
  }
}
