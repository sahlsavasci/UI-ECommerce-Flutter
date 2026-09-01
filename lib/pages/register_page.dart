import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun', style: TextStyle(color: Colors.white)), backgroundColor: AppTheme.primary, iconTheme: const IconThemeData(color: Colors.white)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text('Buat Akun Baru', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 4),
                Text('Isi data diri untuk mulai berbelanja', style: TextStyle(color: AppTheme.textSecondary)),
                const SizedBox(height: 28),
                CustomTextField(controller: _nameController, labelText: 'Nama Lengkap', prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama tidak boleh kosong' : null),
                const SizedBox(height: 14),
                CustomTextField(controller: _emailController, labelText: 'Email', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email tidak boleh kosong';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) return 'Email tidak valid';
                    return null;
                  }),
                const SizedBox(height: 14),
                CustomTextField(controller: _passwordController, labelText: 'Password', prefixIcon: Icons.lock_outline, isPassword: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password tidak boleh kosong';
                    if (v.length < 6) return 'Password minimal 6 karakter';
                    return null;
                  }),
                const SizedBox(height: 28),
                CustomButton(text: 'Daftar', onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _isLoading = true);
                    await Future.delayed(const Duration(milliseconds: 500));
                    setState(() => _isLoading = false);
                    if (context.mounted) {
                      await Provider.of<AuthProvider>(context, listen: false).register(
                        _nameController.text.trim(), _emailController.text.trim(), _passwordController.text);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pendaftaran berhasil! Silakan login.')));
                        Navigator.pop(context);
                      }
                    }
                  }
                }, isLoading: _isLoading),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya akun? ', style: TextStyle(color: AppTheme.textSecondary)),
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Login', style: TextStyle(fontWeight: FontWeight.w600))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
