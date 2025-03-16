import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

@RoutePage()
class AddEditServiceScreen extends StatefulWidget {
  final Map<String, dynamic>? existingService;

  AddEditServiceScreen({this.existingService});

  @override
  _AddEditServiceScreenState createState() => _AddEditServiceScreenState();
}

class _AddEditServiceScreenState extends State<AddEditServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _warrantyController = TextEditingController();
  final TextEditingController _offerController = TextEditingController();
  bool _isAvailable = true;

  File? _mainImage;
  final List<File> _subImages = [];

  String? _selectedCategory;
  String? _selectedSubcategory;
  final List<String> _selectedTechnicians = [];

  final List<String> _categories = ["Electrical", "Electronics", "Computers"];
  final Map<String, List<String>> _subcategories = {
    "Electrical": ["Wiring", "Switches", "Fans"],
    "Electronics": ["TV", "Refrigerator", "AC"],
    "Computers": ["Laptop Repair", "PC Build", "Software Issues"]
  };
  final List<String> _technicians = [
    "Technician 1",
    "Technician 2",
    "Technician 3"
  ];

  Future<void> _pickImage(bool isMain) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isMain) {
          _mainImage = File(pickedFile.path);
        } else {
          _subImages.add(File(pickedFile.path));
        }
      });
    }
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> newService = {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": double.parse(_priceController.text),
        "duration": _durationController.text,
        "warranty": _warrantyController.text,
        "isAvailable": _isAvailable,
        "category": _selectedCategory,
        "subcategory": _selectedSubcategory,
        "technicians": _selectedTechnicians,
        "mainImage": _mainImage?.path,
        "subImages": _subImages.map((img) => img.path).toList(),
      };

      Navigator.pop(context, newService);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          widget.existingService != null ? "Edit Service" : "Add New Service",
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImagePicker("Main Image", _mainImage, isMain: true),
            buildMultiImagePicker(),
            SizedBox(height: 20),
            _buildDropdownTile("Category", _categories, _selectedCategory,
                (value) {
              setState(() {
                _selectedCategory = value;
                _selectedSubcategory = null;
              });
            }),
            SizedBox(height: 10),
            if (_selectedCategory != null)
              _buildDropdownTile(
                  "Subcategory",
                  _subcategories[_selectedCategory!]!,
                  _selectedSubcategory, (value) {
                setState(() {
                  _selectedSubcategory = value;
                });
              }),
            SizedBox(height: 10),
            _buildTextFieldTile("Service Name", _nameController),
            _buildTextFieldTile("Service Description", _descriptionController,
                maxLines: 3),
            _buildTextFieldTile("Price (₹)", _priceController,
                keyboardType: TextInputType.number),
            _buildTextFieldTile(
                "Estimated Duration ( hours )", _durationController),
            _buildTextFieldTile("Warranty Period", _warrantyController),
            _buildTextFieldTile("Discount / Offer (in %)", _offerController),
            _buildMultiSelectTile(
                "Technicians Available", _technicians, _selectedTechnicians),
            SizedBox(height: 10),
            SwitchListTile(
              tileColor: Theme.of(context).cardTheme.color,
              title: Text("Available",
                  style: Theme.of(context).textTheme.displayMedium),
              value: _isAvailable,
              onChanged: (value) {
                setState(() {
                  _isAvailable = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveService,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Center(
                  child: Text("Save Service", style: TextStyle(fontSize: 16))),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImagePicker(String title, File? image, {bool isMain = false}) {
    return GestureDetector(
      onTap: () => _pickImage(isMain),
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
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold)),
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
              onTap: () => _pickImage(false),
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

  Widget _buildTextFieldTile(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyLarge!,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.titleMedium,
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

  Widget _buildDropdownTile(String title, List<String> items,
      String? selectedValue, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      dropdownColor: Theme.of(context).cardTheme.color,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: Theme.of(context).textTheme.bodyLarge!,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textSecondary)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textSecondary)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
      onChanged: onChanged,
      items: items
          .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold))))
          .toList(),
    );
  }

  Widget _buildMultiSelectTile(
      String title, List<String> items, List<String> selectedItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((tech) => CheckboxListTile(
                title: Text(tech,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                value: selectedItems.contains(tech),
                onChanged: (selected) {
                  setState(() {
                    selected!
                        ? selectedItems.add(tech)
                        : selectedItems.remove(tech);
                  });
                },
              ))
          .toList(),
    );
  }
}
