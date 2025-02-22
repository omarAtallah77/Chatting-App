import 'package:flutter/material.dart';
import 'home_screen.dart';

class RecycleScreen extends StatefulWidget {
  final bool? donate;
  final String? title;

  /// **Constructor with optional parameters**
  const RecycleScreen({Key? key, this.donate, this.title}) : super(key: key);

  @override
  _RecycleScreenState createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  Widget icon = Icon(Icons.recycling, color: Colors.white);

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedFoodType;
  var addressController = TextEditingController();

  final List<String> _foodTypes = ['Fresh', 'Frozen', 'Both'];

  /// **Function to show the date picker**
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[200],
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// **Function to show the time picker**
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[200],
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, // Allows the screen to be popped (navigated back)
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context); // Navigate back when the back button is pressed
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
              icon: Icon(Icons.home, color: Colors.white),
            )
          ],
          leading: widget.donate == false ? icon : Icon(Icons.account_balance_wallet_sharp , color: Colors.white,),
          title: Text(
            widget.title ?? 'Recycle', // Use default title if not provided
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Choose Date**
                  ListTile(
                    title: Text(
                      _selectedDate == null ? 'Choose Date' : 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 20),
      
                  /// **Choose Time**
                  ListTile(
                    title: Text(
                      _selectedTime == null ? 'Choose Time' : 'Selected Time: ${_selectedTime!.format(context)}',
                    ),
                    trailing: Icon(Icons.access_time),
                    onTap: () => _selectTime(context),
                  ),
                  SizedBox(height: 20),
      
                  /// **Food Type Selection**
                  Text(
                    'Choose Type of Food:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: _foodTypes.map((type) {
                      return RadioListTile<String>(
                        activeColor: Colors.green,
                        title: Text(type),
                        value: type,
                        groupValue: _selectedFoodType,
                        onChanged: (value) {
                          setState(() {
                            _selectedFoodType = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
      
                  /// **Address Input Field**
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your Address',
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    controller: addressController,
                  ),
                  SizedBox(height: 20),
      
                  /// **Submit Button**
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedDate == null || _selectedTime == null || _selectedFoodType == null || addressController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recycling scheduled successfully!')));
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: TextStyle(color: Colors.white60),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
