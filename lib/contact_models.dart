import 'dart:io';

class Contact {
  late final String? firstName;
  late final String? lastName;
  late final String? phone;
  late final String? email;
  late final File? image;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.image,
  });
}
// Contact contact = Contact(firstName: "", lastName: "", phone: "", email: "");

List contacts = [];
