import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../seller_pages/listining_seller/data/models/my_listings_all_model.dart';
import 'dialog_cancle_subscrption.dart';

class CuurentPackageCard extends StatelessWidget {
  final Subscriptions packages;
  const CuurentPackageCard({super.key, required this.packages});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        height: 200.h,
        width: MediaQuery.of(context).size.width,
        child: packages.listing.id == 0 && packages.listing.listingCount == 0
            ? Center(
                child: Text(
                tr("no_packaqges"),
                style: TextStyles.textViewSemiBold18.copyWith(color: textColor),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Text(
                      tr("package"),
                      style: TextStyles.textViewSemiBold18
                          .copyWith(color: textColor),
                    ),
                    Text(
                      '${packages.listing.price}${packages.listing.currency}/${tr("monthly")}',
                      style: TextStyles.textViewMedium18
                          .copyWith(color: textColor),
                    ),
                    //MMM d, ''yy'
                    packages.listing.cancelled == 1
                        ? Text(tr("cancled"))
                        : Localizations.localeOf(context).languageCode == "ar"
                            ? Text(
                                "${tr("next_paymen")}:    ${DateFormat('MMM d, ' 'yy', 'ar_sa').format(DateTime.now().add(Duration(days: packages.listing.listingExpireDays)))}",
                                style: TextStyles.textViewSemiBold16
                                    .copyWith(color: textColor),
                              )
                            : Text(
                                "${tr("next_paymen")}:    ${DateFormat('MMM d, ' 'yy', 'en_usa').format(DateTime.now().add(Duration(days: packages.listing.listingExpireDays)))}",
                                style: TextStyles.textViewSemiBold16
                                    .copyWith(color: textColor),
                              ),
                    packages.listing.cancelled == 1
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      content: DialogCloseSubscrption(
                                        pakageId: packages.listing.id,
                                      ),
                                    );
                                  });
                            },
                            child: Text(
                              tr("cancel_subscription"),
                              style: TextStyles.textViewMedium12Underline
                                  .copyWith(color: textColor),
                            ),
                          )
                  ]),
      ),
    );
  }
}
