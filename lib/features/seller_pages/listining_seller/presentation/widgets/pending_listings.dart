import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/images.dart';
import '../../data/models/my_listings_all_model.dart';
import 'card_listing.dart';
import 'empty_listing.dart';

class PendingListings extends StatelessWidget {
  PendingListings({super.key, required this.pending});
  final List<Active> pending;

  @override
  Widget build(BuildContext context) {
    return pending.isEmpty
        ? EmptyListingScreen(
            text: tr("No places added yet"),
            subText: tr("no_listing_sub"),
            image: noListingImage,
          )
        : ListView.builder(
            itemCount: pending.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CardListing(
                  listiningTest: pending[index],
                ),
              );
            });
  }
}
