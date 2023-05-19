import 'package:flutter/material.dart';
import 'package:tier_list/API/image_search.dart';
import 'package:tier_list/Constants/list.dart';
import 'package:tier_list/Widgets/selection_card.dart';
import 'package:tier_list/Widgets/tier_list.dart';

void main(List<String> args) {
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textController = TextEditingController();
  final ImageSearch imageSearch = ImageSearch();
  List<Image> searchResults = [];
  bool theme = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.fallback(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tier List Maker"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          enabled: false,
                          child:
                              StatefulBuilder(builder: (context, changeState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(theme ? "Dark Mode" : "Light Mode"),
                                const VerticalDivider(width: 10,),
                                Switch(inactiveThumbColor: Colors.amber[900],
                                    thumbIcon:
                                        MaterialStateProperty.resolveWith(
                                            (_) => theme
                                                ? Icon(Icons.dark_mode)
                                                : Icon(Icons.light_mode)),
                                    value: theme,
                                    onChanged: (val) {
                                      changeState(() {
                                        setState(() {
                                          theme = val;
                                        });
                                      });
                                    })
                              ],
                            );
                          })),
                          PopupMenuItem(child: Text("Settings"),onTap: (){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming soon..."),));
                          },)
                    ]),
            /* IconButton(onPressed: (){
              setState(() {
                theme = !theme;
              });
            }, icon: Icon(theme?Icons.dark_mode:Icons.light_mode))*/
          ],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(7),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(width: 3, color: Colors.grey)),
                          child: TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type something here for search"),
                            controller: textController,
                            onSubmitted: (value) async {
                              searchResults =
                                  await imageSearch.fetchSearchResults(value);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            searchResults = await imageSearch
                                .fetchSearchResults(textController.text);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.search,
                          ))
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: searchResults.isEmpty
                        ? const Center(
                            child: Text("Your search Box is Empty"),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: searchResults.length,
                            itemBuilder: (context, item) {
                              return GestureDetector(
                                  onTap: () async {
                                    await selectionCard(
                                        context, searchResults[item]);
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    margin: const EdgeInsets.all(10),
                                    child: searchResults[item],
                                  ));
                            }),
                  )
                ],
              ),
            ),
            VerticalDivider(
              thickness: 3,
              color: Colors.grey.withOpacity(0.15),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TierList(text: 'S', imageList: sTierList),
                  TierList(text: 'A', imageList: aTierList),
                  TierList(text: 'B', imageList: bTierList),
                  TierList(text: 'C', imageList: cTierList),
                  TierList(text: 'D', imageList: dTierList),
                  TierList(text: 'E', imageList: eTierList),
                  TierList(text: 'F', imageList: fTierList)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
