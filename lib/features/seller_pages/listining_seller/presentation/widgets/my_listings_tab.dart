import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../data/models/my_listings_all_model.dart';
import 'active_listing.dart';
import 'expired_listings.dart';
import 'pending_listings.dart';

class MyListingTab extends StatefulWidget {
  const MyListingTab({
    Key? key,
    required this.active,
    required this.pending,
    required this.expire,
    required this.subscriptions,
  }) : super(key: key);
  final List<Active> active;
  final List<Active> pending;
  final List<Active> expire;
  final Subscriptions subscriptions;

  @override
  State<MyListingTab> createState() => _MyListingTabState();
}

class _MyListingTabState extends State<MyListingTab>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            unselectedLabelColor: textColorLight,
            labelColor: Color(0xff2B2F32),
            indicatorColor: primary,
            indicatorWeight: 3,
            tabs: [
              Tab(
                text: tr("active"),
              ),
              Tab(
                text: tr("pending"),
              ),
              Tab(
                text: tr("expire"),
              ),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
              child: TabBarView(
            children: [
              ActiveListings(
                active: widget.active,
              ),
              PendingListings(
                pending: widget.pending,
              ),
              ExpiredListings(
                expire: widget.expire,
                subscriptions: widget.subscriptions,
              ),
            ],
            controller: _tabController,
          )),
        ],
      ),
    );
  }
}
