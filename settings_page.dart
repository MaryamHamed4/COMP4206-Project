import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  String _currency = 'OMR';
  final List<String> _currencies = ['OMR', 'USD', 'EUR'];
  final LocalAuthentication _auth = LocalAuthentication();
  bool _biometricEnabled = false;

  final Color _primaryColor = Colors.teal;
  final TextStyle _labelStyle = GoogleFonts.poppins(fontSize: 16);

  Future<void> _authenticate() async {
    try {
      bool canCheck = await _auth.canCheckBiometrics;
      if (canCheck) {
        bool authenticated = await _auth.authenticate(
          localizedReason: 'Enable biometric security',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        setState(() => _biometricEnabled = authenticated);
      }
    } catch (e) {
      print("Biometric error: $e");
    }
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: _labelStyle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _currency,
      decoration: InputDecoration(labelText: "Currency", labelStyle: _labelStyle),
      items: _currencies.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
      onChanged: (val) => setState(() => _currency = val!),
    );
  }

  Widget _buildBiometricButton() {
    return ElevatedButton.icon(
      onPressed: _authenticate,
      icon: Icon(_biometricEnabled ? Icons.lock_open : Icons.fingerprint),
      label: Text(_biometricEnabled ? "Biometric Enabled" : "Enable Biometric"),
      style: ElevatedButton.styleFrom(backgroundColor: _primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: GoogleFonts.poppins()),
        backgroundColor: _primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile("Dark Mode", _darkMode, (value) {
            setState(() => _darkMode = value);
            // Optional: Apply dark mode globally with Provider or Theme
          }),
          _buildDropdownField(),
          const SizedBox(height: 20),
          _buildBiometricButton(),
        ],
      ),
    );
  }
}
