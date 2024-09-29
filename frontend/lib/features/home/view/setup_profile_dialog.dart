import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/common/view/dta_text_field.dart';
import 'package:frontend/features/home/provider/setup_profile_dialog_providers.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/utils.dart';
import 'package:intl/intl.dart';

class SetupProfileDialog extends ConsumerStatefulWidget {
  const SetupProfileDialog({super.key});

  @override
  ConsumerState<SetupProfileDialog> createState() => _SetupProfileDialogState();
}

class _SetupProfileDialogState extends ConsumerState<SetupProfileDialog> {
  final budgetController = TextEditingController();
  final dateController = TextEditingController();
  late final SetupProfileDialogState profileUpdater;
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    postFrameCallback(() {
      profileUpdater = ref.read(setupProfileDialogStateProvider.notifier);
      final user = ref.read(setupProfileDialogStateProvider);
      budgetController.text = user?.weddingBudget?.toString() ?? '';
      dateController.text = user?.weddingDate?.toString() ?? '';
      ref.listenManual(setupProfileDialogStateProvider, (_, newState) {
        debugLog('newState: $newState');
        if (newState != null) {
          setState(() {
            budgetController.text = newState.weddingBudget?.toString() ?? '';
            dateController.text = newState.weddingDate?.toString() ?? '';
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Set up Profile',
        style: context.headlineMedium?.copyWith(
          fontFamily: Constants.fontDMSerifDisplay,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Tell us more about the details of your wedding to allow us to '
              'help you better:',
              style: context.bodyLarge,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Column(
                children: [
                  DTATextField(
                    labelText: 'Wedding Budget',
                    controller: budgetController,
                    keyboardType: TextInputType.number,
                    useLightTheme: true,
                    prefixIcon: const Icon(Icons.currency_rupee),
                  ),
                  DTATextField(
                    readOnly: true,
                    onTap: () async {
                      final dateTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );
                      if (dateTime != null) {
                        dateController.text = dateFormat.format(dateTime);
                      }
                    },
                    labelText: 'Wedding Date',
                    controller: dateController,
                    useLightTheme: true,
                    keyboardType: TextInputType.datetime,
                    prefixIcon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DTAButton.filled(
              text: 'Save',
              onTap: () {
                profileUpdater.updateState(
                  weddingBudget: int.tryParse(budgetController.text) ?? 0,
                  // weddingDate: dateFormat.tryParse(dateController.text),
                  weddingDate: dateController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
