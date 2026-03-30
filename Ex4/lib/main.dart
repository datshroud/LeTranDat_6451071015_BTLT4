import 'package:flutter/material.dart';

const appTitle = 'Lê Trần Đạt - 6451071015';

void main() {
  runApp(const AppointmentApp());
}

class AppointmentApp extends StatelessWidget {
  const AppointmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const AppointmentPage(),
    );
  }
}

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService = 'Kiem tra tong quat';

  Future<void> _pickDate(FormFieldState<DateTime> field) async {
    final initialDate = _selectedDate ?? DateUtils.dateOnly(DateTime.now());
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = DateUtils.dateOnly(pickedDate);
    });
    field.didChange(_selectedDate);
  }

  Future<void> _pickTime(FormFieldState<TimeOfDay> field) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime == null) {
      return;
    }

    setState(() {
      _selectedTime = pickedTime;
    });
    field.didChange(_selectedTime);
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final summary =
        'Dat lich $_selectedService vao ${_formatDate(_selectedDate!)} '
        'luc ${_formatTime(_selectedTime!)}';

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(summary)));
  }

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());

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
                FormField<DateTime>(
                  initialValue: _selectedDate,
                  validator: (value) {
                    if (value == null) {
                      return 'Vui long chon ngay';
                    }
                    if (DateUtils.dateOnly(value).isBefore(today)) {
                      return 'Ngay khong duoc trong qua khu';
                    }
                    return null;
                  },
                  builder: (field) {
                    return InkWell(
                      onTap: () => _pickDate(field),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Chon ngay',
                          border: const OutlineInputBorder(),
                          errorText: field.errorText,
                          suffixIcon: const Icon(Icons.date_range),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? 'Select date'
                              : _formatDate(_selectedDate!),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                FormField<TimeOfDay>(
                  initialValue: _selectedTime,
                  validator: (value) {
                    if (value == null) {
                      return 'Vui long chon gio';
                    }
                    return null;
                  },
                  builder: (field) {
                    return InkWell(
                      onTap: () => _pickTime(field),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Chon gio',
                          border: const OutlineInputBorder(),
                          errorText: field.errorText,
                          suffixIcon: const Icon(Icons.access_time),
                        ),
                        child: Text(
                          _selectedTime == null
                              ? 'Chon gio'
                              : _formatTime(_selectedTime!),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedService,
                  decoration: const InputDecoration(
                    labelText: 'Chon dich vu',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Kiem tra tong quat',
                      child: Text('Kiem tra tong quat'),
                    ),
                    DropdownMenuItem(
                      value: 'Dich vu 2',
                      child: Text('Dich vu 2'),
                    ),
                    DropdownMenuItem(
                      value: 'Dich vu 3',
                      child: Text('Dich vu 3'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedService = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Vui long chon dich vu' : null,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _submit,
                  child: const Text('Xac nhan dat lich'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
