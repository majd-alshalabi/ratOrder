import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/helper/databaseHelper.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/helper/sharedPre.dart';
import 'package:rat_order/screens/homePageScreen/homePageScreen.dart';

class ConsumerRegisterScreen extends StatefulWidget {
  static final id = 'consumerRegisterScreen';

  @override
  _ConsumerRegisterScreenState createState() => _ConsumerRegisterScreenState();
}

class _ConsumerRegisterScreenState extends State<ConsumerRegisterScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else
                                return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: nameController,
                            placeHolderText: 'اسم المستخدم او الايميل',
                            newWidth: 4 * MediaQuery.of(context).size.width / 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputContainer(
                            onchange: (value) {
                              setState(() {
                                errorText = '';
                              });
                            },
                            valid: (String value) {
                              if (value.length <= 5)
                                return 'password must be more than 5 Letter';
                              else
                                return null;
                            },
                            obscureTextValue: true,
                            controller: passwordController,
                            placeHolderText: 'كلمة السر',
                            newWidth: 4 * MediaQuery.of(context).size.width / 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputContainer(
                            onchange: (value) {
                              setState(() {
                                errorText = '';
                              });
                            },
                            valid: (value) {
                              if (value != passwordController.text)
                                return 'both password must be equal';
                              else
                                return null;
                            },
                            obscureTextValue: true,
                            controller: confirmController,
                            placeHolderText: 'تأكيد كلمة السر',
                            newWidth: 4 * MediaQuery.of(context).size.width / 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              errorText,
                              style: TextStyle(color: Colors.red),
                            ),
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
                                        'التسجيل',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void myButtonFunction() async {
    {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      }
      try {
        if (_formKey.currentState.validate()) {
          List<Map> users = await DatabaseHelper.getDataBaseInfo();
          users = users
              .where((element) =>
                  element['_email'] == nameController.text &&
                  element['_password'] == passwordController.text)
              .toList();
          if (users.isEmpty) {
            context.read<ProviderHelper>().loggedIn = true;
            context.read<ProviderHelper>().id =
                await DatabaseHelper.getTheTableRowNum();
            await DatabaseHelper.addRowToDataBase(
              nameController.text,
              passwordController.text,
              '00000000',
            );
            context.read<ProviderHelper>().fav = '00000000';
            context.read<ProviderHelper>().name = nameController.text;
            SharedPre.setUserID(context.read<ProviderHelper>().id);
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.id, (route) => false);
          } else {
            setState(() {
              errorText = 'this user is already in use';
            });
          }
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
