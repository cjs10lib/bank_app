import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/home/header_stack.dart';
import 'package:bank_app/widgets/home/offer_list.dart';
import 'package:bank_app/widgets/home/offer_options.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
 
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
              delegate: SliverChildListDelegate([
                SizedBox(height: 20.0),
                OfferList(offerTitle: 'Discount On Intrests', offerDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla.', value: '10.99', offerImage: 'assets/home/chair.jpg', isFavorite: true,),
                SizedBox(height: 20.0),
                OfferList(offerTitle: 'Discount On Intrests', offerDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla.', value: '10.99', offerImage: 'assets/home/chair.jpg', isFavorite: true,),
                SizedBox(height: 20.0),
                OfferList(offerTitle: 'Discount On Intrests', offerDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla.', value: '10.99', offerImage: 'assets/home/chair.jpg', isFavorite: true,),
                SizedBox(height: 20.0),                
                OfferList(offerTitle: 'Discount On Intrests', offerDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla.', value: '10.99', offerImage: 'assets/home/chair.jpg', isFavorite: true,),
                SizedBox(height: 20.0),                
                OfferList(offerTitle: 'Discount On Intrests', offerDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla.', value: '10.99', offerImage: 'assets/home/chair.jpg', isFavorite: true,),
                SizedBox(height: 20.0),                
                OfferList(offerTitle: 'Discount On Intrests', offerDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla.', value: '10.99', offerImage: 'assets/home/chair.jpg', isFavorite: true,),
                SizedBox(height: 20.0),                
                OfferList(offerTitle: 'Discount On Intrests', offerDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla.', value: '10.99', offerImage: 'assets/home/chair.jpg', isFavorite: true,),
                SizedBox(height: 20.0),                
              ]),
            )
          ],
        );
      },
    );
  }
}
