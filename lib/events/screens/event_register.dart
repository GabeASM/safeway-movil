import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final Color borderColor = const Color(0xFF3C3C43);

  var categoryList = ['categoria 1', 'categoria 2', 'categoria 3'];

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
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _image == null
                          ? const Center(
                              child: Text('No se ha proporcionado una imagen'),
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
              child: SizedBox(
                width: 300,
                height: 60,
                child: DropdownButton(
                  isExpanded: true,
                  itemHeight: 50,
                  underline: Container(
                    height: 1,
                    color: Colors.blue,
                  ),
                  items: categoryList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
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
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(customColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ajusta el radio para cambiar la esquina del rectángulo
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                          color: borderColor,
                          width:
                              2.0), // Establece el color y el ancho del borde
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                        color: borderColor, fontWeight: FontWeight.bold),
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
