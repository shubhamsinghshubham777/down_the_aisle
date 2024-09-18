import 'package:flutter/material.dart';

@immutable
class DTAHorizontalListData {
  const DTAHorizontalListData({
    required this.imageUrl,
    required this.onTap,
    this.itemTitle,
    this.isCompleted,
  });

  final String imageUrl;
  final VoidCallback onTap;
  final String? itemTitle;
  final bool? isCompleted;
}
