import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.menu_book,
            color: AppColors.white,
          ),
        ),
        title: Text(category.name, style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.bold,
        )),
        subtitle: Text(
          category.description,
          style: AppTextStyles.subtitle,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
