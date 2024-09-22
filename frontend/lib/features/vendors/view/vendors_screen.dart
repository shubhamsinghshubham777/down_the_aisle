import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/custom_package_advertisement.dart';
import 'package:frontend/features/main/view/main_screen.dart';
import 'package:frontend/features/vendors/view/complete_vendor_team_section.dart';
import 'package:frontend/features/vendors/view/location_selector.dart';
import 'package:frontend/features/vendors/view/top_vendors_list.dart';
import 'package:frontend/features/vendors/view/venue_list.dart';

class VendorsScreen extends ConsumerWidget {
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LocationSelector(),
            const SizedBox(height: 16),
            const VenueList(),
            const SizedBox(height: 16),
            const CompleteVendorTeamSection(),
            const TopVendorsList(),
            const CustomPackageAdvertisement(),
            SizedBox(height: MainScreen.bottomNavBarHeight(context)),
          ],
        ),
      ),
    );
  }
}
