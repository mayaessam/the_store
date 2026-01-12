import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../add_product/widgets/custom_textformfield_witth title.dart';
import '../home/widgets/bottom_nav_bar.dart';

class User {
  String username;
  String email;
  String phone;
  String name;
  String city;
  String street;

  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.name,
    required this.city,
    required this.street,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      name: '${json['name']['firstname']} ${json['name']['lastname']}',
      city: json['address']['city'],
      street: json['address']['street'],
    );
  }

  Map<String, dynamic> toJson() {
    final nameParts = name.split(' ');
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "name": {
        "firstname": nameParts.first,
        "lastname": nameParts.length > 1 ? nameParts[1] : ""
      },
      "address": {
        "city": city,
        "street": street,
      }
    };
  }
}

Future<User> fetchUser(int id) async {
  final response = await Dio().get('https://fakestoreapi.com/users/$id');
  return User.fromJson(response.data);
}

Future<User> updateUser(int id, User user) async {
  final response = await Dio().put('https://fakestoreapi.com/users/$id', data: user.toJson());
  return User.fromJson(response.data);
}

class ProfileScreen extends StatefulWidget {
  final int userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cityController;
  late TextEditingController streetController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    cityController = TextEditingController();
    streetController = TextEditingController();
    loadUser();
  }

  void loadUser() async {
    setState(() => isLoading = true);
    User user = await fetchUser(widget.userId);
    setState(() {
      nameController.text = user.name;
      usernameController.text = user.username;
      emailController.text = user.email;
      phoneController.text = user.phone;
      cityController.text = user.city;
      streetController.text = user.street;
      isLoading = false;
    });
  }

  void saveProfile() async {
    setState(() => isLoading = true);
    User updatedUser = User(
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,
      phone: phoneController.text,
      city: cityController.text,
      street: streetController.text,
    );
    try {
      User user = await updateUser(widget.userId, updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated: ${user.username}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),

          centerTitle: true,
          title: const Text('Profile')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
            CustomTextFormFieldWithTitle(
              fieldLabel: 'Name',
              controller: nameController,
              hint: 'Enter your name',
            ),
            SizedBox(height: 16),
            CustomTextFormFieldWithTitle(
              fieldLabel: 'Username',
              controller: usernameController,
              hint: 'Enter username',
            ),
            SizedBox(height: 16),
            CustomTextFormFieldWithTitle(
              fieldLabel: 'Email',
              controller: emailController,
              hint: 'Enter email',
            ),
            SizedBox(height: 16),
            CustomTextFormFieldWithTitle(
              fieldLabel: 'Phone',
              controller: phoneController,
              hint: 'Enter phone',
            ),
            SizedBox(height: 16),
            CustomTextFormFieldWithTitle(
              fieldLabel: 'City',
              controller: cityController,
              hint: 'Enter city',
            ),
            SizedBox(height: 16),
            CustomTextFormFieldWithTitle(
              fieldLabel: 'Street',
              controller: streetController,
              hint: 'Enter street',
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: saveProfile,
              child: const Text('Save Changes'),
            ),
          ],
                  ),
                ),
      bottomNavigationBar:  MainBottomNav(currentIndex: 3),

    );
  }
}
