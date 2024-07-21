// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryLoading extends StatefulWidget {
  final double size;
  final Color? color;
  const PrimaryLoading({super.key, required this.size, this.color});

  @override
  _PrimaryLoadingState createState() => _PrimaryLoadingState();
}

class _PrimaryLoadingState extends State<PrimaryLoading>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: widget.color ?? Colors.white,
        size: widget.size,
        controller: _controller,
      ),
    );
  }
}
