import 'package:bank_app/models/offer.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/home/header_stack.dart';
import 'package:bank_app/widgets/home/offer_list.dart';
import 'package:bank_app/widgets/home/offer_options.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage(this.model);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.model.fetchOffers();
    super.initState();
  }

  _adaptiveContent(MainModel model) {
    Widget _content = Center(
      child: Text(
        'Sorry, no offers yet.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );

    if (!model.isLoading && model.offers.length > 0) {
      return model.offers.map((Offer offer) {
        return OfferList(
          offerTitle: offer.title,
          offerDescription: offer.description,
          amount: offer.amount,
          offerImage: 'assets/home/chair.jpg',
          isFavorite: true,
        );
      }).toList();
    } else if (model.isLoading) {
      return <Widget>[
        Container(
          padding: EdgeInsets.all(50.0),
          child: Center(child: CircularProgressIndicator()),
        )
      ];
    } else {
      return <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50.0),
              child: Center(child: _content),
            ),
          ],
        )
      ];
    }
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
                background: HeaderStack(model),
              ),
              bottom: PreferredSize(
                child: OfferOptions(),
                preferredSize: Size.fromHeight(70.0),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(_adaptiveContent(model)),
            )
          ],
        );
      },
    );
  }
}
