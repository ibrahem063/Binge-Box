import 'package:bingebox/constants/custom_button_widget.dart';
import 'package:bingebox/constants/width_and_height.dart';
import 'package:bingebox/view/login_screen/login_screen.dart';
import 'package:bingebox/view/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: height(context) * 0.05),
        child: Stack(
          children: [
            Image(image: const AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
                height: height(context) * 1),
            Container(

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.6),
                    Colors.red.withOpacity(0.4),
                  ], // Colors to blend
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                    child:
                    Image(image: const AssetImage('assets/logo.png'),
                  width: width(context) * 0.65,
                  height: height(context) * 0.3,)),
                Expanded(
                  child: Text(
                    'Unlimited\n movies,TV \nshows & more',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height(context) * 0.044,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: height(context) * 0.03,),
                Text(
                  'Watch anywhere. Cancel anytime',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: width(context) * 0.045,
                  ),
                ),
                SizedBox(height: height(context) * 0.05,),
                CustomButtonWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  borderRadius: 40,
                  text: 'Login',
                  heightButton: height(context) * 0.06,
                  widthButton: width(context) * 0.7,
                ),
                SizedBox(height: height(context) * 0.03,),
                CustomButtonWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  borderColor: Colors.black.withOpacity(0.8),
                  borderWidth: 3,
                  fontWeight: FontWeight.w500,
                  borderRadius: 40,
                  text: 'Sign in',
                  heightButton: height(context) * 0.06,
                  widthButton: width(context) * 0.7,
                ),
                SizedBox(height: height(context) * 0.05,),
                Text(
                  'Sign up using',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width(context) * 0.035,
                  ),
                ),
                SizedBox(height: height(context) * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: width(context) * 0.055,
                      backgroundColor: Colors.black.withOpacity(0.6),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'G',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width(context) * 0.065,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width(context) * 0.03,),
                    CircleAvatar(
                      radius: width(context) * 0.055,
                      backgroundColor: Colors.black.withOpacity(0.6),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'f',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width(context) * 0.065,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width(context) * 0.03,),
                    CircleAvatar(
                      radius: width(context) * 0.055,
                      backgroundColor: Colors.black.withOpacity(0.6),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'X',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width(context) * 0.065,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
