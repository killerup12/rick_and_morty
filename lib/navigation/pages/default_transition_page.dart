import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTransitionPage<T> extends Page<T> {
  const DefaultTransitionPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoPageRoute<T>(builder: (context) => child, settings: this);
    }
    return MaterialPageRoute<T>(builder: (context) => child, settings: this);
  }
}
