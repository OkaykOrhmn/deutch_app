import 'package:cached_network_image/cached_network_image.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:deutch_app/ui/widgets/loading/primary_loading.dart';
import 'package:flutter/material.dart';

class PrimaryNetworkImage extends StatelessWidget {
  final String src;
  const PrimaryNetworkImage({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: DesignConfig.highBorderRadius,
      child: CachedNetworkImage(
        imageUrl: src,
        placeholder: (context, url) => PrimaryLoading(
          size: 18,
          color: Theme.of(context).black(),
        ),
        errorWidget: (context, url, error) {
          return const Center(
            child: Icon(Icons.image),
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
