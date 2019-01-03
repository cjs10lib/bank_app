import 'package:flutter/material.dart';

class OfferFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(title: Text('Add Offers')),
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Menu Items'),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(child: Icon(Icons.local_offer)),
                        title: Text('Add Offers'),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                            child: Icon(Icons.store_mall_directory)),
                        title: Text('Offers'),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/tabs');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/login/login-background.jpg'))),
              child: ListView(
                children: <Widget>[
                  TextField(
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20.0),
                    decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter Title',
                        filled: true,
                        fillColor: Theme.of(context).cardColor),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20.0),
                    decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter Description',
                        filled: true,
                        fillColor: Theme.of(context).cardColor),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    maxLength: 7,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20.0),
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter Amount',
                        prefix: Text('GHC '),
                        filled: true,
                        fillColor: Theme.of(context).cardColor),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.0,
                          width: 160.0,
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5.0),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          child: Text('Save Offer',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
