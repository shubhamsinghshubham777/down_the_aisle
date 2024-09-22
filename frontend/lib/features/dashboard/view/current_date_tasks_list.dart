import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/utils/constants.dart';
import 'package:intl/intl.dart';

class CurrentDateTasksList extends StatelessWidget {
  const CurrentDateTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: Constants.fontKantumruy),
      child: Container(
        width: context.mqWidth,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: appColors.primaryLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Wed Nov 19 (Today)',
                style: TextStyle(
                  color: appColors.secondaryDark.withOpacity(0.6),
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: _TaskBriefText(
                dateTime: DateTime.now(),
                color: Colors.red,
                text: 'Meeting with Caterer',
              ),
            ),
            _TaskBriefText(
              dateTime: DateTime.now(),
              color: Colors.green,
              text: 'Payment due to Florist',
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _TaskBriefText extends StatelessWidget {
  const _TaskBriefText({
    required this.dateTime,
    required this.color,
    required this.text,
  });

  final DateTime dateTime;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: appColors.secondaryDark, fontSize: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('hh : mm').format(dateTime),
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            width: 5,
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.normal),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
