import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/custom_button.dart';
import '../widget/custom_card.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
  padding: const EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      /// Top Profile Section
      Center(
        child: Column(
          children: [

            Hero(
              tag: "profile",
              child: CircleAvatar(
                radius: 55,
                backgroundColor: AppColors.primary.withOpacity(.12),
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child: user?.photoURL == null
                    ? const Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.primary,
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              user?.displayName ?? "Guest",
              style: AppTextStyles.title,
            ),

            const SizedBox(height: 6),

            Text(
              user?.email ?? "",
              style: AppTextStyles.subtitle,
            ),
          ],
        ),
      ),

      const SizedBox(height: 35),

      const Text(
        "Quick Info",
        style: AppTextStyles.heading,
      ),

      const SizedBox(height: 15),

      Row(
        children: [

          Expanded(
            child: CustomCard(
              child: Column(
                children: const [
                  Icon(
                    Icons.verified_user,
                    size: 35,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Google",
                    style: AppTextStyles.heading,
                  ),
                  Text(
                    "Login",
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: CustomCard(
              child: Column(
                children: const [
                  Icon(
                    Icons.workspace_premium,
                    size: 35,
                    color: Colors.amber,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Quiz",
                    style: AppTextStyles.heading,
                  ),
                  Text(
                    "Learner",
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 30),

      const Text(
        "Account Information",
        style: AppTextStyles.heading,
      ),

      const SizedBox(height: 15),

      CustomCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: const Icon(
            Icons.email,
            color: AppColors.primary,
          ),
          title: const Text("Email"),
          subtitle: Text(user?.email ?? ""),
        ),
      ),

      const SizedBox(height: 12),

      CustomCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: const Icon(
            Icons.person,
            color: AppColors.primary,
          ),
          title: const Text("Display Name"),
          subtitle: Text(user?.displayName ?? ""),
        ),
      ),

      const SizedBox(height: 12),

      CustomCard(
        padding: EdgeInsets.zero,
        child: const ListTile(
          leading: Icon(
            Icons.lock,
            color: AppColors.primary,
          ),
          title: Text("Authentication"),
          subtitle: Text("Google Sign In"),
        ),
      ),

      const SizedBox(height: 40),

      CustomButton(
        text: "Logout",
        icon: Icons.logout,
        backgroundColor: AppColors.danger,
        onPressed: () async {
          await authService.signOut();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => LoginScreen(),
            ),
            (route) => false,
          );
        },
      ),
    ],
  ),
),
    );
  }
}
