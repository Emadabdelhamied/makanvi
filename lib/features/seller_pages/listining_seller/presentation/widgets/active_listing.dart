import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/images.dart';
import '../../data/models/my_listings_all_model.dart';
import 'card_listing.dart';
import 'empty_listing.dart';

class ActiveListings extends StatelessWidget {
  ActiveListings({
    super.key,
    required this.active,
  });
  final List<Active> active;
  @override
  Widget build(BuildContext context) {
    return active.isEmpty
        ? EmptyListingScreen(
            text: tr("No places added yet"),
            subText: tr("no_listing_sub"),
            image: noListingImage,
          )
        : ListView.builder(
            itemCount: active.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CardListing(
                  listiningTest: active[index],
                ),
              );
            });
  }
}
