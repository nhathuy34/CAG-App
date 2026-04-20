import 'dart:math' as math;

import 'package:flutter/material.dart';

class NativeFireworks extends AnimatedWidget {
  const NativeFireworks({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> anim = listenable as Animation<double>;
    if (anim.value == 0 || anim.value == 1) return const SizedBox.shrink();

    final random = math.Random(42);
    final particles = List.generate(60, (i) {
      double startX = random.nextDouble();
      double speed = 0.5 + random.nextDouble() * 1.5;
      Color color = [
        Colors.greenAccent,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.yellow,
      ][random.nextInt(5)];
      return _ParticleDef(startX, speed, color);
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: particles.map((p) {
            double y =
                -50 + (anim.value * constraints.maxHeight * 1.5 * p.speed);
            return Positioned(
              left: p.startX * constraints.maxWidth,
              top: y,
              child: Transform.rotate(
                angle: anim.value * math.pi * 4 * p.speed,
                child: Container(
                  width: 8 + (p.speed * 4),
                  height: 8 + (p.speed * 4),
                  color: p.color,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ParticleDef {
  final double startX;
  final double speed;
  final Color color;
  _ParticleDef(this.startX, this.speed, this.color);
}
