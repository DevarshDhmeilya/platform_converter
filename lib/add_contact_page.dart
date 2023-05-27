import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/globals/utils.dart';
import 'package:provider/provider.dart';

import 'globals/models.dart';
import 'main_provider.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

ImagePicker picker = ImagePicker();

GlobalKey<FormState> addContactKey = GlobalKey<FormState>();

TextEditingController firstNameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController chatsConversationController = TextEditingController();

TextStyle hintStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

class _AddContactPageState extends State<AddContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, provider, child) => Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Options"),
                                ),
                                content: Text(
                                  "Choose an option to add photo",
                                ),
                                icon: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                ),
                                actions: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            child: Text(
                                              "Camera",
                                            ),
                                            onPressed: () async {
                                              XFile? img =
                                                  await picker.pickImage(
                                                source: ImageSource.camera,
                                              );

                                              setState(() {
                                                Global.image =
                                                    File(img!.path as String);
                                              });

                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text("Gallery"),
                                            onPressed: () async {
                                              XFile? img =
                                                  await picker.pickImage(
                                                source: ImageSource.gallery,
                                              );

                                              setState(() {
                                                Global.image =
                                                    File(img!.path as String);
                                              });

                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xffeadeff),
                        radius: 60,
                        child: Icon(Icons.add_a_photo_outlined),
                        foregroundImage: (Global.image != null)
                            ? FileImage(Global.image as File)
                            : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: addContactKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          onSaved: (val) {
                            Global.firstName = val;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter First Name First....";
                            }
                            return null;
                          },
                          controller: firstNameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Full Name",
                            icon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onSaved: (val) {
                            Global.phone = val;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Phone Number First....";
                            }
                            if (val.length != 10) {
                              return "Enter Correct Phone Number....";
                            }
                            return null;
                          },
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            hintText: "Phone Number",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onSaved: (val) {
                            Global.chat = val;
                          },
                          controller: chatsConversationController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Chat Conversation",
                            icon: Icon(Icons.chat_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 16,
                // ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month_rounded),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(3000),
                        ).then(
                          (value) => provider.setSelectedDate(value!),
                        );
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        provider.selectedDate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time_rounded),
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) => provider.setSelectedTime(value!));
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        provider.selectedTime,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (addContactKey.currentState!.validate()) {
                      addContactKey.currentState!.save();

                      Contact c1 = Contact(
                        firstName: Global.firstName,
                        phone: Global.phone,
                        chat: Global.chat,
                        image: Global.image,
                      );
                      Global.allContacts.add(c1);
                    }

                    setState(
                      () {
                        addContactKey.currentState!.reset();

                        firstNameController.clear();

                        phoneNumberController.clear();
                        chatsConversationController.clear();

                        print(Global.firstName);
                        print(Global.phone);
                        print(Global.chat);
                        print(Global.image);

                        Global.firstName = null;
                        Global.phone = null;
                        Global.chat = null;
                        provider.selectedDate;
                        provider.selectedTime;
                      },
                    );
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
