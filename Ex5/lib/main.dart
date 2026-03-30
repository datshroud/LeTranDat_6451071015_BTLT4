import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

const appTitle = 'Lê Trần Đạt - 6451071015';

void main() {
  runApp(const JobApplicationApp());
}

class JobApplicationApp extends StatelessWidget {
  const JobApplicationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const JobApplicationPage(),
    );
  }
}

class JobApplicationPage extends StatefulWidget {
  const JobApplicationPage({super.key});

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  PlatformFile? _selectedCv;
  bool _confirmedInfo = false;
  bool _showConfirmationError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickCv(FormFieldState<PlatformFile> field) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'doc', 'docx'],
      dialogTitle: 'Chon CV',
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    setState(() {
      _selectedCv = result.files.single;
    });
    field.didChange(_selectedCv);
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui long nhap email';
    }

    const emailPattern = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
    if (!RegExp(emailPattern).hasMatch(value.trim())) {
      return 'Email khong hop le';
    }
    return null;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    setState(() {
      _showConfirmationError = !_confirmedInfo;
    });

    if (!isValid || !_confirmedInfo) {
      return;
    }

    final summary =
        'Da nop ho so: ${_nameController.text} - CV ${_selectedCv!.name}';

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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 12),
                FormField<PlatformFile>(
                  initialValue: _selectedCv,
                  validator: (value) {
                    if (value == null) {
                      return 'Vui long upload CV cua ban';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'File CV (PDF, DOC, DOCX)',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () => _pickCv(field),
                          icon: const Icon(Icons.attach_file),
                          label: Text(
                            _selectedCv == null
                                ? 'Chon tep CV'
                                : _selectedCv!.name,
                          ),
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 4),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _confirmedInfo,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('Toi xac nhan thong tin la chinh xac'),
                  onChanged: (value) {
                    setState(() {
                      _confirmedInfo = value ?? false;
                      if (_confirmedInfo) {
                        _showConfirmationError = false;
                      }
                    });
                  },
                ),
                if (_showConfirmationError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 12),
                    child: Text(
                      'Vui long xac nhan thong tin truoc khi nop',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _submit,
                  child: const Text('Nop ho so'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
