import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makanvi_web/core/widgets/toast.dart';
import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/util/navigator.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/pages/buyer_auth_pages/signup_buyer_page.dart';
import '../cubit/favorite_icon/favorite_icon_cubit.dart';

class FavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final int id;
  final double width;
  final double height;
  final double size;
  final Color color;
  const FavoriteIcon({
    super.key,
    required this.isFavorite,
    required this.id,
    this.width = 30,
    this.height = 30,
    this.size = 15,
    this.color = primary,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void toggleIsFavourite() {
    if (mounted) {
      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<FavoriteIconCubit>(),
        child: BlocConsumer<FavoriteIconCubit, FavoriteIconState>(
          listener: (context, state) {
            if (state is FavoriteIconErrorState) {
              customToast(
                  backgroundColor: primary,
                  textColor: white,
                  content: state.message);
              toggleIsFavourite();
            }
          },
          builder: (context, state) {
            if (state is FavoriteIconLoadingState) {
              return Container(
                width: widget.width,
                height: widget.height,
                decoration: const BoxDecoration(
                    //color: isFavorite ? primary : white.withOpacity(0.78),
                    shape: BoxShape.circle),
                child: const Center(
                    child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(primary),
                        ))),
              );
            } else {
              return Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                    gradient: isFavorite
                        ? const RadialGradient(
                            colors: [Color(0xFFFD5F4A), Color(0xFFF249A4)])
                        : RadialGradient(colors: [
                            white.withOpacity(0.78),
                            white.withOpacity(0.78)
                          ]),
                    // color:
                    //     widget.isFavorite ? primary : white.withOpacity(0.78),
                    shape: BoxShape.circle),
                child: InkWell(
                  onTap: sl<BlocMainCubit>()
                              .repository
                              .loadAppData()!
                              .isGuestUser ==
                          true
                      ? () {
                          sl<AppNavigator>().push(screen: SignUpBuyerPage());
                        }
                      : () {
                          isFavorite
                              ? context
                                  .read<FavoriteIconCubit>()
                                  .fRemoveFromFavorites(id: widget.id)
                              : context
                                  .read<FavoriteIconCubit>()
                                  .fAddToFavorites(id: widget.id);
                          toggleIsFavourite();
                        },
                  child: isFavorite
                      ? Icon(
                          Icons.favorite,
                          size: widget.size,
                          color: white,
                        )
                      : Icon(
                          Icons.favorite_border,
                          size: widget.size,
                          color: widget.color,
                        ),
                ),
              );
            }
          },
        ));
  }
}
