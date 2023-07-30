import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../bloc/share_cubit/share_cubit.dart';
import '../../../../core/util/navigator.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/pages/buyer_auth_pages/signup_buyer_page.dart';
import '../../../chat/presentation/pages/chat_list.dart';
import '../../../favourite/presentation/pages/favourite_screen.dart';
import '../cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../widget/bottom_nav_buyer.dart';
import 'home_buyer_page.dart';
import 'search/search_screen.dart';

class HomeMainBuyer extends StatefulWidget {
  const HomeMainBuyer({super.key});

  @override
  State<HomeMainBuyer> createState() => _HomeMainBuyerState();
}

class _HomeMainBuyerState extends State<HomeMainBuyer> {
  // int? _currentPage;
  goToProduct() {
    // context.read<ShareCubit>().goToProduct(context: context);
  }

  @override
  void initState() {
    // _currentPage = 0;
    super.initState();
    goToProduct();
  }

  @override
  Widget build(BuildContext context) {
    var isGuest =
        context.watch<BlocMainCubit>().repository.loadAppData()!.isGuestUser;
    return BlocListener<HomeBuyerCubit, HomeBuyerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: list.elementAt(
            context.watch<HomeBuyerCubit>().getcurrentIndexBuyerHome),
        bottomNavigationBar: AnimatedBottomBuyer(
            currentIndex:
                context.watch<HomeBuyerCubit>().getcurrentIndexBuyerHome,
            onChange: (index) {
              if (isGuest == true && (index == 2 || index == 3)) {
                sl<AppNavigator>().push(screen: SignUpBuyerPage());
              } else {
                setState(() {
                  context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome =
                      index;
                });
              }
            }),
      ),
    );
  }

  List<Widget> list = [
    HomeBuyerPage(),
    SearchScreen(),
    FavouriteScreen(),
    ChatListScreen()
  ];
  getPage(int? page) {
    switch (page) {
      case 0:
        return Center(
            child: Container(
          child: Text("Home Page"),
        ));
      case 1:
        return Center(
            child: Container(
          child: Text("Profile Page"),
        ));
      case 2:
        return Center(
            child: Container(
          child: Text("Menu Page"),
        ));
      case 3:
        return Center(
            child: Container(
          child: Text("Menu Page"),
        ));
    }
  }
}
