import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newapp/resources/authentication.dart';
import 'package:newapp/screens/signup.dart';
import 'package:newapp/textfieldinput.dart';
import 'package:newapp/utils/colors.dart';
import 'package:newapp/utils/utils.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import 'package:newapp/utils/global_variable.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async
  {
    setState(() {
      _isLoading= true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if(res== "success")
      {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context)=> const ResponsiveLayout(
                  mobileScreenLayout:MobileScreenLayout(),
                  webScreenLayout:WebScreenLayout(),
                )
            ),
            (route)=>false);

        setState(() {
          _isLoading = false;
        });
      }else{setState(() {
      _isLoading= false;
    });
      showSnackBar(res, context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SafeArea(
        child:Container(
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
                : const EdgeInsets.symmetric(horizontal: 32),
          width:double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child:Container(),
                  flex:2),
        Center(child:Text('Welcome Back To Crogram', style: GoogleFonts.courgette(fontSize: 40),
        )),
        const SizedBox(height:14),

              TextFieldInput(
                hintText: 'Enter Your Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              SizedBox(height: 25,),
              TextFieldInput(
                hintText: 'Enter Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              SizedBox(height: 25,),
              InkWell(

                child:Container(
                  child:_isLoading? const Center(
                    child:CircularProgressIndicator(),)
                      :const Text('Login'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(4),
                        ),
                    ),
                  color: blueColor,
                ),
                ),
                  onTap:loginUser,
              ),

              SizedBox(height: 12,),
              Flexible(child:Container(), flex:2),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Do You Have An Account?'
                    ),
                    padding: const EdgeInsets.symmetric(vertical:8 ),
                  ),
                 GestureDetector(
                   onTap:()=>Navigator.of(context).push( MaterialPageRoute(
                     builder: (context) => const SignUpScreen(),
                   ),
                   ),
                   child: Container(
                    child: const Text(
                        'SignUp', style: TextStyle(
                        fontWeight: FontWeight.bold)
                    ),
                    padding: const EdgeInsets.symmetric(vertical:8 ),
                  )
                 )
                ],
              )

            ],
          )
        )
      ),
    );
  }
}
