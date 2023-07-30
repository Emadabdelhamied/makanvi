import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/appbar_generic.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container.dart';
import '../../../home_buyer/presentation/cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../cubit/favorite_icon/favorite_icon_cubit.dart';
import '../cubit/favourite_cubit.dart';
import '../widgets/all_favourites.dart';
import '../widgets/recently_favourites.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 0;
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: BlocProvider(
          create: (context) => sl<FavouriteCubit>()..fGetFavourite(),
          child: Scaffold(
            appBar: AppBarGeneric(
              isback: true,
              onPressed: () {
                context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 0;
              },
              title: tr("favorites"),
              withTabBar: true,
              titleColor: textColor,
              actions: [
                BlocProvider(
                  create: (context) => sl<FavoriteIconCubit>(),
                  child: BlocConsumer<FavoriteIconCubit, FavoriteIconState>(
                    listener: (context, state) {
                      if (state is RemoveFavoriteSuccessState) {
                        customToast(
                            backgroundColor: Colors.green,
                            textColor: white,
                            content: state.message);
                        context.read<FavouriteCubit>().fGetFavourite();
                      }
                    },
                    builder: (context, state) {
                      if (state is RemoveFavoriteLoadingState) {
                        return Center(
                            child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator.adaptive(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(primary),
                                )));
                      } else {
                        return InkWell(
                          onTap: context.watch<FavouriteCubit>().len == 0
                              ? null
                              : () {
                                  context
                                      .read<FavoriteIconCubit>()
                                      .fRemoveAllFavorites();
                                },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SvgPicture.asset(DeleteSvg),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
              bottom: TabBar(
                indicatorColor: primary,
                tabs: [
                  Tab(
                      icon: Text(
                    tr("recent"),
                    style: TextStyles.textViewSemiBold16.copyWith(color: black),
                  )),
                  Tab(
                    icon: Text(
                      tr("all"),
                      style:
                          TextStyles.textViewSemiBold16.copyWith(color: black),
                    ),
                  ),
                ],
              ),
            ),
            body: BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FavouriteLoadingState) {
                  return Loading();
                } else if (state is FavouriteSuccess) {
                  return TabBarView(
                    children: [
                      RecentFavouritesTab(
                        recently: state.success.recently,
                      ),
                      AllFavouritesTab(
                        all: state.success.all,
                      ),
                    ],
                  );
                } else {
                  return ErrorScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
