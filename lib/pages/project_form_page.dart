import 'package:flutter/material.dart';
import '../models/project.dart';
import '../services/api_service.dart';

class ProjectFormPage extends StatefulWidget {
  @override
  _ProjectFormPageState createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _status = 'Em andamento';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newProject = Project(
        title: _title,
        description: _description,
        status: _status,
      );
      ApiService().createProject(newProject).then((_) {
        Navigator.pop(context);
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar projeto: $e')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Projeto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                onSaved: (value) => _title = value!,
                validator: (value) => value!.isEmpty ? 'Título é obrigatório' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => _description = value!,
                validator: (value) => value!.isEmpty ? 'Descrição é obrigatória' : null,
              ),
              DropdownButtonFormField<String>(
                value: _status,
                onChanged: (value) => setState(() => _status = value!),
                items: ['Em andamento', 'Concluído', 'Pendente']
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
