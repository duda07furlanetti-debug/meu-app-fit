import 'package:flutter/material.dart';

class NotificacoesScreen extends StatefulWidget {
  const NotificacoesScreen({super.key});

  @override
  State<NotificacoesScreen> createState() => _NotificacoesScreenState();
}

class _NotificacoesScreenState extends State<NotificacoesScreen> {
  bool _receitas = true;
  bool _favoritos = true;
  bool _promocoes = false;
  bool _lembretes = true;

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
          'Notificações',
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
          _buildSectionTitle('Notificações push', textColor),
          _buildSwitchItem(
            title: 'Novas receitas',
            subtitle: 'Receba alertas quando houver novas receitas',
            value: _receitas,
            textColor: textColor,
            onChanged: (value) => setState(() => _receitas = value),
          ),
          _buildSwitchItem(
            title: 'Favoritos',
            subtitle: 'Notificações sobre receitas favoritadas',
            value: _favoritos,
            textColor: textColor,
            onChanged: (value) => setState(() => _favoritos = value),
          ),
          _buildSwitchItem(
            title: 'Promoções e novidades',
            subtitle: 'Fique por dentro das novidades do app',
            value: _promocoes,
            textColor: textColor,
            onChanged: (value) => setState(() => _promocoes = value),
          ),
          _buildSwitchItem(
            title: 'Lembretes diários',
            subtitle: 'Lembretes para acessar o app',
            value: _lembretes,
            textColor: textColor,
            onChanged: (value) => setState(() => _lembretes = value),
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

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required bool value,
    required Color textColor,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF2E7D32),
          ),
        ],
      ),
    );
  }
}
