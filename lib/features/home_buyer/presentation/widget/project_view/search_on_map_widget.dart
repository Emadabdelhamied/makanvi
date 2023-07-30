import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../core/constant/icons.dart';
import '../filter_icon.dart';
import '../search_field_home_buer.dart';

class SearchOnMapWidget extends StatefulWidget {
  final Function() filterTab;
  final Function(String) onChange;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  const SearchOnMapWidget(
      {super.key,
      required this.filterTab,
      required this.controller,
      required this.onChange,
      required this.onSubmitted});

  @override
  State<SearchOnMapWidget> createState() => _SearchOnMapWidgetState();
}

class _SearchOnMapWidgetState extends State<SearchOnMapWidget> {
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: white,
                  child: SearchFieldHomeBuyer(
                    isEnable: true,
                    onTap: () {
                      log('message');
                    },
                    controller: widget.controller,
                    onSubmitted: widget.onSubmitted,
                    onChanged: widget.onChange,
                    prefixIcon: Container(
                        height: 20.h,
                        width: 30.w,
                        child: SvgPicture.asset(
                          searchIconSvg,
                          color: Color(0xff285E7C),
                        )),
                    hintText: tr("search_hint"),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              FilterIcon(
                onTap: widget.filterTab,
              )
            ],
          ),
        ],
      ),
    );
  }
}
