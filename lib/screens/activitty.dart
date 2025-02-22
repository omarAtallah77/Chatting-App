import 'package:flutter/material.dart';
//import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ActivityScreen extends StatelessWidget {
  // Dummy data for orders
  final List<Map<String, dynamic>> orders = [
    {
      'orderNumber': '#123456',
      'date': '2024-10-01',
      'status': 'Delivered',
      'items': [
        {'name': 'Recycling Fresh Food', 'quantity': 2},
        {'name': 'Recycling Frozen Food', 'quantity': 1},
      ],
    },
    {
      'orderNumber': '#123457',
      'date': '2024-09-25',
      'status': 'Cancelled',
      'items': [
        {'name': 'Donating Fresh Food', 'quantity': 1},
      ],
    },
    {
      'orderNumber': '#123458',
      'date': '2025-02-23',
      'status': 'Shipped',
      'items': [
        {'name': 'Recycling Fresh Food', 'quantity': 3},
        {'name': 'Donating Fresh Food', 'quantity': 1},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
      Navigator.of(context).pushReplacementNamed('/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ExpansionTile(
              leading: Icon(Icons.shopping_bag, color: Colors.green),
              title: Text('Order ${order['orderNumber']}'),
              subtitle: Text('Date: ${order['date']}'),
              trailing: _buildOrderStatus(order['status']),
              children: order['items'].map<Widget>((item) {
                return ListTile(
                  title: Text(item['name']),
                  trailing: Text('Qty: ${item['quantity']}'),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderStatus(String status) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Delivered':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case 'Shipped':
        statusColor = Colors.orange;
        statusIcon = Icons.local_shipping;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(statusIcon, color: statusColor, size: 16),
        SizedBox(width: 4),
        Text(
          status,
          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}