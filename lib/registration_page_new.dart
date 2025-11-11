import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/constant/app_colors.dart';
import 'package:flutter_application_1/constant/text_style_values.dart';
import 'package:flutter_application_1/bloc/auth_bloc.dart';
import 'user_info_page.dart';

class RegistrationPageNew extends StatefulWidget {
  const RegistrationPageNew({super.key});

  @override
  State<RegistrationPageNew> createState() => _RegistrationPageNewState();
}

class _RegistrationPageNewState extends State<RegistrationPageNew> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final storyCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

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
    super.dispose();
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'name_required'.tr();
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'email_required'.tr();
    if (!v.contains('@')) return 'email_invalid'.tr();
    final emailReg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailReg.hasMatch(v.trim())) return 'email_invalid'.tr();
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.isEmpty) return 'phone_required'.tr();
    if (!v.startsWith('+7')) return 'phone_must_start'.tr();
    if (!RegExp(r'^\+7\d{10}$').hasMatch(v)) return 'phone_invalid'.tr();
    return null;
  }

  String? _validatePass(String? v) {
    if (v == null || v.isEmpty) return 'pass_required'.tr();
    if (v.length < 6) return 'pass_length'.tr();
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v != passCtrl.text) return 'pass_not_match'.tr();
    return null;
  }

  
  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterSubmitted(
              name: nameCtrl.text.trim(),
              phone: phoneCtrl.text.trim(),
              email: emailCtrl.text.trim(),
              story: storyCtrl.text.trim(),
              password: passCtrl.text,
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
      prefixIcon: Icon(icon, color: AppColors.azure),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: AppColors.gray),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => UserInfoPage(
                name: state.name,
                phone: state.phone,
                email: state.email,
                story: state.story,
              ),
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.creamColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor, 
          title: Text(
            'title'.tr(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            
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
                  textInputAction: TextInputAction.next,
                  decoration: _boxDecoration(
                    label: 'full_name'.tr(),
                    icon: Icons.person_outline,
                    helper: 'example_name'.tr(),
                  ),
                  validator: _validateName,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: _boxDecoration(
                    label: 'phone_number'.tr(),
                    icon: Icons.phone_outlined,
                    helper: 'phone_format'.tr(),
                    hint: '+7XXXXXXXXXX',
                  ),
                  validator: _validatePhone,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: _boxDecoration(
                    label: 'email_address'.tr(),
                    icon: Icons.email_outlined,
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: storyCtrl,
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  decoration: _boxDecoration(
                    label: 'life_story'.tr(),
                    icon: Icons.notes_outlined,
                    helper: 'story_hint'.tr(),
                  ),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: passCtrl,
                  obscureText: _hidePass,
                  textInputAction: TextInputAction.next,
                  decoration: _boxDecoration(
                    label: 'password'.tr(),
                    icon: Icons.lock_outline,
                    suffix: IconButton(
                      onPressed: () => setState(() => _hidePass = !_hidePass),
                      icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.indigoColor,
                      ),
                    ),
                  ),
                  validator: _validatePass,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: confirmCtrl,
                  obscureText: _hideConfirm,
                  textInputAction: TextInputAction.done,
                  decoration: _boxDecoration(
                    label: 'confirm_pass'.tr(),
                    icon: Icons.lock_reset_outlined,
                    suffix: IconButton(
                      onPressed: () => setState(() => _hideConfirm = !_hideConfirm),
                      icon: Icon(
                        _hideConfirm ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.indigoColor,
                      ),
                    ),
                  ),
                  validator: _validateConfirm,
                ),

                const SizedBox(height: 24),

                
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final loading = state is AuthLoading;
                    return SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary, 
                          foregroundColor: Colors.black,         
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: loading ? null : _submit,
                        child: loading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text('submit_form'.tr()),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                Center(
                  child: Column(
                    children: [
                      Text('change_lang'.tr(), style: AppTextStyles.superSmall),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.confirmed,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () => context.setLocale(const Locale('en')),
                            child: Text('EN', style: AppTextStyles.superSmall),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.tertiary,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () => context.setLocale(const Locale('ru')),
                            child: Text('RU', style: AppTextStyles.superSmall),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
