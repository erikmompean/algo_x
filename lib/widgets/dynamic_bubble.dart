import 'package:crypto_x/widgets/app_text.dart';
import 'package:flutter/material.dart';

class DynamicBubble extends StatefulWidget {
  final String text;
  const DynamicBubble({super.key, required this.text});

  @override
  State<DynamicBubble> createState() => _DynamicBubbleState();
}

class _DynamicBubbleState extends State<DynamicBubble>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationController.repeat(reverse: true);

    // _animationController.addListener(() {
    //   print(_animationController.value * 100);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        var value = 100 + (_animationController.value * 20);
        print(value);
        return Container(
          width: value,
          height: value,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: AppText(text: widget.text),
        );
      },
      // child: Container(
      //   width: 100.0,
      //   height: 100.0,
      //   decoration: const BoxDecoration(
      //     color: Colors.orange,
      //     shape: BoxShape.circle,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
