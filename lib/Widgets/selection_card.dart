import 'package:flutter/material.dart';
import 'package:tier_list/Widgets/glass_morphism.dart';
import 'package:tier_list/list.dart';

selectionCard(BuildContext context, Image image) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return glassMorphism(context,
          child: AlertDialog(
            title: const Text("Select Tier"),
            content: image,
            backgroundColor: Colors.transparent,
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              tierSelectionButton(context: context, list: sTierList, tierText: "S", image: image),
              tierSelectionButton(context: context, list: aTierList, tierText: "A", image: image),
              tierSelectionButton(context: context, list: bTierList, tierText: "B", image: image),
              tierSelectionButton(context: context, list: cTierList, tierText: "C", image: image),
              tierSelectionButton(context: context, list: dTierList, tierText: "D", image: image),
              tierSelectionButton(context: context, list: eTierList, tierText: "E", image: image),
              tierSelectionButton(context: context, list: fTierList, tierText: "F", image: image)
            ],
          ),
        );
      });
}

tierSelectionButton({required BuildContext context,required List<Image> list,required String tierText,required Image image}){
  return ElevatedButton(onPressed: (){
    if(!list.contains(image)) {
      list.add(image);
    }
    Navigator.pop(context);
  }, style: ElevatedButton.styleFrom(minimumSize: const Size(150, 60),backgroundColor: Colors.amber[900]),
  child: Text(tierText,style: const TextStyle(fontSize: 35),));
}
