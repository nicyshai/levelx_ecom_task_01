import 'package:flutter/material.dart';


class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.backgroundColor,
  });

  final String? url;
  final BoxFit fit;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? scheme.surfaceContainerHighest;

    if (url == null || url!.isEmpty) {
      return _placeholder(bg, scheme);
    }

    return Container(
      color: bg,
      child: Image.network(
        url!,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            _placeholder(bg, scheme),
      ),
    );
  }

  Widget _placeholder(Color bg, ColorScheme scheme) => Container(
        color: bg,
        alignment: Alignment.center,
        child: Icon(Icons.image_not_supported_outlined,
            color: scheme.outline, size: 32),
      );
}
