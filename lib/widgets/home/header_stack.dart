import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HeaderStack extends StatelessWidget {
  final MainModel _model;

  HeaderStack(this._model);

  Widget _buildHeaderContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildProfileImageRow(context),
          SizedBox(height: 20.0),
          Text(
            'Hello, ${_model.profile != null ? _model.profile.firstname : null}',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
          Text(
            'How can we help you today?',
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
          SizedBox(height: 30.0),
          _buildSearchFormField(context),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildProfileImageRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/profile');
          },
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                    color: Colors.white, width: 2.0, style: BorderStyle.solid)),
            child: Hero(
              tag: 'profile-image',
              child: CircleAvatar(
                  backgroundImage: _model.profileImage != null
                      ? NetworkImage(_model.profileImage)
                      : AssetImage('assets/avatar/avatar.png')),
              // AssetImage('assets/avatar/avatar.png')),
            ),
          ),
        ),
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  iconSize: 30.0,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/add-offers');
                  },
                ),
                IconButton(
                  icon: Icon(
                    _model.displayFavoritesOnly
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  iconSize: 30.0,
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget _buildSearchFormField(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5.0),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            size: 30.0,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 250.0,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          bottom: 50.0,
          right: 100.0,
          child: Container(
            height: 400.0,
            width: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              color: Color.fromRGBO(0, 25, 45, .40),
            ),
          ),
        ),
        Positioned(
          bottom: 150.0,
          left: 250.0,
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: Color.fromRGBO(0, 25, 45, .40),
            ),
          ),
        ),
        _buildHeaderContainer(context)
      ],
    );
  }
}
