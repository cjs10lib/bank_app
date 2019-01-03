import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  Widget _buildHeaderStack(BuildContext context, MainModel model) {
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
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
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
                              color: Colors.white,
                              width: 2.0,
                              style: BorderStyle.solid)),
                      child: Hero(
                        tag: 'profile-image',
                        child: CircleAvatar(
                            backgroundImage: model.profileImage != null
                                ? NetworkImage(model.profileImage)
                                : AssetImage('assets/avatar/avatar.png')),
                        // AssetImage('assets/avatar/avatar.png')),
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/add-offers');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Hello, ${model.profile != null ? model.profile.firstname : null}',
                style: TextStyle(color: Colors.white, fontSize: 50.0),
              ),
              Text(
                'How can we help you today?',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              SizedBox(height: 30.0),
              Material(
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
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSideDrawer() {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.local_offer),
              ),
              title: Text('Add Offers'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOfferOptions() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Material(
          elevation: 1.0,
          child: Container(
            height: 70.0,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 70.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/home/wardrobe.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Text('Offers')
                ],
              ),
            ),
            Container(
              height: 70.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/home/desk.png'),
                      ),
                    ),
                  ),
                  Text('News')
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildAddOffers(BuildContext context, String productImage,
      String productName, String value, bool isFavorite) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _targetWidth = _deviceWidth > 550.0 ? 500 : _deviceWidth * .95;
    double _targetPadding = _deviceWidth - _targetWidth;

    return Material(
      elevation: 1.0,
      color: Colors.white,
      child: Container(
        // margin: EdgeInsets.all(_targetPadding),
        // height: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 150.0,
              width: 150.0,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(productImage), fit: BoxFit.cover),
              ),
            ),
            Container(
              // height: 170.0,
              width: 200.0,
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          productName,
                          style: TextStyle(
                              color: Color.fromRGBO(59, 70, 80, 1),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Material(
                        elevation: isFavorite ? 1.0 : 0.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          child: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            // iconSize: 30.0,
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 50.0,
                    child: Text(
                      "Scandinavian small sized double sofa imported full leather / Dale Italia oil wax leather black",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: 80.0,
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        color: Theme.of(context).primaryColor,
                        alignment: Alignment.center,
                        child: Text(value,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        height: 40.0,
                        width: 120.0,
                        // color: Color.fromRGBO(0, 25, 45, .40),
                        color: Color.fromRGBO(59, 70, 80, 1),
                        alignment: Alignment.center,
                        child: Text('More Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 350.0,
              snap: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildHeaderStack(context, model),
              ),
              bottom: PreferredSize(
                child: _buildOfferOptions(),
                preferredSize: Size.fromHeight(70.0),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20.0),
                _buildAddOffers(context, 'assets/home/ottoman.jpg',
                    'Flash Sales', 'GHc10.99', true),
                SizedBox(height: 20.0),
                _buildAddOffers(context, 'assets/home/chair.jpg',
                    'Discount On Intrests', '-1%', false),
                SizedBox(height: 20.0),
                _buildAddOffers(context, 'assets/home/sale-desk.png',
                    'More Savings, More Intrests', '0.65%', false),
                SizedBox(height: 20.0),
              ]),
            )
          ],
        );
      },
    );
  }
}
