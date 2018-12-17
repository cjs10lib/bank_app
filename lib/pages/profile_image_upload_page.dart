import 'package:flutter/material.dart';

class ProfileImageUploadPage extends StatelessWidget {
  final Function _navigateForward;
  final Function _navigateBackwards;

  ProfileImageUploadPage(this._navigateForward, this._navigateBackwards);

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250.0,
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Select an option',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Material(
                        elevation: 2.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: 120.0,
                          height: 120,
                          child: Icon(Icons.camera,
                              size: 100.0,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onTap: () {
                        // _getImage(context, ImageSource.camera);
                      },
                    ),
                    SizedBox(width: 20.0),
                    GestureDetector(
                      child: Material(
                        elevation: 2.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: 120.0,
                          height: 120.0,
                          child: Icon(Icons.image,
                              size: 100.0,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onTap: () {
                        // _getImage(context, ImageSource.gallery);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250.0,
              width: 250.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(125.0),
                  border: Border.all(color: Colors.white, width: 2.0)),
              child: CircleAvatar(
                radius: 125.0,
                backgroundImage: AssetImage('assets/avatar/avatar.png'),
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              child: Text('Select Image',
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () {
                print('Select Image');
                _openImagePicker(context);
              },
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _navigateBackwards();
                  },
                  child: Container(
                    height: 40.0,
                    width: 80.0,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    child: Text('Back',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateForward();
                  },
                  child: Container(
                    height: 40.0,
                    width: 120.0,
                    // color: Color.fromRGBO(0, 25, 45, .40),
                    color: Color.fromRGBO(59, 70, 80, 1),
                    alignment: Alignment.center,
                    child: Text('Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
