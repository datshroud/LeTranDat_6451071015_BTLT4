import 'package:flutter/material.dart';

const appTitle = 'Lê Trần Đạt - 6451071015';

void main() {
  runApp(const PersonalInfoApp());
}

class PersonalInfoApp extends StatelessWidget {
  const PersonalInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PersonalInfoPage(),
    );
  }
}

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String? _selectedGender = 'Nam';
  String _maritalStatus = 'Doc than';
  double _income = 15;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  String? _validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui long nhap tuoi';
    }

    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Tuoi phai la so nguyen';
    }
    if (age <= 0) {
      return 'Tuoi phai > 0';
    }
    return null;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final summary =
        'Ten: ${_nameController.text}, tuoi: ${_ageController.text}, '
        'gioi tinh: $_selectedGender, hon nhan: $_maritalStatus, '
        'thu nhap: ${_income.toStringAsFixed(0)} tr VND';

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(summary)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ho va ten',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui long nhap ho va ten';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Tuoi',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateAge,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gioi tinh',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                    DropdownMenuItem(value: 'Nu', child: Text('Nu')),
                    DropdownMenuItem(value: 'Khac', child: Text('Khac')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Vui long chon gioi tinh' : null,
                ),
                const SizedBox(height: 20),
                Text(
                  'Tinh trang hon nhan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                RadioGroup<String>(
                  groupValue: _maritalStatus,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _maritalStatus = value;
                    });
                  },
                  child: Column(
                    children: const [
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Doc than'),
                        value: 'Doc than',
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Ket hon'),
                        value: 'Ket hon',
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Ly hon'),
                        value: 'Ly hon',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Muc thu nhap: ${_income.toStringAsFixed(0)} tr VND',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  min: 0,
                  max: 50,
                  divisions: 10,
                  value: _income,
                  label: '${_income.toStringAsFixed(0)} tr',
                  onChanged: (value) {
                    setState(() {
                      _income = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Luu thong tin'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
