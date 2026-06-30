import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Categories"),
        centerTitle: true,
      ),

      body: FutureBuilder<List<Category>>(
        future: apiService.getCategories(),

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final categories = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: categories.length,

            itemBuilder: (context, index) {
              final category = categories[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),

                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.quiz),
                  ),

                  title: Text(category.name),

                  subtitle: Text(category.description),

                  trailing: const Icon(Icons.arrow_forward_ios),

                  onTap: () {
                    // Next Step
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}