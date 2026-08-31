import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cci_app/config.dart';

/// Permet à l'enquêteur de pointer manuellement la localisation d'un village
/// sur une carte OpenStreetMap, plutôt que de dépendre uniquement du GPS —
/// utile quand on saisit un village a posteriori, sans être sur place
/// (demande d'Ahmed : "on n'est pas toujours sur les lieux").
///
/// Retourne un objet [LatLng] via Navigator.pop si l'utilisateur confirme un
/// point, ou null s'il annule.
class VillageMapPicker extends StatefulWidget {
  final Position? initialPosition;

  const VillageMapPicker({super.key, this.initialPosition});

  @override
  State<VillageMapPicker> createState() => _VillageMapPickerState();
}

class _VillageMapPickerState extends State<VillageMapPicker> {
  late LatLng _selectedPoint;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Centre par défaut : la position GPS actuelle si disponible, sinon le
    // centre approximatif du Maroc.
    _selectedPoint = widget.initialPosition != null
        ? LatLng(widget.initialPosition!.latitude, widget.initialPosition!.longitude)
        : LatLng(31.7917, -7.0926);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8A74),
        title: const Text('Localiser le village sur la carte'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16), vertical: getProportionateScreenHeight(8)),
            child: Text(
              'Touchez la carte pour placer le repère à l\'emplacement du village, ou déplacez-le.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _selectedPoint,
                zoom: 13,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedPoint = point;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.lachaire_ECC.ma',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedPoint,
                      width: 40,
                      height: 40,
                      builder: (context) => Icon(
                        Icons.location_pin,
                        color: Color(0xFF0F8A74),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(16)),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedPoint);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF0F8A74)),
                minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
              ),
              child: const Text('Confirmer cet emplacement', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
