import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/avatar_provider.dart'; // Importa el AvatarProvider
import '../widgets/avatar_preview.dart'; // Importa el widget de vista previa del avatar
import '../widgets/clothing_selector.dart'; // Importa el selector de ropa

class CustomizeAvatarScreen extends StatelessWidget {
  final String userId;

  const CustomizeAvatarScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final avatarProvider = Provider.of<AvatarProvider>(context); // Obtén el AvatarProvider

    return Scaffold(
      appBar: AppBar(title: const Text('Personalizar Avatar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AvatarPreview(avatarData: avatarProvider.avatarData),
            const SizedBox(height: 20),
            ClothingSelector(
              onClothingSelected: (clothing) {
                avatarProvider.saveAvatar(userId, {
                  ...avatarProvider.avatarData,
                  'clothing': clothing,
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}