import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class EditRefurbishedItemScreen extends StatefulWidget {
  final Map<String, dynamic> itemData;

  const EditRefurbishedItemScreen({super.key, required this.itemData});

  @override
  _EditRefurbishedItemScreenState createState() => _EditRefurbishedItemScreenState();
}

class _EditRefurbishedItemScreenState extends State<EditRefurbishedItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _stockController;
  late TextEditingController _conditionController;
  late TextEditingController _warrantyController;
  late TextEditingController _descriptionController;
  
  File? _mainImage;
  List<File> _subImages = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.itemData["name"]);
    _priceController = TextEditingController(text: widget.itemData["price"].toString());
    _discountController = TextEditingController(text: widget.itemData["discount"].toString());
    _stockController = TextEditingController(text: widget.itemData["stock"].toString());
    _conditionController = TextEditingController(text: widget.itemData["condition"]);
    _warrantyController = TextEditingController(text: widget.itemData["warranty"]);
    _descriptionController = TextEditingController(text: widget.itemData["description"]);
  }

  Future<void> _pickMainImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mainImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickSubImages() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _subImages.add(File(pickedFile.path));
      });
    }
  }

  void _updateItem() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedItem = {
        "name": _nameController.text,
        "price": double.parse(_priceController.text),
        "discount": double.parse(_discountController.text),
        "stock": int.parse(_stockController.text),
        "condition": _conditionController.text,
        "warranty": _warrantyController.text,
        "description": _descriptionController.text,
        "mainImage": _mainImage?.path ?? widget.itemData["mainImage"],
        "subImages": _subImages.map((img) => img.path).toList(),
      };
      
      Navigator.pop(context, updatedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimary,
        title: Text("Edit Refurbished Item", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildImagePicker(_mainImage, _pickMainImage, "Pick Main Image"),
              ElevatedButton(onPressed: _pickSubImages, child: Text("Add Sub Images")),
              _buildTextField("Item Name", _nameController),
              _buildTextField("Price", _priceController, keyboardType: TextInputType.number),
              _buildTextField("Discount (%)", _discountController, keyboardType: TextInputType.number),
              _buildTextField("Stock", _stockController, keyboardType: TextInputType.number),
              _buildTextField("Condition", _conditionController),
              _buildTextField("Warranty", _warrantyController),
              _buildTextField("Description", _descriptionController, maxLines: 3),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _updateItem, child: Text("Update Item")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
      ),
    );
  }

  Widget buildImagePicker(File? image, VoidCallback pickImage, String label) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
          image: image != null ? DecorationImage(image: FileImage(image), fit: BoxFit.cover) : null,
        ),
        child: image == null ? Center(child: Text(label, style: TextStyle(color: Colors.white))) : null,
      ),
    );
  }
}
