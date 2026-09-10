import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Configurações',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          _buildSectionTitle('Geral', textColor),
          _buildMenuItem(
            icon: Icons.language,
            title: 'Idioma',
            subtitle: 'Português (Brasil)',
            textColor: textColor,
          ),
          _buildMenuItem(
            icon: Icons.dark_mode_outlined,
            title: 'Tema escuro',
            textColor: textColor,
            trailing: Switch(
              value: isDark,
              onChanged: (_) => themeProvider.toggleTheme(),
              activeThumbColor: const Color(0xFF2E7D32),
            ),
          ),
          _buildMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Notificações',
            textColor: textColor,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Conta', textColor),
          _buildMenuItem(
            icon: Icons.lock_outline,
            title: 'Alterar senha',
            textColor: textColor,
          ),
          _buildMenuItem(
            icon: Icons.email_outlined,
            title: 'Alterar e-mail',
            textColor: textColor,
          ),
          _buildMenuItem(
            icon: Icons.delete_outline,
            title: 'Excluir conta',
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
    String? subtitle,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: textColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            )
          : null,
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
          ),
    );
  }
}
