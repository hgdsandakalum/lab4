import 'package:flutter/material.dart';
import 'package:lab4/services/agify.dart';

class Home extends StatefulWidget {
  final AgifyService _agifyService;

  const Home({Key? key})
      : _agifyService = const AgifyService(),
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Agify"),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent),
                      ),
                      helperText: "Enter a name",
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the name";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      setState(() {
                        if (value != null) _name = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    child: const Text("Get Age"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      primary: Colors.amberAccent,
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_age != null)
            Center(
              child: Text(
                "Age is $_age",
                style: Theme.of(context).textTheme.headline5,
              ),
            )
        ],
      ),
    );
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    final calculatedAge = await widget._agifyService.getAgeFromName(_name!);

    setState(() {
      _age = calculatedAge;
    });
  }
}
