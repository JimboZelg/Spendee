import 'package:flutter/material.dart';

class ClothingSelector extends StatelessWidget {
  final Function(String) onClothingSelected;

  const ClothingSelector({super.key, required this.onClothingSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Selecciona tu ropa', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            _ClothingOption(
              label: 'Camisa',
              onSelected: () => onClothingSelected('Camisa'),
            ),
            _ClothingOption(
              label: 'Vestido',
              onSelected: () => onClothingSelected('Vestido'),
            ),
            _ClothingOption(
              label: 'Chaqueta',
              onSelected: () => onClothingSelected('Chaqueta'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ClothingOption extends StatelessWidget {
  final String label;
  final VoidCallback onSelected;

  const _ClothingOption({required this.label, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: false,
      onSelected: (selected) => onSelected(),
    );
  }
}