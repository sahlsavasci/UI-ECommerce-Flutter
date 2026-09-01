import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() { _current.dispose(); _new.dispose(); _confirm.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Password', style: TextStyle(color: Colors.white)), backgroundColor: AppTheme.primary, iconTheme: const IconThemeData(color: Colors.white)),
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('Ubah Kata Sandi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          const SizedBox(height: 4),
          Text('Pastikan password baru aman dan berbeda', style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 28),
          CustomTextField(controller: _current, labelText: 'Password Saat Ini', prefixIcon: Icons.lock_outline, isPassword: true,
            validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null),
          const SizedBox(height: 14),
          CustomTextField(controller: _new, labelText: 'Password Baru', prefixIcon: Icons.lock_clock, isPassword: true,
            validator: (v) { if (v == null || v.isEmpty) return 'Wajib diisi'; if (v.length < 6) return 'Minimal 6 karakter'; return null; }),
          const SizedBox(height: 14),
          CustomTextField(controller: _confirm, labelText: 'Konfirmasi Password', prefixIcon: Icons.lock_reset, isPassword: true,
            validator: (v) { if (v == null || v.isEmpty) return 'Wajib diisi'; if (v != _new.text) return 'Password tidak cocok'; return null; }),
          const SizedBox(height: 28),
          CustomButton(text: 'Simpan Password', onPressed: () {
            if (_formKey.currentState!.validate()) {
              final ctx = context;
              setState(() => _loading = true);
              Future.delayed(const Duration(milliseconds: 800), () {
                if (!ctx.mounted) return;
                setState(() => _loading = false);
                ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Password berhasil diubah!')));
                Navigator.pop(ctx);
              });
            }
          }, isLoading: _loading),
        ]),
      ))),
    );
  }
}
