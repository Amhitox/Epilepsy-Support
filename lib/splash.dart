import 'package:epilepsy_app/login.dart';
import 'package:epilepsy_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Splash.png'),
                  fit: BoxFit.cover,
                ),
              ),),
            Align(alignment: const Alignment(0, -1),child: Image.asset('assets/images/Home Indicator.png')),
            const Align(
              alignment: Alignment(0, 0.3),
              child: Text('Track it, Control it\nLive it',style: TextStyle(color: Colors.black,fontSize: 30),textAlign: TextAlign.center,),
            ),
            Align(alignment: const Alignment(0, 0.6),child: ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));}, style: ElevatedButton.styleFrom(fixedSize: const Size(240, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),padding: const EdgeInsets.all(14),backgroundColor: Colors.tealAccent),child: const Text('Sign In'))),
            Align(alignment: const Alignment(0, 0.8),child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account ? '),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  child: const Text('Sign Up',style: TextStyle(color: Colors.tealAccent),),
                )
              ],
            ),)
          ],
        ),
      )
    );
  }
}