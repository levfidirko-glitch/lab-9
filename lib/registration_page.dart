import 'package:flutter/material.dart';
import 'user_info_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final storyCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final storyFocus = FocusNode();
  final passFocus = FocusNode();
  final confirmFocus = FocusNode();

  bool _hidePass = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    storyCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    storyFocus.dispose();
    passFocus.dispose();
    confirmFocus.dispose();
    super.dispose();
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final emailReg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailReg.hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.isEmpty) return 'Phone is required';
    if (!RegExp(r'^\d{10,15}$').hasMatch(v)) {
      return 'Digits only (10-15)';
    }
    return null;
  }

  String? _validatePass(String? v) {
    if (v == null || v.isEmpty) return 'Password required';
    if (v.length < 6) return 'At least 6 characters';
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v != passCtrl.text) return 'Passwords do not match';
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserInfoPage(
            name: nameCtrl.text.trim(),
            phone: phoneCtrl.text.trim(),
            email: emailCtrl.text.trim(),
            story: storyCtrl.text.trim(),
          ),
        ),
      );
    }
  }

  InputDecoration _boxDecoration({
    required String label,
    required IconData icon,
    String? helper,
    String? hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helper,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4), 
        borderSide: const BorderSide(color: Colors.black12),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            'Register Form',
            style: TextStyle(
              color: Colors.yellowAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: nameCtrl,
                 focusNode: nameFocus,
                  textInputAction: TextInputAction.next,
                  decoration: _boxDecoration(
                  label: 'Full Name *',
                  icon: Icons.person_outline,          
                  helper: 'Example:Lev Fidirko',
                ),
                validator: _validateName,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(phoneFocus),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneCtrl,
                focusNode: phoneFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: _boxDecoration(
                  label: 'Phone Number *',
                  icon: Icons.phone_outlined,
                  helper: 'Phone format: 0XX0XXX-XXXX',
                ),
                validator: _validatePhone,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(emailFocus),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailCtrl,
                focusNode: emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: _boxDecoration(
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                ),
                validator: _validateEmail,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(storyFocus),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: storyCtrl,
                focusNode: storyFocus,
                maxLines: 3,
                textInputAction: TextInputAction.newline,
                decoration: _boxDecoration(
                  label: 'Life Story',
                  icon: Icons.notes_outlined,
                  helper: 'Keep it short, this is just a demo',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passCtrl,
                focusNode: passFocus,
                obscureText: _hidePass,
                textInputAction: TextInputAction.next,
                decoration: _boxDecoration(
                  label: 'Password *',
                  icon: Icons.lock_outline,
                  suffix: IconButton(
                    onPressed: () => setState(() => _hidePass = !_hidePass),
                    icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: _validatePass,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(confirmFocus),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: confirmCtrl,
                focusNode: confirmFocus,
                obscureText: _hideConfirm,
                textInputAction: TextInputAction.done,
                decoration: _boxDecoration(
                  label: 'Confirm Password *',
                  icon: Icons.lock_reset_outlined,
                  suffix: IconButton(
                    onPressed: () =>
                        setState(() => _hideConfirm = !_hideConfirm),
                    icon: Icon(_hideConfirm
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                validator: _validateConfirm,
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent, 
                    foregroundColor: Colors.black, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), 
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    'Submit Form',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
