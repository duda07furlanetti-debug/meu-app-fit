import 'package:flutter/material.dart';

class TermosScreen extends StatelessWidget {
  const TermosScreen({super.key});

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
          'Termos de uso',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Aceitação dos termos', textColor),
            _buildParagraph(
              'Ao acessar e utilizar o NutriReceitas, você concorda em cumprir estes termos de uso e todas as leis e regulamentos aplicáveis.',
            ),
            _buildSectionTitle('2. Uso do aplicativo', textColor),
            _buildParagraph(
              'O NutriReceitas destina-se ao uso pessoal e não comercial. Você concorda em não utilizar o aplicativo para fins ilegais ou não autorizados.',
            ),
            _buildSectionTitle('3. Conta do usuário', textColor),
            _buildParagraph(
              'Para utilizar algumas funcionalidades, pode ser necessário criar uma conta. Você é responsável por manter a confidencialidade de suas credenciais.',
            ),
            _buildSectionTitle('4. Privacidade', textColor),
            _buildParagraph(
              'Suas informações pessoais são tratadas de acordo com nossa Política de Privacidade. Ao utilizar o app, você concorda com a coleta e uso de suas informações.',
            ),
            _buildSectionTitle('5. Modificações', textColor),
            _buildParagraph(
              'Reservamos o direito de modificar estes termos a qualquer momento. As alterações entram em vigor após a publicação no aplicativo.',
            ),
            _buildSectionTitle('6. Contato', textColor),
            _buildParagraph(
              'Em caso de dúvidas sobre estes termos, entre em contato pelo e-mail contato@nutrireceitas.com.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade700,
        height: 1.5,
      ),
    );
  }
}
