import 'package:flutter/material.dart';

import '../../../../core/widgets/appbar_generic.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    String phoneNumber = '';
    final formKey = GlobalKey<FormState>();
    // String? val;
    // List items = ['1', '2', '3'];
    return Scaffold(
      appBar: const AppBarGeneric(title: "Contact Us"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
