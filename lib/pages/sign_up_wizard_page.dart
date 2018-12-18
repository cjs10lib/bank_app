import 'package:bank_app/models/user.dart';
import 'package:bank_app/pages/accept_terms_page.dart';
import 'package:bank_app/pages/profile_edit_page.dart';
import 'package:bank_app/pages/profile_image_upload_page.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';

class SignUpWizardPage extends StatefulWidget {
  final MainModel model;

  SignUpWizardPage(this.model);

  @override
  _SignUpWizardPageState createState() => _SignUpWizardPageState();
}

class _SignUpWizardPageState extends State<SignUpWizardPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  User authenticatedUser;

  @override
  void initState() {
    widget.model.fetchProfileImage();

    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateForward() {
    _tabController.animateTo((_tabController.index + 1));
    print('Navigate');
  }

  void _navigateBackwards() {
    _tabController.animateTo((_tabController.index - 1));
    print('Navigate back');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/login/login-background.jpg'))),
        child: TabBarView(
          controller: _tabController,
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ProfileEditPage(_navigateForward),
            ProfileImageUploadPage(_navigateForward, _navigateBackwards),
            AcceptTermsPage(_navigateBackwards)
          ],
        ),
      ),
    );
  }
}
