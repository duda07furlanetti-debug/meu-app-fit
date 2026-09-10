import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/buscar_screen.dart';
import '../screens/favoritos_screen.dart';
import '../screens/perfil_screen.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
  });

  void _navigateTo(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget screen;
    switch (index) {
      case 0:
        screen = const HomeScreen();
        break;
      case 1:
        screen = const BuscarScreen();
        break;
      case 2:
        screen = const FavoritosScreen();
        break;
      case 3:
        screen = const PerfilScreen();
        break;
      default:
        screen = const HomeScreen();
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(context, Icons.home_outlined, 'Início', 0),
              _buildItem(context, Icons.search_outlined, 'Buscar', 1),
              _buildItem(context, Icons.favorite_outline, 'Favoritos', 2),
              _buildItem(context, Icons.person, 'Perfil', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String label, int index) {
    final isSelected = index == currentIndex;
    final color = isSelected ? const Color(0xFF2E7D32) : Colors.grey;

    return GestureDetector(
      onTap: () => _navigateTo(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
