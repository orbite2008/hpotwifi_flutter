// lib/core/utils/responsive.dart
import 'package:flutter/widgets.dart';

/// Fournit des outils pratiques pour adapter l'UI à la taille d’écran
class Responsive {
  final BuildContext context;
  final Size size;

  Responsive(this.context) : size = MediaQuery.of(context).size;

  double width(double percent) => size.width * percent / 100;
  double height(double percent) => size.height * percent / 100;

  bool get isMobile => size.width < 600;
  bool get isTablet => size.width >= 600 && size.width < 1100;
  bool get isDesktop => size.width >= 1100;
}
