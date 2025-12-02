import 'package:flutter/material.dart' show ModalBottomSheetRoute;
import 'package:flutter/widgets.dart';

class BottomSheetPage<T> extends Page<T> {
  const BottomSheetPage({required this.child, required super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
    settings: this,
    isScrollControlled: true,
    enableDrag: true,
    constraints: BoxConstraints(
      minHeight: 0,
      maxHeight: (MediaQuery.sizeOf(context).height * 0.9) - MediaQuery.paddingOf(context).top,
    ),
    elevation: 0,
    useSafeArea: true,
    backgroundColor: const Color(0x00000000),
    builder: (context) => Stack(alignment: Alignment.bottomCenter, children: [child]),
  );
}
