import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class EditTechnicianScreen extends StatefulWidget {
  final Map<String, dynamic> technicianData;

  const EditTechnicianScreen({super.key, required this.technicianData});

  @override
  _EditTechnicianScreenState createState() => _EditTechnicianScreenState();
}

class _EditTechnicianScreenState extends State<EditTechnicianScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _experienceController;
  late TextEditingController _expertiseController;
  late TextEditingController _aboutController;

  bool _isAvailable = true;
  File? _technicianImage;
  List<String> _selectedAreas = [];
  List<File> _documents = [];

  final List<String> _allAreas = [
    "Lucknow - 226001",
    "Kanpur - 208001",
    "Delhi - 110001"
  ];

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
    _nameController = TextEditingController(text: widget.technicianData["name"]);
    _phoneController = TextEditingController(text: widget.technicianData["phone"]);
    _addressController = TextEditingController(text: widget.technicianData["address"]);
    _experienceController = TextEditingController(text: widget.technicianData["experience"].toString());
    _expertiseController = TextEditingController(text: widget.technicianData["expertise"]);
    _aboutController = TextEditingController(text: widget.technicianData["about"]);
    _selectedTimeSlot = widget.technicianData["timeAvailability"] ?? "9 AM - 12 PM";
    _isAvailable = widget.technicianData["isAvailable"];
    _selectedAreas = List<String>.from(widget.technicianData["areaCoverage"]);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _technicianImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDocuments() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _documents.add(File(pickedFile.path));
      });
    }
  }

  void _updateTechnician() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedTechnician = {
        "name": _nameController.text,
        "phone": _phoneController.text,
        "address": _addressController.text,
        "experience": int.parse(_experienceController.text),
        "expertise": _expertiseController.text,
        "timeAvailability": _selectedTimeSlot,
        "about": _aboutController.text,
        "isAvailable": _isAvailable,
        "areaCoverage": _selectedAreas,
        "image": _technicianImage?.path ?? widget.technicianData["image"],
        "documents": _documents.map((doc) => doc.path).toList(),
      };
      
      Navigator.pop(context, updatedTechnician);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimary,
        title: Text("Edit Technician", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildImagePicker(_technicianImage),
              _buildTextField("Technician Name", _nameController),
              _buildTextField("Phone Number", _phoneController, keyboardType: TextInputType.phone),
              _buildTextField("Address", _addressController),
              _buildTextField("Experience (Years)", _experienceController, keyboardType: TextInputType.number),
              _buildTextField("Expertise", _expertiseController),
              _buildTimeAvailabilitySection(),
              _buildTextField("About Technician", _aboutController, maxLines: 3),
              _buildMultiSelectDropdown("Area Coverage", _allAreas, _selectedAreas),
              SwitchListTile(
                title: Text("Available", style: TextStyle(color: Colors.white)),
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
              ),
              _buildFileUploadSection(),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _updateTechnician, child: Text("Update Technician")),
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
