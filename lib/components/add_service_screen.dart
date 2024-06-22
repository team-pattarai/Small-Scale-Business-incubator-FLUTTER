import 'package:flutter/material.dart';

class AddServiceScreen extends StatefulWidget {
  final Function(List<String>) onAdd;

  const AddServiceScreen({required this.onAdd, Key? key}) : super(key: key);

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _addService() {
    List<String> serviceData = [
      _nameController.text,
      _quantityController.text,
      _priceController.text,
      _descriptionController.text,
      _discountController.text,
    ];

    widget.onAdd(serviceData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.production_quantity_limits_rounded),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                icon: Icon(Icons.numbers_rounded),
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                icon: Icon(Icons.currency_rupee_rounded),
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                icon: Icon(Icons.description_rounded),
                labelText: 'Description',
              ),
            ),
            TextField(
              controller: _discountController,
              decoration: const InputDecoration(
                icon: Icon(Icons.discount_rounded),
                labelText: 'Discount in %',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addService,
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}