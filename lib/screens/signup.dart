import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/resources/authentication.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import 'login.dart';
import 'package:newapp/utils/colors.dart';
import 'package:newapp/utils/global_variable.dart';
import 'package:newapp/textfieldinput.dart';
import 'package:newapp/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';




class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading= false;


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }


  void signUpUser() async {
    setState(() {
      _isLoading= true;
    });

    String res = await AuthMethods().signUpUser
      (
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    if (res == 'success') {
      setState(() {
        _isLoading=false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
    else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(res, context);
    }
    }
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SafeArea(
          child:Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              width:double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                  child: Container(),
            flex: 2,
                  ),
                  Center(child: Text('Sign Up To Crogram', style: GoogleFonts.courgette(fontSize: 40),
                  )),
                  const SizedBox(height:14),
                  Stack(
                    children: [
                      _image!=null?
                      CircleAvatar(
                  radius: 64,
                    backgroundImage: MemoryImage(_image!),
                        backgroundColor: Colors.red,
                  )
                     : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
'https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198?s=612x612'
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left:80,

                        child:IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,),),),
                    ],
                  ),
                  SizedBox(height: 15,),

                  TextFieldInput(
                    hintText: 'Enter Your Username',
                    textInputType: TextInputType.text,
                    textEditingController: _usernameController,
                  ),
                  SizedBox(height: 10,),
                  TextFieldInput(
                    hintText: 'Enter Your Email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                  SizedBox(height: 10,),
                  TextFieldInput(
                    hintText: 'Enter Password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                  SizedBox(height: 10,),
                  TextFieldInput(
                    hintText: 'Enter Your bio',
                    textInputType: TextInputType.text,
                    textEditingController: _bioController,
                  ),
                  SizedBox(height: 10,),
                  InkWell(

                    child:Container(
                      child:_isLoading?
                      const Center(child: CircularProgressIndicator(
                        color:primaryColor,
                      ),
                      )
                          :const Text('Signup'),
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
                    onTap: signUpUser,
                  ),
                  SizedBox(height: 12,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                            'ALready Have An Account?'
                        ),
                        padding: const EdgeInsets.symmetric(vertical:8 ),
                      ),
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                          child: Container(
                            child: const Text(
                                'Login', style: TextStyle(fontWeight: FontWeight.bold)
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
