import 'package:flutter/material.dart';

class OfferDescription extends StatefulWidget {
  final String _offerDescription;

  OfferDescription(this._offerDescription);

  @override
  _OfferDescriptionState createState() => _OfferDescriptionState();
}

class _OfferDescriptionState extends State<OfferDescription> {
  String _partA;
  String _partB;

  bool _showmore = false;

  @override
  void initState() {
    if (widget._offerDescription.length > 60) {
      _partA = widget._offerDescription.substring(0, 60);
      _partB = widget._offerDescription
          .substring(60, widget._offerDescription.length);
    } else {
      _partA =
          widget._offerDescription.substring(0, widget._offerDescription.length);
      _partB = '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(
            _showmore ? (_partA + _partB) : '$_partA...',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showmore = !_showmore;
                  });
                },
                child: Text(
                  _showmore ? 'show less' : 'show more',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
