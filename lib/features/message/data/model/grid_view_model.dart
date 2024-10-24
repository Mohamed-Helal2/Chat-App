import 'package:flutter/material.dart';

class GridViewModel {
  final String name;
  final Icon icon; // Assuming you use an Icon widget
  final String actionType; // Type of action associated with this item

  GridViewModel({required this.name, required this.icon, required this.actionType});
}


List<GridViewModel> gridviewitem = [
  GridViewModel(
      icon: const Icon(Icons.camera, size: 35, color: Colors.red),
      name: 'Camera',
      actionType: 'camera'
      ),
  GridViewModel(
      icon: const Icon(Icons.photo, size: 35, color: Colors.blue),
      name: 'Gallery',
        actionType: 'Gallery'
      ),
  GridViewModel(
      icon: const Icon(
        Icons.picture_as_pdf,
        size: 35,
        color: Colors.white,
      ),
      name: 'Pdf',
      actionType: 'pdf'
      ),
  GridViewModel(
      icon: const Icon(Icons.location_history, color: Colors.green, size: 35),
      name: 'Location',
      actionType: 'Location'
      )
];
