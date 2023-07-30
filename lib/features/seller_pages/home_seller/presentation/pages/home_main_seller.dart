import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../chat/presentation/pages/chat_list.dart';
import '../../../listining_seller/presentation/pages/my_listings_home_page.dart';
import '../../../notifications_seller/presentation/pages/notifications_pages.dart';
import '../cubit/home_cubit.dart';
import '../widget/bottom_nav_seller.dart';
import 'home_seller_page.dart';

class HomeMainSeller extends StatefulWidget {
  const HomeMainSeller({super.key});

  @override
  State<HomeMainSeller> createState() => _HomeMainSellerState();
}

class _HomeMainSellerState extends State<HomeMainSeller> {
  goToProduct() {
    // context.read<ShareCubit>().goToProduct(context: context);
  }

  // int? _currentPage;
  @override
  void initState() {
    super.initState();
    goToProduct();
  }
  // @override
  // void initState() {
  //   _currentPage = 0;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeSellerCubit, HomeSellerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        backgroundColor: transparentColor,
        body: list.elementAt(
            context.watch<HomeSellerCubit>().getcurrentIndexSellerHome),
        bottomNavigationBar: AnimatedBottomNavSeller(
            currentIndex:
                context.watch<HomeSellerCubit>().getcurrentIndexSellerHome,
            onChange: (index) {
              // setState(() {
              context.read<HomeSellerCubit>().setcurrentIndexSellerHome = index;
              // });
            }),
      ),
    );
  }

  List<Widget> list = [
    const HomeSellerPage(),
    const MyListingHomePage(),
    NotificationsPage(),
    ChatListScreen(),
  ];
}
