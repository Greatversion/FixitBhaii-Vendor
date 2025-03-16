import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class AddEditTechnicianScreen extends StatefulWidget {
  final Map<String, dynamic>? existingTechnician;

  const AddEditTechnicianScreen({super.key, this.existingTechnician});

  @override
  _AddEditTechnicianScreenState createState() =>
      _AddEditTechnicianScreenState();
}

class _AddEditTechnicianScreenState extends State<AddEditTechnicianScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  bool _isAvailable = true;
  File? _technicianImage;
  List<String> _selectedAreas = [];
  final List<String> _allAreas = [
    "Lucknow - 226001",
    "Kanpur - 208001",
    "Delhi - 110001"
  ];
  final List<File> _documents = [];

  final List<String> _timeSlots = [
    "9 AM - 12 PM",
    "12 PM - 7 PM",
    "9 AM - 7 PM",
    "7 PM - 11 PM",
    "5 PM - 11 PM",
  ];
  String _selectedTimeSlot = "9 AM - 12 PM";

  @override
  void initState() {
    super.initState();
    if (widget.existingTechnician != null) {
      _nameController.text = widget.existingTechnician!["name"];
      _phoneController.text = widget.existingTechnician!["phone"];
      _addressController.text = widget.existingTechnician!["address"];
      _experienceController.text =
          widget.existingTechnician!["experience"].toString();
      _expertiseController.text = widget.existingTechnician!["expertise"];
      _selectedTimeSlot =
          widget.existingTechnician!["timeAvailability"] ?? "9 AM - 12 PM";
      _aboutController.text = widget.existingTechnician!["about"];
      _isAvailable = widget.existingTechnician!["isAvailable"];
      _selectedAreas =
          List<String>.from(widget.existingTechnician!["areaCoverage"]);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _technicianImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDocuments() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _documents.add(File(pickedFile.path));
      });
    }
  }

  void _saveTechnician() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> newTechnician = {
        "name": _nameController.text,
        "phone": _phoneController.text,
        "address": _addressController.text,
        "experience": int.parse(_experienceController.text),
        "expertise": _expertiseController.text,
        "timeAvailability": _selectedTimeSlot,
        "about": _aboutController.text,
        "isAvailable": _isAvailable,
        "areaCoverage": _selectedAreas,
        "image": _technicianImage?.path ?? widget.existingTechnician?["image"],
        "documents": _documents.map((doc) => doc.path).toList(),
      };

      // TODO: Implement database save function

      Navigator.pop(context, newTechnician);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimary,
        title: Text(
          widget.existingTechnician != null
              ? "Edit Technician"
              : "Add Technician",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildImagePicker(_technicianImage),
              SizedBox(height: 16),
              _buildTextField("Technician Name", _nameController),
              _buildTextField("Phone Number", _phoneController,
                  keyboardType: TextInputType.phone),
              _buildTextField("Address", _addressController),
              _buildTextField("Experience (Years)", _experienceController,
                  keyboardType: TextInputType.number),
              _buildTextField(
                  "Expertise (separated by comma)", _expertiseController),
              _buildTimeAvailabilitySection(),
              _buildTextField("About Technician", _aboutController,
                  maxLines: 3),
              _buildMultiSelectDropdown(
                  "Area Coverage", _allAreas, _selectedAreas),
              SwitchListTile(
                title: Text(
                  "Available",
                  style: TextStyle(color: Colors.white),
                ),
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
              ),
              _buildFileUploadSection(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTechnician,
                child: Text("Save Technician"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: const Color.fromARGB(255, 138, 137, 137)),
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

  Widget buildImagePicker(File? image) {
    return GestureDetector(
      onTap: () => _pickImage(),
      child: Container(
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
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

  Widget _buildTimeAvailabilitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Time Availability",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: _timeSlots.map((slot) {
              bool isSelected = _selectedTimeSlot == slot;
              return ChoiceChip(
                label: Text(slot),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedTimeSlot = slot;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectDropdown(
      String label, List<String> options, List<String> selectedItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          Wrap(
            spacing: 8.0,
            children: options.map((area) {
              bool isSelected = selectedItems.contains(area);
              return FilterChip(
                label: Text(area),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedItems.add(area);
                    } else {
                      selectedItems.remove(area);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Documents",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _pickDocuments,
          icon: Icon(Icons.upload),
          label: Text("Upload Aadhar/PAN/GST"),
        ),
      ],
    );
  }
}
