import 'dart:io';

class Contact {
  String? firstName;
  String? phone;
  String? chat;
  File? image;

  Contact({
    required this.firstName,
    required this.phone,
    required this.chat,
    this.image,
  });
}
