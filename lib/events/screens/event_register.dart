import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeway/events/models/event.dart';
import 'package:safeway/events/widgets/labels.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  File? _image;
  String? _selectedCategory;
  final picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();
  final Color customColor = const Color(0xFF52B0A5);

  List<String> errors = [];

  var categoryList = ['categoria 1', 'categoria 2', 'categoria 3'];
  var event = Event('', '');
  Future<void> _takePhoto() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage == null) {
        return;
      } else {
        _image = File(pickedImage.path);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar evento',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormLabels(
              text: 'Agrega una foto',
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    _takePhoto();
                  },
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _image == null
                          ? const Center(
                              child: Text(
                                'No se ha proporcionado una imagen',
                              ),
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit
                                  .cover, // Ajuste para cubrir el contenedor
                            ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(),
            const FormLabels(
              text: 'Categoría',
            ),
            Center(
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  isExpanded: true,
                  itemHeight: 60,
                  underline: Container(
                    height: 1,
                    color: Colors.transparent,
                  ),
                  items: categoryList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: ListTile(
                        title: Text(
                          value,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(), // Convierte el iterable a una lista
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  value: _selectedCategory,
                ),
              ),
            ),
            const FormLabels(
              text: 'Detalles',
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 4,
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Ingresa detalles del evento',
                      hintStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 60,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(customColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // radio para cambiar la esquina del rectángulo
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                          color: Colors.transparent,
                          width:
                              2.0), // Establece el color y el ancho del borde
                    ),
                  ),
                  onPressed: () {
                    if (_image == null ||
                        _selectedCategory == null ||
                        _controller.text.isEmpty) {
                      // Aquí puedes mostrar un diálogo de error, una Snackbar o cualquier otro tipo de mensaje
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Por favor completa todos los campos.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: customColor),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {}
                  },
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
