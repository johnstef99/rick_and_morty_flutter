import 'package:flutter/material.dart';

class BlackOverlay extends StatelessWidget {
  const BlackOverlay({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.1, 0.7],
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcOver,
      child: child,
    );
  }
}
