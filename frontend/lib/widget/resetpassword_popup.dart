import 'package:flutter/material.dart';

class ResetPasswordPopup extends StatefulWidget {
  const ResetPasswordPopup({super.key});

  @override
  State<ResetPasswordPopup> createState() => _ResetPasswordPopupState();
}

class _ResetPasswordPopupState extends State<ResetPasswordPopup> {
      final formKey = GlobalKey<FormState>();
    final tokenCtl = TextEditingController();
    final passCtl = TextEditingController();
    bool obscure = true;
    bool loading = false;

  @override
  void dispose() {
    tokenCtl.dispose();
    passCtl.dispose();
    super.dispose();
  }

  void _onCancel() => Navigator.of(context).pop(null);

  void _onReset() {
    if (formKey.currentState!.validate()) {
      final token = tokenCtl.text.trim();
      final pass = passCtl.text.trim();
      Navigator.of(context).pop({
        'token': token,
        'pass': pass,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset Password'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: SizedBox(
            width: 360,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tokenCtl,
                  decoration: const InputDecoration(labelText: 'Reset Token'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please enter reset token(abcABC)'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passCtl,
                  keyboardType: TextInputType.text,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please enter new Password';
                    }
                    return null;
                  },
                  obscureText: obscure,
                    decoration: InputDecoration(
                      labelText: 'New password',
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          obscure = !obscure;
                        }),
                        icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: _onCancel, child: const Text('Cancel')),
        FilledButton(onPressed: _onReset, child: const Text('Reset')),
      ],
    );
  }
}
