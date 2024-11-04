import 'package:epilepsy_app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  
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
                  height: MediaQuery.of(context).size.height * 0.35,
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
                  child: signupforum(),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class signupforum extends StatefulWidget {
  const signupforum({super.key});

  @override
  State<signupforum> createState() => _signupforumState();
}

class _signupforumState extends State<signupforum> {
  bool _ischecked = false;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const Text('Create an Account'),
        const SizedBox(height: 60),
        const SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username'
            ),
          ),
        ),
        const SizedBox(height: 15),
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
        ElevatedButton(onPressed: () {}, style: const ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(200,50))),child: const Text('Sign In'),),
        const SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _ischecked, 
              onChanged: (value){
              setState(() {
                _ischecked = value!;
              });
            }),
            const SizedBox(width: 1),
            const Text('by clicking this u accept bla bla..'), 
           /* GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Sign Up',style: TextStyle(color: Colors.lightBlue)),
            )*/ // Terms and services
          ]
        ),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You already have an acoount ?'),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Sign In',style: TextStyle(color: Colors.lightBlue)),
            )
          ],
        ), 
      ],
    );
  }
}