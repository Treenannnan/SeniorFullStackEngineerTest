import 'package:flutter/material.dart';

class SettingPopup extends StatefulWidget {
  const SettingPopup({super.key});

  @override
  State<SettingPopup> createState() => _SettingPopupState();
}

class _SettingPopupState extends State<SettingPopup> {
  final formKey = GlobalKey<FormState>();
  final _hostCtl = TextEditingController(text: '10.0.2.2');
  final _portCtl = TextEditingController(text: '50051');

  @override
  void dispose() {
    _hostCtl.dispose();
    _portCtl.dispose();
    super.dispose();
  }

  void _onCancel() => Navigator.of(context).pop(null);

  void _onConnect() {
    if (formKey.currentState!.validate()) {
      final host = _hostCtl.text.trim();
      final port = _portCtl.text.trim();
      Navigator.of(context).pop({
        'host': host,
        'port': port,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Setting'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: SizedBox(
            width: 360,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _hostCtl,
                  decoration: const InputDecoration(labelText: 'Host'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please enter host address'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _portCtl,
                  decoration: const InputDecoration(labelText: 'Port'),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please enter port';
                    }
                    final n = int.tryParse(v);
                    if (n == null || n <= 0 || n > 65535) return 'Invalid port';
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: _onCancel, child: const Text('Cancel')),
        FilledButton(onPressed: _onConnect, child: const Text('Connect')),
      ],
    );
  }
}