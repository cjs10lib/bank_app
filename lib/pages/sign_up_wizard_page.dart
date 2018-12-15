
import 'package:bank_app/pages/profile_edit_page.dart';
import 'package:bank_app/pages/profile_image_upload_page.dart';
import 'package:flutter/material.dart';

class SignUpWizardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              ProfileEditPage(),
              ProfileImageUploadPage()
            ],
          ),
        ),
      ),
    );
  }
}
