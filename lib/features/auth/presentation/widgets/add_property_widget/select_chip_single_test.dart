import 'package:flutter/material.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';
import 'package:makanvi_web/features/auth/data/models/get_data_add_probalty_model.dart';

class ChipsFilter extends StatefulWidget {
  final List<Amenity> amenity;
  final Function(int)? onTap;
  final int selected;

  ChipsFilter(
      {Key? key, required this.amenity, required this.selected, this.onTap})
      : super(key: key);

  @override
  _ChipsFilterState createState() => _ChipsFilterState();
}

class _ChipsFilterState extends State<ChipsFilter> {
  ///
  /// Currently selected index
  ///
  int? selectedIndex;

  @override
  void initState() {
    // When [widget.selected] is defined, check the value and set it as
    // [selectedIndex]
    if (widget.selected >= 0 && widget.selected < widget.amenity.length) {
      this.selectedIndex = widget.selected;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.amenity.length,
        (index) {
          Amenity amenity = widget.amenity[index];
          bool isActive = this.selectedIndex == index;
          return GestureDetector(
              onTap: () {
                widget.onTap!(index);
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Chip(
                label: Text(
                  amenity.title,
                  style: TextStyles.textViewMedium12
                      .copyWith(color: isActive ? white : secondry2),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  side: BorderSide(
                    color: background1,
                  ),
                ),
                backgroundColor: isActive ? iconColor : white,
              ));
        },
      ),
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.start,
      runSpacing: 0.0,
      spacing: 0.0,
      // textDirection: widget.textDirection,
      verticalDirection: VerticalDirection.down,
    );
  }
}
