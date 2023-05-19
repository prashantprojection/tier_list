import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tier_list/Widgets/glass_morphism.dart';

class TierList extends StatefulWidget {
  const TierList({required this.text, required this.imageList, super.key});
  final String text;
  final List<Image> imageList;

  @override
  State<TierList> createState() => _TierListState();
}

class _TierListState extends State<TierList> {
  bool padding = false;
  @override
  Widget build(BuildContext context) {
    return glassMorphism(
      context,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              child: Text(widget.text, style: const TextStyle(fontSize: 35)),
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.grey.withOpacity(0.25),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageList.length,
                    dragStartBehavior: DragStartBehavior.start,
                    itemBuilder: (context, item) {
                      return GestureDetector(
                        child: Stack(children: [
                          Container(padding: EdgeInsets.all(padding ? 10 : 0),child: widget.imageList[item],),
                          if(padding)
                          Positioned(
                            top: -9,right: -10,
                            child: IconButton(onPressed: () {
                              setState(() {
                                padding = !padding;
                              widget.imageList.removeAt(item);
                              });
                            },icon: const Icon(Icons.cancel),),
                          )
                        ],),
                        onLongPress: () {
                          setState(() {
                          padding = !padding;
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 2.5)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
