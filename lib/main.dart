import 'package:flutter/material.dart';
import 'package:form_field_widget_example/form_field_widget.dart';

void main() {
  runApp(const MaterialApp(home: ExampleFormPage()));
}

class ExampleFormPage extends StatefulWidget {
  const ExampleFormPage({super.key});

  @override
  State<ExampleFormPage> createState() => _ExampleFormPageState();
}

class _ExampleFormPageState extends State<ExampleFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _age;
  bool _acceptedTerms = false;
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FormFieldWidget Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// ---- TEXT FIELD ----
              FormFieldWidget<String>(
                initialValue: '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
                onSaved: (value) => _name = value,
                builder: (state) {
                  return TextField(
                    onChanged: state.didChange,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      border: InputBorder.none,
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              /// ---- DROPDOWN FIELD ----
              FormFieldWidget<int>(
                validator: (value) =>
                    value == null ? 'Please select your age' : null,
                onSaved: (value) => _age = value,
                builder: (state) {
                  return DropdownButton<int>(
                    value: state.value,
                    hint: const Text('Select age'),
                    isExpanded: true,
                    underline: const SizedBox(),
                    onChanged: state.didChange,
                    items: List.generate(
                      5,
                      (index) => DropdownMenuItem(
                        value: index + 18,
                        child: Text('${index + 18} years'),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              /// ---- CHECKBOX FIELD ----
              FormFieldWidget<bool>(
                initialValue: false,
                validator: (value) =>
                    value == true ? null : 'You must accept the terms',
                onSaved: (value) => _acceptedTerms = value ?? false,
                builder: (state) {
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: state.value ?? false,
                    onChanged: state.didChange,
                    title: const Text('Accept terms and conditions'),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),

              const SizedBox(height: 16),

              /// ---- CONTAINER (TAP TO CONFIRM) ----
              FormFieldWidget<bool>(
                initialValue: false,
                validator: (value) =>
                    value == true ? null : 'Please confirm selection',
                onSaved: (value) => _confirmed = value ?? false,
                builder: (state) {
                  final selected = state.value ?? false;

                  return GestureDetector(
                    onTap: () => state.didChange(!selected),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.grey.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: selected ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          const Text('Tap to confirm selection'),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Saved → name: $_name, age: $_age, '
                          'terms: $_acceptedTerms, confirmed: $_confirmed',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
