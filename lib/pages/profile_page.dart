import 'package:bank_app/models/profile.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatelessWidget {
  Widget _buildSliverAppBar(MainModel model) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text('Ottomoto'),
        background: Hero(
          tag: 'profile-image',
          child: FadeInImage(
            fit: BoxFit.cover,
            height: 250.0,
            image: model.profileImage != null ? NetworkImage(model.profileImage) : AssetImage('assets/avatar/avatar.png'),
            placeholder: AssetImage('assets/avatar/avatar.png'),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileName(Profile profile) {
    return Text('${profile.firstname} ${profile.lastname}',
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(59, 70, 80, 1)));
  }

  Widget _buildProfileAddress(Profile profile) {
    return Text(
      profile.address,
      style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
    );
  }

  Widget _buildControls(BuildContext context, MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey)),
          child: IconButton(
            icon: Icon(Icons.edit, color: Color.fromRGBO(59, 70, 80, 1)),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey)),
          child: IconButton(
            icon: Icon(Icons.account_balance_wallet,
                color: Color.fromRGBO(59, 70, 80, 1)),
            onPressed: () {
              Navigator.of(context).pushNamed('/wallet');
            },
          ),
        )
      ],
    );
  }

  Widget _buildProfileContacts(
      BuildContext context, Profile profile, MainModel model) {
    return Material(
      elevation: 1.0,
      color: Colors.white,
      child: Container(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(children: <Widget>[
            Text(
              'Contacts',
              style: TextStyle(
                  fontSize: 25.0, color: Color.fromRGBO(59, 70, 80, 1)),
            ),
            SizedBox(height: 10.0),
            ListTile(
              leading: CircleAvatar(
                  child: Icon(Icons.email, color: Colors.white),
                  backgroundColor: Theme.of(context).primaryColor),
              title: Text(profile.email),
            ),
            ListTile(
              leading: CircleAvatar(
                  child: Icon(Icons.phone, color: Colors.white),
                  backgroundColor: Theme.of(context).primaryColor),
              title: Text('+233${profile.mobilePhone}'),
              subtitle: Text('+233${profile.otherPhone}'),
            ),
            FlatButton(
                child: Text('Sign Out',
                    style: TextStyle(
                      color: Color.fromRGBO(59, 70, 80, 1),
                      fontSize: 18.0,
                    )),
                onPressed: () {
                  model.signOut().then((_) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                  });
                })
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final _profile = model.profile;

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                _buildSliverAppBar(model),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Material(
                      elevation: 1.0,
                      color: Colors.white,
                      child: Container(
                        height: 120.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildProfileName(_profile),
                            _buildProfileAddress(_profile),
                            SizedBox(height: 10.0),
                            _buildControls(context, model)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildProfileContacts(context, _profile, model)
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
