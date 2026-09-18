import 'package:flutter/material.dart';


class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(
            icon: Icons.remove,
            onTap: onDecrease,
            tooltip: 'Decrease quantity',
            scheme: scheme,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 34),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          _button(
            icon: Icons.add,
            onTap: onIncrease,
            tooltip: 'Increase quantity',
            scheme: scheme,
          ),
        ],
      ),
    );
  }

  Widget _button({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
    required ColorScheme scheme,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Icon(icon, size: 18, color: scheme.onSurface),
        ),
      ),
    );
  }
}
