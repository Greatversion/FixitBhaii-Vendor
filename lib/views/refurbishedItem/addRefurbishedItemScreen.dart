import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

@RoutePage()
class AddEditRefurbishedItemScreen extends StatefulWidget {
  final Map<String, dynamic>? existingItem;

  const AddEditRefurbishedItemScreen({this.existingItem, Key? key})
      : super(key: key);

  @override
  _AddEditRefurbishedItemScreenState createState() =>
      _AddEditRefurbishedItemScreenState();
}

class _AddEditRefurbishedItemScreenState
    extends State<AddEditRefurbishedItemScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  TextEditingController _stockController = TextEditingController();
  TextEditingController _specsController = TextEditingController();

  String _selectedItemType = "Refurbished";
  String _selectedItemCondition = "Not Used";
  File? _mainImage;
  List<File> _subImages = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingItem != null) {
      _nameController.text = widget.existingItem!["name"];
      _descriptionController.text = widget.existingItem!["description"];
      _priceController.text = widget.existingItem!["price"].toString();
      _discountController.text = widget.existingItem!["discount"].toString();
      _stockController.text = widget.existingItem!["stock"].toString();
      _specsController.text = widget.existingItem!["specs"];
      _selectedItemType = widget.existingItem!["ItemType"];
      _selectedItemCondition = widget.existingItem!["ItemCondition"];
    }
  }

  Future<void> _pickMainImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mainImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickSubImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _subImages.addAll(pickedFiles.map((e) => File(e.path)));
      });
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> newItem = {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": double.parse(_priceController.text),
        "discount": double.parse(_discountController.text),
        "stock": int.parse(_stockController.text),
        "specs": _specsController.text,
        "ItemType": _selectedItemType,
        "ItemCondition": _selectedItemCondition,
        "mainImage": _mainImage != null
            ? _mainImage!.path
            : widget.existingItem?["mainImage"],
        "subImages": _subImages.map((e) => e.path).toList(),
      };

      // TODO: Implement database save function

      Navigator.pop(context, newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        // backgroundColor: AppColors.black,
        title: Text(
          widget.existingItem != null
              ? "Edit Refurbished Item"
              : "Add Refurbished Item",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Main Image Picker
              buildImagePicker(context, "Main Image", _mainImage, isMain: true),
              buildMultiImagePicker(),

              SizedBox(height: 16),

              Wrap(
                spacing: 10,
                children: _subImages.map((file) {
                  return Image.file(file,
                      height: 80, width: 80, fit: BoxFit.cover);
                }).toList(),
              ),
              SizedBox(height: 16),

              // Name
              _buildTextField(context, _nameController, "Item Name"),

              // Description
              _buildTextField(context, _descriptionController, "Description",
                  maxLines: 3),

              // Price & Discount
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          context, _priceController, "Price (₹)",
                          keyboardType: TextInputType.number)),
                  SizedBox(width: 10),
                  Expanded(
                      child: _buildTextField(
                          context, _discountController, "Discount (%)",
                          keyboardType: TextInputType.number)),
                ],
              ),

              // Stock
              _buildTextField(context, _stockController, "Available Stock",
                  keyboardType: TextInputType.number),

              // Warranty Selection
              DropdownButtonFormField<String>(
                dropdownColor: Theme.of(context).cardTheme.color,
                value: _selectedItemType,
                items: ["Refurbished", "New"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: Theme.of(context).textTheme.bodyMedium),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedItemType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Item Type",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textSecondary)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textSecondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              SizedBox(height: 16),

              // Warranty Selection
              DropdownButtonFormField<String>(
                dropdownColor: Theme.of(context).cardTheme.color,
                value: _selectedItemCondition,
                items: ["Moderately Used", "Not Used"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: Theme.of(context).textTheme.bodyMedium),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedItemCondition = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Item Condition",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textSecondary)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textSecondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              // Specifications

              SizedBox(height: 16),
              _buildTextField(context, _specsController, "Specifications",
                  maxLines: 4),

              // Save Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveItem,
                child: Text("Save Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImagePicker(context, String title, File? image,
      {bool isMain = false}) {
    return GestureDetector(
      onTap: () => _pickMainImage(),
      child: Container(
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!),
          image: image != null
              ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
              : null,
        ),
        child: image == null
            ? Center(
                child: Icon(Icons.camera_alt, color: Colors.white, size: 50))
            : null,
      ),
    );
  }

  Widget buildMultiImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sub Images",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ..._subImages
                .map((file) =>
                    Image.file(file, width: 80, height: 80, fit: BoxFit.cover))
                .toList(),
            GestureDetector(
              onTap: () => _pickSubImages(),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  border: Border.all(color: Colors.white),
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      context, TextEditingController controller, String label,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyLarge!,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.titleMedium!,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textSecondary)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textSecondary)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        ),
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
