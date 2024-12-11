import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';
import 'package:intl/intl.dart';

class FormularioNoDual extends StatelessWidget {
  const FormularioNoDual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Registro Usuario')),
      drawer: const AppDrawer(),
      body: const RegistroUsuario(),
    );
  }
}

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  bool esPrimerForm = false;
  final _formKeyUno = GlobalKey<FormState>();
  final _formKeyDos = GlobalKey<FormState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController edadHijosController = TextEditingController();
  final TextEditingController fechaNacController = TextEditingController();

  String? ciudadSeleccionada;
  List<String> ciudades = [
    "Almería",
    "Cádiz",
    "Córdoba",
    "Granada",
    "Huelva",
    "Jaén",
    "Málaga",
    "Sevilla"
  ];

  final Map<String, bool> intereses = {
    "Cocina": false,
    "Deporte": false,
    "Lectura": false,
    "Música": false,
    "Viajar": false
  };

  String generoSeleccionado = "Prefiero no contestar";
  bool tieneHijos = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _construyeSwitchForm(),
          const Divider(),
          Expanded(
            child: esPrimerForm
                ? Form(key: _formKeyDos, child: _construyeFormDos())
                : Form(key: _formKeyUno, child: _construyeFormUno()),
          ),
        ],
      ),
    );
  }

  // Widget para el interruptor que cambia entre formularios
  Widget _construyeSwitchForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Seleccionar formulario",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Switch(
          value: esPrimerForm,
          onChanged: (value) {
            setState(() => esPrimerForm = value);
          },
        ),
      ],
    );
  }

  // Primer formulario
  Widget _construyeFormUno() {
    return ListView(
      children: [
        _construyeCampoTexto(
          nombreController,
          "Nombre completo",
          "p. ej. María De Las Mercedes Montero",
          Icons.person,
          TextInputType.name,
          _validaNombre,
          textCapitalization: TextCapitalization.words,
        ),
        _construyeCampoTexto(
            emailController,
            "Correo electrónico",
            "p. ej. hola@info.es",
            Icons.email,
            TextInputType.emailAddress,
            _validaEmail),
        _construyeCampoTexto(telefonoController, "Teléfono", "p. ej. 951 92 33 01",
            Icons.phone, TextInputType.phone, _validaTelefono),
        const SizedBox(height: 18),
        _construyeSwitchHijos(),
        if (tieneHijos) _construyeCampoEdadHijos(),
        const SizedBox(height: 18),
        _construyeBotonEnviar(_formKeyUno),
      ],
    );
  }

  // Segundo formulario
  Widget _construyeFormDos() {
    return ListView(
      children: [
        _construyeCampoFecha(),
        const SizedBox(height: 8),
        _construyeDropdownCiudad(),
        const SizedBox(height: 18),
        const Text("Aficiones"),
        _construyeCheckboxIntereses(),
        const SizedBox(height: 18),
        const Text("Sexo"),
        _construyeOpcionesRadio(),
        const SizedBox(height: 18),
        _construyeBotonEnviar(_formKeyDos),
      ],
    );
  }

  // Campo de texto reutilizable con validación
  Widget _construyeCampoTexto(
      TextEditingController controller,
      String label,
      String hint,
      IconData icon,
      TextInputType keyboardType,
      String? Function(String?)? validator,
      {TextCapitalization textCapitalization = TextCapitalization.none}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        icon: Icon(icon),
      ),
      keyboardType: keyboardType,
      validator: validator,
      textCapitalization: textCapitalization,
    );
  }

  // Switch para preguntar si tiene hijos
  Widget _construyeSwitchHijos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('¿Tiene hijos?', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Switch(
          value: tieneHijos,
          onChanged: (value) => setState(() => tieneHijos = value),
        ),
      ],
    );
  }

  // Campo para la edad de los hijos, visible solo si tieneHijos es true
  Widget _construyeCampoEdadHijos() {
    return TextFormField(
      controller: edadHijosController,
      decoration: const InputDecoration(
        labelText: "Edad de los hijos (máximo 3)",
        hintText: 'p. ej. 6, 12, 29',
        icon: Icon(Icons.child_care),
      ),
      keyboardType: TextInputType.number,
      validator: _validaEdadHijos,
    );
  }

  // Campo de fecha para seleccionar la fecha de nacimiento
  Widget _construyeCampoFecha() {
    return TextFormField(
      controller: fechaNacController,
      decoration: const InputDecoration(
          labelText: 'Fecha de nacimiento',
          hintText: 'Seleccione fecha de nacimiento',
          icon: Icon(Icons.calendar_today)),
      readOnly: true,
      onTap: () async {
        DateTime? fechaSeleccionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          locale: const Locale("es", "ES"),
        );
        if (fechaSeleccionada != null) {
          setState(() {
            fechaNacController.text =
                DateFormat('dd/MM/yyyy', 'es_ES').format(fechaSeleccionada);
          });
        }
      },
      validator: _validaFechaNac,
    );
  }

  // Dropdown para seleccionar la ciudad
  Widget _construyeDropdownCiudad() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
          labelText: "Ciudad de Andalucía",
          hintText: 'Seleccione ciudad',
          icon: Icon(Icons.location_city_rounded)),
      value: ciudadSeleccionada,
      onChanged: (value) {
        setState(() {
          ciudadSeleccionada = value;
        });
      },
      items: ciudades.map((ciudad) {
        return DropdownMenuItem(value: ciudad, child: Text(ciudad));
      }).toList(),
      validator: _validaCiudad,
    );
  }

  // Campo de checkboxes para las aficiones
  Widget _construyeCheckboxIntereses() {
    return FormField<bool>(
      validator: (value) {
        // Valida si al menos una afición está seleccionada
        if (!intereses.values.any((interes) => interes)) {
          return "Por favor, seleccione al menos una afición";
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lista de checkboxes
            ...intereses.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                leading: Checkbox(
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      intereses[entry.key] = value ?? false;
                    });
                    // Llama a state.didChange() para actualizar el estado del FormField
                    state.didChange(null);
                  },
                ),
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              );
            }),
            // Mensaje de error
            if (state.hasError)
              Text(
                state.errorText!,
                style: TextStyle(color: Colors.redAccent.shade700, fontSize: 12),
              ),
          ],
        );
      },
    );
  }

  // Opciones de radio para seleccionar el sexo
  Widget _construyeOpcionesRadio() {
    return Column(
      children: ["Hombre", "Mujer", "Prefiero no contestar"].map((genero) {
        return ListTile(
          title: Text(genero),
          leading: Radio<String>(
            value: genero,
            groupValue: generoSeleccionado,
            onChanged: (value) {
              setState(() {
                generoSeleccionado = value!;
              });
            },
          ),
          visualDensity: const VisualDensity(vertical: -4),
        );
      }).toList(),
    );
  }

  // Botón para enviar el formulario
  Widget _construyeBotonEnviar(GlobalKey<FormState> formKey) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Datos enviados", textAlign: TextAlign.center)),
          );
        }
      },
      child: const Text("Enviar"),
    );
  }

  // Validación de campos de texto
  String? _validaNombre(String? value) {
    final nombreRegex =
        RegExp(r'^[A-ZÑÁÉÍÓÚ][a-zñáéíóú]*( [A-ZÑÁÉÍÓÚ][a-zñáéíóú]*)+$');
    if (value == null || value.isEmpty || !nombreRegex.hasMatch(value)) {
      return "Introduzca un nombre con el formato especificado";
    }
    return null;
  }

  String? _validaEmail(String? value) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value == null || !emailRegex.hasMatch(value)) {
      return "Introduzca un correo con el formato especificado";
    }
    return null;
  }

  String? _validaTelefono(String? value) {
    final phoneRegex = RegExp(r'^\d{3} \d{2} \d{2} \d{2}$');
    if (value == null || !phoneRegex.hasMatch(value)) {
      return "Introduzca un teléfono con el formato especificado";
    }
    return null;
  }

  String? _validaEdadHijos(String? value) {
    if (value == null || value.isEmpty) {
      return "Indique la edad de los hijos";
    }
    final edades = value.split(",");
    if (edades.length > 3) {
      return "Máximo 3 edades separadas por coma";
    }
    if (edades.any((edad) => int.tryParse(edad.trim()) == null)) {
      return "Use solo números separados por coma";
    }
    for (var edad in edades) {
      final edadHijo = int.tryParse(edad.trim());
      if (edadHijo == null || edadHijo < 0 || edadHijo > 99) {
        return "Cada edad debe ser un número entre 0 y 99";
      }
    }
    return null;
  }

  String? _validaFechaNac(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione su fecha de nacimiento';
    }
    try {
      DateFormat('dd/MM/yyyy', 'es_ES').parse(value);
    } catch (_) {
      return 'Formato de fecha inválido';
    }
    return null;
  }

  String? _validaCiudad(String? value) {
    if (value == null) {
      return "Por favor, seleccione su ciudad";
    }
    return null;
  }
}
