import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cci_app/config.dart';
import 'package:get/get.dart';

class MyPickerWidget extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String>? onItemSelected;
  // Si fourni, affiche un bouton "Proposer un nouveau type" sous la liste,
  // permettant à un enquêteur de soumettre un type absent de la liste — il
  // sera enregistré en attente de validation par un chercheur (point 2 de la
  // section infrastructures de l'e-mail d'Ahmed), sans être ajouté
  // directement à la liste active.
  final ValueChanged<String>? onSuggestNew;

  MyPickerWidget({required this.options, this.onItemSelected, this.onSuggestNew});

  Future<void> _showSuggestDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final String? value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Proposer un nouveau type'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nom du type ...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );
    if (value != null && value.isNotEmpty && onSuggestNew != null) {
      onSuggestNew!(value);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proposition envoyée, en attente de validation par un chercheur.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(200),
            child: CupertinoPicker(
              itemExtent: 30,
              onSelectedItemChanged: (index) {
                if (onItemSelected != null) {
                  onItemSelected!(options[index]);
                }
              },
              children: options.map((item) => Text(item)).toList(),
            ),
          ),
          if (onSuggestNew != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextButton.icon(
                onPressed: () => _showSuggestDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Proposer un nouveau type'),
              ),
            ),
        ],
      ),
    );
  }
}
