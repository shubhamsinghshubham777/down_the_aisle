import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/in_progress_screen.dart';

class InspireScreen extends ConsumerWidget {
  const InspireScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: Center(child: InProgressScreen()));
  }
}