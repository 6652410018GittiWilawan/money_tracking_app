import 'package:flutter/material.dart';
import 'package:money_tracking_app/views/home_ui.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPassCtrl = TextEditingController();
  bool _isVisible = false;

   showWarningSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        toolbarHeight: 130, // ทำให้สูงขึ้น
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'เข้าใช้งาน Money Tracking',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Moneylogo.png',
                        width: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: userNameCtrl,
                        decoration: InputDecoration(
                          labelText: 'ชื่อผู้ใช้',
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          hintText: 'Username',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: userPassCtrl,
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                          labelText: 'รหัสผ่าน',
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          hintText: 'Password',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isVisible
                                  ? Icons.lock_open
                                  : Icons.lock,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.brown,
                        child: TextButton(
                         onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User user = User(
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPassCtrl.text.trim(),
                        );

                        user = await UserApi().loginUser(user);

                        if (user.userId != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => HomeUi(
                                    userName: user.userFullname,
                                    userImage: user.userImage,
                                    userId: int.parse(user.userId.toString()),
                                  ),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        } else if (user.userName != userNameCtrl.text.trim() ||
                            user.userPassword != userPassCtrl.text.trim()) {
                          showWarningSnackBar(
                            context,
                            'ชื่อและรหัสผ่านไม่ถูกต้อง',
                          );
                        }
                      }
                    },
                        )  ), 
                    ]), 
                    ),
          ),    
        ),
      ),
    );
  }
}
