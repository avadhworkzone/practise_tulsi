import 'package:flutter/material.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/config/appColor.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSettingHeader(),
        const SizedBox(height: 24),
        _buildSettingContent(),
      ],
    );
  }

  Widget _buildSettingHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: AppTextStyle.heading.copyWith(color: AppColor.primaryColor)),
        const SizedBox(height: 8),
        Text('Update your profile and app preferences', style: AppTextStyle.body),
      ],
    );
  }

  Widget _buildSettingContent() {
    return Column(
      children: [
        // Placeholder for setting functionality
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Setting functionality coming soon'),
          ),
        ),
      ],
    );
  }
}