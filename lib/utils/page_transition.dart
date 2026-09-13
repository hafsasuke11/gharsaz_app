import 'package:flutter/material.dart';

class PageTransition {
  static Route slide(Widget page) {
    return PageRouteBuilder(
      pageBuilder:
          (context, animation, secondaryAnimation) {
        return page;
      },

      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        const begin = Offset(1, 0);

        const end = Offset.zero;

        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),

          child: child,
        );
      },

      transitionDuration:
      const Duration(milliseconds: 350),
    );
  }

  static Route fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder:
          (context, animation, secondaryAnimation) {
        return page;
      },

      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        return FadeTransition(
          opacity: animation,

          child: child,
        );
      },

      transitionDuration:
      const Duration(milliseconds: 300),
    );
  }
}