import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/perfil_provider.dart';

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _senhaController;
  bool _obscureSenha = true;

  final List<String> _preferencias = [
    'Vegetariano',
    'Sem glúten',
    'Sem lactose',
    'Low carb',
    'Vegano',
  ];

  final Set<String> _selecionadas = {};
  bool _dadosCarregados = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dadosCarregados) {
      final perfil = context.read<PerfilProvider>();
      _nomeController.text = perfil.nome;
      _emailController.text = perfil.email;
      _senhaController.text = perfil.senha;
      _selecionadas.addAll(perfil.preferencias);
      _dadosCarregados = true;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    final perfil = context.read<PerfilProvider>();
    await perfil.salvarDados(
      nome: _nomeController.text,
      email: _emailController.text,
      senha: _senhaController.text,
      preferencias: _selecionadas,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil salvo com sucesso!'),
          backgroundColor: Color(0xFF2E7D32),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
          'Editar perfil',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              _buildAvatar(isDark),
              const SizedBox(height: 32),
              _buildTextField(
                label: 'Nome',
                controller: _nomeController,
                textColor: textColor,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'E-mail',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textColor: textColor,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Senha',
                controller: _senhaController,
                obscureText: _obscureSenha,
                textColor: textColor,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureSenha ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureSenha = !_obscureSenha;
                    });
                  },
                ),
              ),
              const SizedBox(height: 28),
              _buildSectionTitle('Preferências alimentares', textColor),
              const SizedBox(height: 12),
              _buildChips(isDark, textColor),
              const SizedBox(height: 40),
              _buildSaveButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Color textColor,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4CAF50)),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Align(
      alignment: Alignment.centerLeft,
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

  Widget _buildChips(bool isDark, Color textColor) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _preferencias.map((pref) {
        final isSelected = _selecionadas.contains(pref);
        return ChoiceChip(
          label: Text(pref),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selecionadas.add(pref);
              } else {
                _selecionadas.remove(pref);
              }
            });
          },
          selectedColor: const Color(0xFFE8F5E9),
          backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
          labelStyle: TextStyle(
            color: isSelected ? const Color(0xFF2E7D32) : textColor,
            fontSize: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? const Color(0xFF2E7D32) : Colors.grey.shade300,
            ),
          ),
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _salvar,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text('Salvar alterações'),
      ),
    );
  }
}
