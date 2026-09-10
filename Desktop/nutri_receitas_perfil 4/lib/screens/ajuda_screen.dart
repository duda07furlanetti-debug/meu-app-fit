import 'package:flutter/material.dart';

class AjudaScreen extends StatelessWidget {
  const AjudaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Ajuda',
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
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Perguntas frequentes',
            textColor: textColor,
          ),
          _buildMenuItem(
            icon: Icons.chat_bubble_outline,
            title: 'Fale conosco',
            textColor: textColor,
          ),
          _buildMenuItem(
            icon: Icons.bug_report_outlined,
            title: 'Reportar um problema',
            textColor: textColor,
          ),
          _buildMenuItem(
            icon: Icons.video_library_outlined,
            title: 'Tutoriais em vídeo',
            textColor: textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color textColor,
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
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade400,
      ),
    );
  }
}
