import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_tracking_app/models/user.dart';
import 'package:money_tracking_app/views/login_ui.dart';
import 'package:intl/intl.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  File? _imageFile;
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPassCtrl = TextEditingController();
  TextEditingController userFullNameCtrl = TextEditingController();
  TextEditingController userBirthDateCtrl = TextEditingController();
  bool _isVisible = false;

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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
            'ลงทะเบียน',
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
              child: Column(children: [
                SizedBox(height: 20),
                Text(
                  'ข้อมูลผู้ใช้',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    _imageFile != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(_imageFile!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person,
                                size: 60, color: Colors.white),
                          ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _pickImageFromCamera,
                      icon: Icon(Icons.camera_alt),
                      label: Text("ถ่ายรูป"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: userFullNameCtrl,
                          decoration: InputDecoration(
                            labelText: 'ชื่อ-สกุล',
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
                            hintText: 'YOUR NAME',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: userBirthDateCtrl,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'วัน-เดือน-ปี เกิด',
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
                            hintText: 'YOUR BIRTHDAY',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    userBirthDateCtrl.text =
                                        DateFormat('yyyy-MM-dd').format(picked);
                                  });
                                }
                              },
                            ),
                          ),
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
                                _isVisible ? Icons.lock_open : Icons.lock,
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
                          userFullname: userFullNameCtrl.text.trim(),
                          userBirthDate: userBirthDateCtrl.text.trim(),
                          userName: userNameCtrl.text.trim(), // ← อันนี้แก้!
                          userPassword: userPassCtrl.text.trim(),
                        );

                        if (await UserApi().registerUser(user, userfile)) {
                          Navigator.pop(context);
                        } else {
                          showWarningSnackBar(context, "ลงทะเบียนไม่สําเร็จ");
                        }
                      }
                    },
                            child: Text(
                              'บันทึกการลงทะเบียน',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
          ),
        ));
  }
}
