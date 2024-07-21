import 'package:flutter/material.dart';

class DesignConfig {
  static const BorderRadius lowBorderRadius = BorderRadius.all(
    Radius.circular(8),
  );
  static const BorderRadius mediumBorderRadius = BorderRadius.all(
    Radius.circular(12),
  );
  static const BorderRadius highBorderRadius = BorderRadius.all(
    Radius.circular(16),
  );

  static const BorderRadius circularBorderRadius = BorderRadius.all(
    Radius.circular(360),
  );

  static const BorderRadius veryHighBorderRadius = BorderRadius.all(
    Radius.circular(24),
  );

  static const Radius aLowBorderRadius = Radius.circular(8);
  static const Radius aMediumBorderRadius = Radius.circular(10);
  static const Radius aHighBorderRadius = Radius.circular(16);
  static const Radius aVeryHighBorderRadius = Radius.circular(24);

  static List<BoxShadow> defaultShadow(BuildContext context) => [
        BoxShadow(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.2),
          blurRadius: 12,
          spreadRadius: -2,
        ),
      ];
}
