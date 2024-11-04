import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});
  

@override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/design.svg',
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      const Align(alignment: Alignment(0,-0.5),child: Text('Epilepsy app',style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,)),
                    ]
                  ),
                ),
                const Align(
                  child: LoginForum(),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
class LoginForum extends StatefulWidget {
  const LoginForum({super.key});

  @override
  State<LoginForum> createState() => _LoginForumState();
}

class _LoginForumState extends State<LoginForum> {
  

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const Text('Welcome Back'),
        const SizedBox(height: 60),
        const SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email'
            ),
          ),
        ),
        const SizedBox(height: 15),
        const SizedBox(
          width: 250,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password'
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: (){},child: const Text('Sign In'),),
        const SizedBox(height: 15),
        const Text('Forgot Password'), //TO-DO make sure to verify this when u get to back-end
        const SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account ?'),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
              },
              child: const Text('Sign Up',style: TextStyle(color: Colors.lightBlue)),
            )
          ],
        ), 
      ],
    );
  }
}