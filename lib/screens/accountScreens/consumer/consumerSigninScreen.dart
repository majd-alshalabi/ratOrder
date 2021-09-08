import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/helper/databaseHelper.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:rat_order/helper/sharedPre.dart';
import 'package:rat_order/screens/accountScreens/consumer/consumerRegisterScreen.dart';
import 'package:rat_order/screens/homePageScreen/homePageScreen.dart';
import 'package:provider/provider.dart';

class ConsumerSigninScreen extends StatefulWidget {
  static final id = 'consumerSigninScreen';

  @override
  _ConsumerSigninScreenState createState() => _ConsumerSigninScreenState();
}

class _ConsumerSigninScreenState extends State<ConsumerSigninScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String errorText = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.grey[100],
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        child: HeaderIcon(),
                        tag: 'icon',
                      ),
                      Text('Consumer Account'),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputContainer(
                              onchange: (value) {
                                setState(() {
                                  errorText = '';
                                });
                              },
                              controller: emailController,
                              valid: (String value) {
                                if (value == null || value.isEmpty)
                                  return 'this field must not be empty';
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              placeHolderText: 'اسم المستخدم او الايميل',
                              newWidth:
                                  4 * MediaQuery.of(context).size.width / 5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputContainer(
                              onchange: (value) {
                                setState(
                                  () {
                                    errorText = '';
                                  },
                                );
                              },
                              controller: passwordController,
                              valid: (String value) {
                                if (value == null || value.length <= 5)
                                  return 'password must be more than 5 Letters';
                                else
                                  return null;
                              },
                              obscureTextValue: true,
                              placeHolderText: 'كلمة السر',
                              newWidth:
                                  4 * MediaQuery.of(context).size.width / 5,
                            ),
                            Container(
                              child: Text(
                                errorText,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              margin: EdgeInsets.only(top: 10),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Material(
                                color:
                                    isLoading ? Colors.transparent : firstColor,
                                elevation: isLoading ? 0 : 5.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                child: MaterialButton(
                                  minWidth:
                                      2 * MediaQuery.of(context).size.width / 5,
                                  onPressed: myButtonFunction,
                                  height: 42.0,
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          'تسجيل الدخول',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('حساب جديد !'),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ConsumerRegisterScreen.id);
                            },
                            child: Text(
                              ' التسجيل ؟',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.lightBlue),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void myButtonFunction() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState.validate()) {
        List<Map> users = await DatabaseHelper.getDataBaseInfo();
        users = users
            .where((element) =>
                element['_email'] == emailController.text &&
                element['_password'] == passwordController.text)
            .toList();
        if (users.length > 0) {
          context.read<ProviderHelper>().loggedIn = true;
          context.read<ProviderHelper>().name = emailController.text;
          context.read<ProviderHelper>().fav = users[0]['_fav'];
          context.read<ProviderHelper>().id = users[0]['_id'];
          SharedPre.setUserID(users[0]['_id']);
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.id, (route) => false);
        } else
          setState(() {
            errorText = 'username or password is not correct';
          });
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
