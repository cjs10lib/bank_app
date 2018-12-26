import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';

class TransactionSuccessAlert extends StatelessWidget {
  final Map<String, String> _message;
  final MainModel _model;

  TransactionSuccessAlert(this._message, this._model);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 350.0,
        width: 200.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 94.0,
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45.0),
                        border: Border.all(width: 2.0, color: Colors.grey)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45.0),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(_model.profileImage),
                        placeholder: AssetImage('assets/avatar/avatar.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30.0,
                      )),
                  SizedBox(width: 5.0),
                  Text(
                    _message['title'],
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: Text(_message['subtitle']),
              // 'Your account will be credited on successful confirmaion of transaction.'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 40.0,
                      width: 80.0,
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                      color: Theme.of(context).primaryColor,
                      alignment: Alignment.center,
                      child: Text('Okay',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
