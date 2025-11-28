import 'package:flutter/material.dart';

/// Voice input button widget with recording state visualization
class VoiceInputButton extends StatefulWidget {
  const VoiceInputButton({
    super.key,
    required this.isRecording,
    required this.isEnabled,
    required this.onPressed,
    required this.onReleased,
  });

  final bool isRecording;
  final bool isEnabled;
  final VoidCallback onPressed;
  final VoidCallback onReleased;

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(VoiceInputButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording && !oldWidget.isRecording) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isRecording && oldWidget.isRecording) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: widget.isEnabled ? (_) => widget.onPressed() : null,
      onTapUp: widget.isEnabled ? (_) => widget.onReleased() : null,
      onTapCancel: widget.isEnabled ? widget.onReleased : null,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isRecording
                  ? colorScheme.error
                  : widget.isEnabled
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
              boxShadow: widget.isRecording
                  ? [
                      BoxShadow(
                        color: colorScheme.error.withValues(alpha: 0.4),
                        blurRadius: 20 * _pulseAnimation.value,
                        spreadRadius: 5 * _pulseAnimation.value,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              widget.isRecording ? Icons.mic : Icons.mic_none,
              size: 36,
              color: widget.isEnabled
                  ? colorScheme.onPrimary
                  : colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          );
        },
      ),
    );
  }
}
