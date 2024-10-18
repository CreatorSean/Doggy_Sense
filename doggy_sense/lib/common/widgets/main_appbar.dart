import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainAppbar extends ConsumerStatefulWidget {
  final String title;
  const MainAppbar({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppbarState();
}

class _MainAppbarState extends ConsumerState<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffFAF9F6),
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.black),
      ),
      elevation: 0,
    );
  }
}
