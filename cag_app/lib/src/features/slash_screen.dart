// import 'package:cag_app/Screens/welcome_screen.dart';
// import 'package:cag_app/theme/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cag_app/authProvider/auth_provider.dart';

// class SlashScreen extends ConsumerWidget {
//   const SlashScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Lắng nghe trạng thái Token
//     final authState = ref.watch(authCheckerProvider);

//     return Scaffold(
//       backgroundColor: AppTheme.darkBg,
//       body: authState.when(
//         loading: () => _buildSplashUI(),

//         error: (err, stack) => const WelcomeScreen(),

//         data: (role){
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (role != null) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => role == 'OWNER' 
//                       ? const OwnerHomeScreen()
//                       : const HomePageScreen(),
//                 ),
//               );
//             } else {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const WelcomeScreen()),
//               );
//             }
//           });
//           return _buildSplashUI();
//         }
//       ),
//     );
//   }

//   Widget _buildSplashUI() {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Image.asset(
//             'assets/welcome.png',
//             fit: BoxFit.cover,
//           ),
//         ),

//         Positioned.fill(
//           child: Container(
//             color: Colors.black.withOpacity(0.5),
//           )
//         ),

//         SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // loading indicator
//                 const CircularProgressIndicator(
//                   color: Colors.cyan,
//                   strokeWidth: 4,
//                 ),
//                 const SizedBox(height: 20),

//                 const Text(
//                   "Welcome to CAG App",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         )
//       ],
//     )
//   }
// }