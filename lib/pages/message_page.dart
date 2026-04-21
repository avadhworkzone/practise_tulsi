import 'package:flutter/material.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/config/appColor.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMessageHeader(),
        const SizedBox(height: 24),
        _buildMessageContent(),
      ],
    );
  }

  Widget _buildMessageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Messages', style: AppTextStyle.heading.copyWith(color: AppColor.primaryColor)),
        const SizedBox(height: 8),
        Text('Check your inbox and notifications', style: AppTextStyle.body),
      ],
    );
  }

  Widget _buildMessageContent() {
    return Column(
      children: [
        // Placeholder for message functionality
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Message functionality coming soon'),
          ),
        ),
      ],
    );
  }
}