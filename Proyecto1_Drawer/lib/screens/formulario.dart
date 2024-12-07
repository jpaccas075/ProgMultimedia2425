import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:numberpicker/numberpicker.dart';

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Registro Videojuego')),
      drawer: const AppDrawer(),
      body: const RegistroVideojuego(),
    );
  }
}

class RegistroVideojuego extends StatefulWidget {
  const RegistroVideojuego({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistroVideojuegoState createState() => _RegistroVideojuegoState();
}

class _RegistroVideojuegoState extends State<RegistroVideojuego> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fechaController = TextEditingController();

  // Variables de estado para los campos del formulario
  String? _generoSeleccionado;
  String _estadoSeleccionado = 'Nuevo';
  bool _esIndie = false;
  bool _aceptoTerminos = false;
  double _notaJuego = 5;
  int _numberPickerValue = 50;
  int _numAleatorio = Random().nextInt(100) + 1;

  // Errores personalizados para validaciones adicionales
  String? _checkboxError;
  String? _numberPickerError;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null); // Inicializa las configuraciones de fecha
  }

  @override
  Widget build(BuildContext context) {
    // Estructura principal del formulario
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _construyeCampoTexto(
              label: 'Nombre',
              hint: 'Nombre del videojuego',
              icon: Icons.videogame_asset,
              keyboardType: TextInputType.text,
              textCapitalization:
                  TextCapitalization.sentences, // Capitalización específica
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce el nombre del videojuego';
                }
                if (value[0] != value[0].toUpperCase()) {
                  return 'El nombre debe comenzar con una letra mayúscula';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            _construyeCampoTexto(
              label: 'Email',
              hint: 'Correo de la empresa desarrolladora',
              icon: Icons.mail,
              keyboardType: TextInputType.emailAddress,
              textCapitalization:
                  TextCapitalization.none, // Sin capitalización automática
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce el correo de la empresa';
                }
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(value)) {
                  return 'Por favor, introduce un correo válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            _construyeCampoFecha(),
            const SizedBox(height: 8),
            _construyeCampoDropdown(),
            const SizedBox(height: 18),
            _construyeOpcionesRadio(),
            const SizedBox(height: 18),
            _construyeSlider(),
            const SizedBox(height: 8),
            _construyeSwitch(),
            const SizedBox(height: 18),
            _construyeNumberPicker(),
            const SizedBox(height: 18),
            _construyeCheckbox(),
            const SizedBox(height: 8),
            _construyeBotonRegistrar(),
          ],
        ),
      ),
    );
  }

  // Campo de texto reutilizable
  Widget _construyeCampoTexto({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        icon: Icon(icon),
      ),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization, // Configuración de capitalización
      validator: validator, // Validación personalizada
    );
  }

  // Campo de selección de fecha
  Widget _construyeCampoFecha() {
    return TextFormField(
      controller: _fechaController,
      decoration: const InputDecoration(
        labelText: 'Fecha',
        hintText: 'Fecha de salida',
        icon: Icon(Icons.event),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? fechaSeleccionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          locale: const Locale("es", "ES"),
        );

        if (fechaSeleccionada != null) {
          setState(() {
            _fechaController.text = DateFormat('dd/MM/yyyy', 'es_ES')
                .format(fechaSeleccionada);
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecciona una fecha de salida';
        }
        try {
          final fechaIntroducida =
              DateFormat('dd/MM/yyyy', 'es_ES').parse(value);
          if (fechaIntroducida.isAfter(DateTime.now())) {
            return 'La fecha de salida no puede ser posterior a la actual';
          }
        } catch (_) {
          return 'Formato de fecha inválido';
        }
        return null;
      },
    );
  }

  // Campo de selección de género con DropdownButton
  Widget _construyeCampoDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Género',
        icon: Icon(Icons.category),
      ),
      value: _generoSeleccionado,
      onChanged: (valorNuevo) => setState(() => _generoSeleccionado = valorNuevo),
      validator: (value) =>
          value == null ? 'Por favor, selecciona un género' : null,
      items: [
        'Aventuras',
        'Acción',
        'Deportes',
        'Educativo',
        'Plataformas',
      ].map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
    );
  }

  // Opciones de estado (Nuevo/Usado)
  Widget _construyeOpcionesRadio() {
    return Column(
      children: ['Nuevo', 'Usado'].map((estado) {
        return ListTile(
          title: Text(estado),
          leading: Radio<String>(
            value: estado,
            groupValue: _estadoSeleccionado,
            onChanged: (value) => setState(() => _estadoSeleccionado = value!),
          ),
          visualDensity: const VisualDensity(vertical: -4),
        );
      }).toList(),
    );
  }

  // Campo para calificación con Slider
  Widget _construyeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Nota: ${_notaJuego.toInt()}'),
        Slider(
          value: _notaJuego,
          min: 0,
          max: 10,
          onChanged: (value) => setState(() => _notaJuego = value),
        ),
      ],
    );
  }

  // Switch para indicar si el juego es Indie
  Widget _construyeSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('¿Es un juego Indie?', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Switch(
          value: _esIndie,
          onChanged: (value) => setState(() => _esIndie = value),
        ),
      ],
    );
  }

  // Selector numérico con validación
  Widget _construyeNumberPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: NumberPicker(
                minValue: 1,
                maxValue: 100,
                value: _numberPickerValue,
                axis: Axis.horizontal,
                itemWidth: 50,
                onChanged: (value) => setState(() => _numberPickerValue = value),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _numAleatorio = Random().nextInt(100) + 1;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nuevo número aleatorio: $_numAleatorio',
                          textAlign: TextAlign.center),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                });
              },
              child: const Icon(Icons.restart_alt_rounded),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('"Pista": $_numAleatorio'),
        if (_numberPickerError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _numberPickerError!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
    );
  }

  // Checkbox para términos y condiciones
  Widget _construyeCheckbox() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text(
            'Acepto los términos y condiciones de la biblioteca digital',
            textAlign: TextAlign.center,
          ),
          value: _aceptoTerminos,
          onChanged: (value) => setState(() => _aceptoTerminos = value ?? false),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        if (_checkboxError != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              _checkboxError!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
    );
  }

  // Botón de registro
  Widget _construyeBotonRegistrar() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _checkboxError = !_aceptoTerminos
              ? 'Debe aceptar los términos y condiciones'
              : null;

          _numberPickerError = _numberPickerValue != _numAleatorio
              ? (_numberPickerValue < _numAleatorio
                  ? 'El número debería ser mayor'
                  : 'El número debería ser menor')
              : null;

          if (_formKey.currentState!.validate() &&
              _aceptoTerminos &&
              _numberPickerError == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Videojuego registrado con éxito',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        });
      },
      child: const Text('Registrar'),
    );
  }
}
