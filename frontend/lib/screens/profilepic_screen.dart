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
  bool isLoading = false;

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

            const Text(
              'Pick an Avatar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
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
                  onTap: isLoading
                      ? null
                      : () {
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

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isLoading ? null : createAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
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

  Future<void> createAccount() async {
    setState(() {
      isLoading = true;
    });

    try {
      final signupNotifier = ref.read(signupProvider.notifier);
      signupNotifier.setPfp(avatars[selectedIndex].id);
      final signupData = ref.read(signupProvider);
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.signOut();
      ref.read(userProvider.notifier).logout();
      final signupResult = await authRepo.signup(signupData);
      if (!mounted) return;

      if (signupResult['success'] != true) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              signupResult['message'] ?? 'Could not create account',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final loginResult = await authRepo.signin(
        email: signupData.email,
        password: signupData.password,
      );
      if (!mounted) return;
      if (loginResult['success'] != true) {
        await authRepo.signOut();
        ref.read(userProvider.notifier).logout();
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loginResult['message'] ?? 'Account was created but login failed',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final user = await authRepo.getUserData();
      if (!mounted) return;
      if (user == null) {
        await authRepo.signOut();
        ref.read(userProvider.notifier).logout();
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account was created but the session could not be verified',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      ref.read(userProvider.notifier).setUser(user);
      ref.read(signupProvider.notifier).reset();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
