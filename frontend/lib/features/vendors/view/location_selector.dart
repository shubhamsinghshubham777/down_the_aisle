import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_app_bar.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/half_onion_dome_container.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String? selectedState = 'Agra';

  @override
  Widget build(BuildContext context) {
    return HalfOnionDomeContainer(
      child: Column(
        children: [
          const DTAAppBar(title: 'Bookings'),
          DropdownButton(
            value: selectedState,
            items: const [
              DropdownMenuItem<String>(
                value: 'Agra',
                child: Text('Agra'),
              ),
              DropdownMenuItem<String>(
                value: 'Delhi',
                child: Text('Delhi'),
              ),
            ],
            onChanged: (state) => setState(() => selectedState = state),
            style: TextStyle(
              color: appColors.accent,
              fontFamily: Constants.fontDMSerifDisplay,
              fontSize: 18,
            ),
            icon: Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: DtaIcon(
                Assets.iconArrowDown,
                color: appColors.accent,
                width: 7,
                height: 7,
              ),
            ),
            iconSize: 7,
            underline: const SizedBox.shrink(),
            dropdownColor: appColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          SvgPicture.asset(
            Assets.imageLocationAgra,
            height: 104,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
