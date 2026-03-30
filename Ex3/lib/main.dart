import 'package:flutter/material.dart';

const appTitle = 'Lê Trần Đạt - 6451071015';

void main() {
  runApp(const SurveyApp());
}

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SurveyPage(),
    );
  }
}

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();

  final List<String> _interestOptions = const [
    'Phim anh',
    'The thao',
    'Am nhac',
    'Du lich',
  ];

  final Set<String> _selectedInterests = <String>{};
  String? _selectedSatisfaction = 'Hai long';

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final summary =
        'So thich: ${_selectedInterests.join(', ')}, '
        'muc do hai long: $_selectedSatisfaction';

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
                FormField<List<String>>(
                  initialValue: _selectedInterests.toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ban phai chon it nhat 1 so thich';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'So thich',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ..._interestOptions.map((interest) {
                          return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _selectedInterests.contains(interest),
                            title: Text(interest),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) {
                              setState(() {
                                if (value ?? false) {
                                  _selectedInterests.add(interest);
                                } else {
                                  _selectedInterests.remove(interest);
                                }
                              });
                              field.didChange(_selectedInterests.toList());
                            },
                          );
                        }),
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
                const SizedBox(height: 20),
                FormField<String>(
                  initialValue: _selectedSatisfaction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui long chon muc do hai long';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Muc do hai long',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        RadioGroup<String>(
                          groupValue: _selectedSatisfaction,
                          onChanged: (value) {
                            setState(() {
                              _selectedSatisfaction = value;
                            });
                            field.didChange(value);
                          },
                          child: Column(
                            children: const [
                              RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Hai long'),
                                value: 'Hai long',
                              ),
                              RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Binh thuong'),
                                value: 'Binh thuong',
                              ),
                              RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Chua hai long'),
                                value: 'Chua hai long',
                              ),
                            ],
                          ),
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Ghi chu them',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Gui khao sat'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
