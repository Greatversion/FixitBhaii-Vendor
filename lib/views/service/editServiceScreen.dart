import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

@RoutePage()
class EditServiceScreen extends StatefulWidget {
  final Map<String, dynamic> serviceData;

  EditServiceScreen({required this.serviceData});

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _durationController;
  late TextEditingController _warrantyController;
  late TextEditingController _offerController;

  bool _isAvailable = true;
  File? _mainImage;
  List<File> _subImages = [];

  String? _selectedCategory;
  String? _selectedSubcategory;
  List<String> _selectedTechnicians = [];

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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.serviceData["name"] ?? "";
    _descriptionController.text = widget.serviceData["description"] ?? "";
    _priceController.text = widget.serviceData["price"]?.toString() ?? "";
    _durationController.text = widget.serviceData["duration"] ?? "";
    _warrantyController.text = widget.serviceData["warranty"] ?? "";
    _offerController.text = widget.serviceData["offer"]?.toString() ?? "";
    _isAvailable = widget.serviceData["isAvailable"] ?? true;
    _selectedCategory = widget.serviceData["category"];
    _selectedSubcategory = widget.serviceData["subcategory"];
    _selectedTechnicians =
        List<String>.from(widget.serviceData["technicians"] ?? []);
    _mainImage = widget.serviceData["mainImage"] != null
        ? File(widget.serviceData["mainImage"])
        : null;
    _subImages = (widget.serviceData["subImages"] as List?)
            ?.map((path) => File(path))
            .toList() ??
        [];
  }

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

  void _updateService() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedService = {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": double.parse(_priceController.text),
        "duration": _durationController.text,
        "warranty": _warrantyController.text,
        "offer": _offerController.text,
        "isAvailable": _isAvailable,
        "category": _selectedCategory,
        "subcategory": _selectedSubcategory,
        "technicians": _selectedTechnicians,
        "mainImage": _mainImage?.path ?? widget.serviceData['mainImage'],
        "subImages": _subImages.isNotEmpty
            ? _subImages.map((img) => img.path).toList()
            : widget.serviceData['subImages'],
      };
      Navigator.pop(context, updatedService);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text("✏️ Edit Service", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Service Name", _nameController),
              _buildTextField("Description", _descriptionController,
                  maxLines: 3),
              _buildTextField("Price (₹)", _priceController,
                  keyboardType: TextInputType.number),
              _buildTextField("Duration (Hours)", _durationController),
              _buildTextField("Warranty", _warrantyController),
              _buildTextField("Offer (Discount %)", _offerController),
              SwitchListTile(
                title: Text("Available", style: TextStyle(color: Colors.white)),
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Center(
                  child: Text("Update Service", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400]),
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
