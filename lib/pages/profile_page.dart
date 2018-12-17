import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Ottomoto'),
                background: Hero(
                  tag: 'profile-image',
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    height: 250.0,
                    image: AssetImage('assets/avatar/avatar.png'),
                    placeholder: AssetImage('assets/avatar/avatar.png'),
                  ),
                ),
              ),
            ),
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
                        Text('John Doe',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(59, 70, 80, 1))),
                        Text(
                          'East Legon, Accra',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Colors.grey)),
                              child: IconButton(
                                icon: Icon(Icons.edit,
                                    color: Color.fromRGBO(59, 70, 80, 1)),
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
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Material(
                  elevation: 1.0,
                  color: Colors.white,
                  child: Container(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Column(children: <Widget>[
                        Text(
                          'Contacts',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Color.fromRGBO(59, 70, 80, 1)),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          leading: CircleAvatar(
                              child: Icon(Icons.email, color: Colors.white),
                              backgroundColor: Theme.of(context).primaryColor),
                          title: Text('example@gmail.com'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                              child: Icon(Icons.phone, color: Colors.white),
                              backgroundColor: Theme.of(context).primaryColor),
                          title: Text('+2337076547465'),
                          subtitle: Text('+2337885494744'),
                        ),
                        FlatButton(
                            child: Text('Sign Out',
                                style: TextStyle(
                                  color: Color.fromRGBO(59, 70, 80, 1),
                                  fontSize: 18.0,
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed('/');
                              
                            })
                      ]),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
