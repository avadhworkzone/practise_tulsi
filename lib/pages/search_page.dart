import 'package:flutter/material.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/config/appColor.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearchHeader(),
        const SizedBox(height: 24),
        _buildSearchContent(),
      ],
    );
  }

  Widget _buildSearchHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Search', style: AppTextStyle.heading.copyWith(color: AppColor.primaryColor)),
        const SizedBox(height: 8),
        Text('Find services, payments, and contacts', style: AppTextStyle.body),
      ],
    );
  }

  Widget _buildSearchContent() {
    return Column(
      children: [
        // Placeholder for search functionality
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Search functionality coming soon'),
          ),
        ),
      ],
    );
  }
}