import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/images.dart';
import '../../../seller_pages/listining_seller/data/models/my_listings_all_model.dart';
import '../../../seller_pages/listining_seller/presentation/widgets/card_listing.dart';
import '../../../seller_pages/listining_seller/presentation/widgets/empty_listing.dart';

class AllFavouritesTab extends StatelessWidget {
  final List<Active> all;
  const AllFavouritesTab({super.key, required this.all});

  @override
  Widget build(BuildContext context) {
    return all.isEmpty
        ? EmptyListingScreen(
            text: tr('no_fav'),
            subText: tr("no_fav_sub"),
            image: noFavImage,
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: all.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardListing(
                  listiningTest: all[index],
                  isSearch: true,
                ),
              );
            },
          );
  }
}
