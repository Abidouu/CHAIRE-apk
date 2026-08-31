import 'package:cci_app/config.dart';
import 'package:flutter/material.dart';
import 'package:cci_app/collecte/collecte_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:cci_app/login/waiting_block.dart';
import 'package:cci_app/models/intervale.dart';
import 'package:cci_app/models/village_reference.dart';
import 'package:cci_app/services/loc_service.dart';
import 'package:cci_app/services/village_reference_service.dart';

import 'n_dowar_block.dart';
import 'village_map_picker.dart';

class N_douarPage extends StatefulWidget {

  final Position currentPosition;

  N_douarPage({super.key, required this.currentPosition});

  @override
  State<N_douarPage> createState() => _N_douarPageState();
}

class _N_douarPageState extends State<N_douarPage> {
  final NewDowarBlock newDowarBlock = Get.put(NewDowarBlock());
  final IntervalService intervalservice = Get.put(IntervalService());
  final VillageReferenceService villageReferenceService = VillageReferenceService();

  final TextEditingController nameController = TextEditingController();
  String Dname = '';
  // Coordonnées retenues pour créer le village : par défaut celles du GPS,
  // remplacées si l'enquêteur choisit un point sur la carte, ou sélectionne
  // un village existant dans la base de référence (point 1 de l'e-mail
  // d'Ahmed).
  late double _latitude;
  late double _longitude;
  bool _fromMap = false;
  List<VillageReference> _searchResults = [];
  bool _searching = false;

  @override
  void initState() {
    super.initState();
    _latitude = widget.currentPosition.latitude;
    _longitude = widget.currentPosition.longitude;
  }

  Future<void> _chooseOnMap() async {
    final LatLng? picked = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VillageMapPicker(initialPosition: widget.currentPosition),
      ),
    );
    if (picked != null) {
      setState(() {
        _latitude = picked.latitude;
        _longitude = picked.longitude;
        _fromMap = true;
      });
    }
  }

  Future<void> _searchExisting(String query) async {
    setState(() {
      _searching = true;
    });
    final results = await villageReferenceService.searchByName(query);
    if (mounted) {
      setState(() {
        _searchResults = results;
        _searching = false;
      });
    }
  }

  void _selectExisting(VillageReference village) {
    setState(() {
      nameController.text = village.name;
      Dname = village.name;
      _latitude = village.latitude;
      _longitude = village.longitude;
      _fromMap = true;
      _searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            SizedBox(height: getProportionateScreenHeight(60)),
            const Center(
              child: Text("Cette localisation n'est pas dans notre Base de données. Merci d'indiquer le nom de ce village:",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color:Color(0xFF0F8A74), fontSize: 24 )),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildnameTextField(),
            if (_searching)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            if (_searchResults.isNotEmpty) _buildSearchResults(),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildMapButton(),
            if (_fromMap)
              Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(8)),
                child: Text(
                  'Emplacement retenu : ${_latitude.toStringAsFixed(5)}, ${_longitude.toStringAsFixed(5)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xFF0F8A74)),
                ),
              ),
            SizedBox(height: getProportionateScreenHeight(80)),
            _buildcollecteButton()
          ],
        ),
        ]),
    );
  }

  Widget _buildnameTextField() {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(24)),
      child: TextField(
        controller: nameController,
        keyboardType: TextInputType.emailAddress,
        onChanged: (text) {
          Dname = text;
          if (text.trim().length >= 2) {
            _searchExisting(text);
          } else {
            setState(() {
              _searchResults = [];
            });
          }
        },
        decoration: InputDecoration(
          labelText: 'Nom',
          hintText: 'Entrer le nom (ou rechercher un village existant)',
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(24)),
      constraints: BoxConstraints(maxHeight: getProportionateScreenHeight(180)),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF0F8A74)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final village = _searchResults[index];
          return ListTile(
            dense: true,
            title: Text(village.name),
            subtitle: Text(village.province.isNotEmpty ? village.province : village.region),
            onTap: () => _selectExisting(village),
          );
        },
      ),
    );
  }

  Widget _buildMapButton() {
    return Center(
      child: OutlinedButton.icon(
        onPressed: _chooseOnMap,
        icon: Icon(Icons.map, color: Color(0xFF0F8A74)),
        label: Text(
          _fromMap ? 'Modifier l\'emplacement sur la carte' : 'Choisir l\'emplacement sur la carte',
          style: TextStyle(color: Color(0xFF0F8A74)),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF0F8A74)),
        ),
      ),
    );
  }

  Widget _buildcollecteButton() {
    return Container(
        child: ElevatedButton(
          onPressed: () async{

            CoordinateInterval currentInterval = _fromMap
                ? intervalservice.newIntervalFromCoordinates(_latitude, _longitude)
                : await intervalservice.newInterval(widget.currentPosition);
            intervalservice.saveInterval(currentInterval);
            newDowarBlock.saveDowar(currentInterval.intervalId!, Dname);
            Get.to(() => CollectePage());
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF0F8A74)), // set background color
            minimumSize: MaterialStateProperty.all<Size>(
                const Size(250, 50)), // set minimum size
            // You can also use fixedSize property to set the exact button size
          ),
          child: const Text("Continuer",textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
        ));
  }
}
