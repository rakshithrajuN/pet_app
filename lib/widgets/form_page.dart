import 'package:flutter/material.dart';

class Formpage extends StatefulWidget {
  const Formpage({Key? key}) : super(key: key);

  @override
  _FormpageState createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Pet Details'),
      ),
      body: Container(
        color: Colors.white,
        child: TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Enter pet name',
            labelText: 'Name *',
          ),
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
        ),

      ),
    );
  }
}
