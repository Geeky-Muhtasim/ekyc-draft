import 'package:flutter/material.dart';

class GlowingStepProgressIndicatorWidget extends StatefulWidget {
  const GlowingStepProgressIndicatorWidget({
    required this.currentStep,
    required this.totalSteps,
    super.key,
    this.height = 6,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.blue,
  });
  final int currentStep;
  final int totalSteps;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  @override
  State<GlowingStepProgressIndicatorWidget> createState() =>
      _GlowingStepProgressIndicatorWidgetState();
}

class _GlowingStepProgressIndicatorWidgetState
    extends State<GlowingStepProgressIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progressFraction =
        (widget.totalSteps == 0 || widget.currentStep <= 0)
        ? 0
        : (widget.currentStep / widget.totalSteps).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progressFraction,
              child: AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: widget.progressColor.withOpacity(
                        _glowAnimation.value,
                      ),
                      borderRadius: BorderRadius.circular(widget.height / 2),
                      boxShadow: [
                        BoxShadow(
                          color: widget.progressColor.withOpacity(
                            _glowAnimation.value,
                          ),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Step ${widget.currentStep} of ${widget.totalSteps}',
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
