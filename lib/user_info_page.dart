import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/constant/app_colors.dart';
import 'package:flutter_application_1/constant/text_style_values.dart';

class UserInfoPage extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String story;

  const UserInfoPage({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamColor,
      appBar: AppBar(
        title: Text('user_info'.tr(), style: AppTextStyles.px12Blue),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info('name'.tr(), name),
            _info('phone'.tr(), phone),
            _info('email'.tr(), email),
            const SizedBox(height: 10),
            Text('story'.tr(),
                style: AppTextStyles.px12Blue.copyWith(fontWeight: FontWeight.bold)),
            Text(story.isEmpty ? '-' : story, style: AppTextStyles.superSmall),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ',
              style: AppTextStyles.px12Blue.copyWith(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value.isEmpty ? '-' : value, style: AppTextStyles.superSmall)),
        ],
      ),
    );
  }
}
