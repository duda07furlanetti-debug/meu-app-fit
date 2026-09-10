import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/perfil_provider.dart';
import 'editar_perfil_screen.dart';
import 'notificacoes_screen.dart';
import 'configuracoes_screen.dart';
import 'ajuda_screen.dart';
import 'sobre_screen.dart';
import 'termos_screen.dart';
import '../widgets/app_bottom_nav.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final perfilProvider = context.read<PerfilProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              perfilProvider.limparDados();
            },
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final perfil = context.watch<PerfilProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildAvatar(isDark),
              const SizedBox(height: 16),
              Text(
                perfil.nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                perfil.email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              _buildEditButton(context),
              const SizedBox(height: 32),
              _buildSectionTitle('Minha conta', textColor),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Dados pessoais',
                textColor: textColor,
                onTap: () => _navigateTo(context, const EditarPerfilScreen()),
              ),
              _buildMenuItem(
                icon: Icons.grid_view_outlined,
                title: 'Preferências alimentares',
                textColor: textColor,
                onTap: () => _navigateTo(context, const EditarPerfilScreen()),
              ),
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notificações',
                textColor: textColor,
                onTap: () => _navigateTo(context, const NotificacoesScreen()),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Aplicativo', textColor),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Configurações',
                textColor: textColor,
                onTap: () => _navigateTo(context, const ConfiguracoesScreen()),
              ),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Ajuda',
                textColor: textColor,
                onTap: () => _navigateTo(context, const AjudaScreen()),
              ),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'Sobre o NutriReceitas',
                textColor: textColor,
                onTap: () => _navigateTo(context, const SobreScreen()),
              ),
              _buildMenuItem(
                icon: Icons.description_outlined,
                title: 'Termos de uso',
                textColor: textColor,
                onTap: () => _navigateTo(context, const TermosScreen()),
              ),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  Widget _buildAvatar(bool isDark) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.camera_alt_outlined,
        size: 40,
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton.icon(
        onPressed: () => _navigateTo(context, const EditarPerfilScreen()),
        icon: const Icon(Icons.check_circle, size: 18),
        label: const Text('Editar perfil'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE8F5E9),
          foregroundColor: const Color(0xFF2E7D32),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: textColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _showLogoutDialog(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text('Sair'),
      ),
    );
  }
}
