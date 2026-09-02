import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/avatars.dart';
import 'package:frontend/providers/signup_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/providers/auth_repository_provider.dart';

class ProfilePic extends ConsumerStatefulWidget {
  const ProfilePic({super.key});

  @override
  ConsumerState<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends ConsumerState<ProfilePic> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Avatar',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                avatars[selectedIndex].asset,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),
            Text(
              'Pick an Avatar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight(400),
              ),
            ),
            const SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),

              itemCount: avatars.length,

              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.red, width: 3)
                          : null,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: ClipOval(
                      child: Image.asset(
                        avatars[index].asset,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  ref
                      .read(signupProvider.notifier)
                      .setPfp(avatars[selectedIndex].id);
                  final signupData = ref.read(signupProvider);
                  final authRepo = ref.read(authRepositoryProvider);

                  final result = await authRepo.signup(signupData);
                  if (!context.mounted) return;
                  if (!result['success']) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(result['message'])));
                    return;
                  }
                  final loginResult = await authRepo.signin(
                    email: signupData.email,
                    password: signupData.password,
                  );
                  if (!loginResult['success']) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loginResult['message'])),
                    );
                    return;
                  }
                  await ref.read(userProvider.notifier).getUserData();
                },
                style:
                    ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ).copyWith(
                      overlayColor: WidgetStateProperty.all(
                        Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
