// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TabModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Startup Name Generator'),
            ),
            body: const TabComponent()));
  }
}

class TabModel extends ChangeNotifier {
  var arr = [0, 0, 0, 0, 0];

  void handleIndexSelect(int index, int day) {
    arr[day] = index;
    notifyListeners();
  }
}

class TabComponent extends StatelessWidget {
  const TabComponent({super.key});

  Widget tabItem(String title, int index, int currentIndex,
      VoidCallback handleIndexSelect) {
    if (currentIndex == index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
          decoration: const BoxDecoration(
              // color: Colors.green,
              gradient:
                  LinearGradient(colors: [Colors.green, Colors.lightGreen])),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              handleIndexSelect();
            },
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      onPressed: () {
        handleIndexSelect();
      },
      child: Text(title),
    );
  }

  Widget tabContent(String title) {
    return Column(
      children: [
        Stack(
          alignment: const Alignment(0.6, 1),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'images/bread.jpeg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 100,
              height: 50,
              padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0)),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget tabContents(int currentIndex) {
    if (currentIndex == 0) return tabContent('Bánh mỳ đen');
    if (currentIndex == 1) return tabContent('Bánh mỳ trắng');
    return tabContent('Bánh mỳ cam');
  }

  Widget cardItem(cart, day) {
    return Container(
      width: 210.0,
      height: 300,
      // decoration: new BoxDecoration(
      //   boxShadow: [
      //     new BoxShadow(
      //       color: Colors.black,
      //       blurRadius: 20.0,
      //     ),
      //   ],
      // ),
      margin: const EdgeInsets.fromLTRB(10, 25, 10, 5),
      child: Card(
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Thứ ${day + 2}',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                // const Divider(),
                // const Tab(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tabItem('Bữa sáng', 0, cart.arr[day],
                        () => cart.handleIndexSelect(0, day)),
                    SizedBox(
                      width: 10,
                    ),
                    tabItem('Bữa trưa', 1, cart.arr[day],
                        () => cart.handleIndexSelect(1, day)),
                    SizedBox(
                      width: 10,
                    ),
                    tabItem('Bữa tối', 2, cart.arr[day],
                        () => cart.handleIndexSelect(2, day)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                tabContents(cart.arr[day]),
                SizedBox(
                  height: 20,
                ),
                // const TabBarDemo(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        debugPrint('Received click');
                      },
                      child: const Text('Xoá'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        debugPrint('Received click');
                      },
                      child: const Text('Chỉnh sửa'),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabModel>(
      builder: (context, cart, child) {
        return Center(
          child: Container(
              width: 320,
              alignment: Alignment.center,
              child: ListView(
                children: <Widget>[
                  cardItem(cart, 0),
                  cardItem(cart, 1),
                  cardItem(cart, 2),
                  cardItem(cart, 3),
                  cardItem(cart, 4),
                ],
              )),
        );
      },
      child: const Text('BUY'),
    );
  }
}


// class AccordionPage extends StatelessWidget 
// {
//   const AccordionPage({Key? key}) : super(key: key);

//   final _headerStyle = const TextStyle(
//       color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
//   final _contentStyleHeader = const TextStyle(
//       color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
//   final _contentStyle = const TextStyle(
//       color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
//   final _loremIpsum =
//       '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';
  
//   final breakfast = const AccordionSection(
//     isOpen: false,
//     leftIcon:
//         const Icon(Icons.insights_rounded, color: Colors.white),
//     headerBackgroundColor: Colors.black38,
//     headerBackgroundColorOpened: Colors.black54,
//     header: Text('Bữa sáng', style: _headerStyle),
//     content: Text(_loremIpsum, style: _contentStyle),
//     contentHorizontalPadding: 20,
//     contentBorderColor: Colors.black54,
//   );

//   @override
//   build(context) => Scaffold(
//         backgroundColor: Colors.blueGrey[100],
//         body: Accordion(
//           maxOpenSections: 2,
//           headerBackgroundColorOpened: Colors.black54,
//           scaleWhenAnimating: true,
//           openAndCloseAnimation: true,
//           headerPadding:
//               const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//           sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//           sectionClosingHapticFeedback: SectionHapticFeedback.light,
//           children: [
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
//               headerBackgroundColor: Colors.black,
//               headerBackgroundColorOpened: Colors.red,
//               header: Text('Thứ 2', style: _headerStyle),
//               content: Text(_loremIpsum, style: _contentStyle),
//               contentHorizontalPadding: 20,
//               contentBorderWidth: 1,
//               // onOpenSection: () => print('onOpenSection ...'),
//               // onCloseSection: () => print('onCloseSection ...'),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//               header: Text('Thứ 3', style: _headerStyle),
//               contentBorderColor: const Color(0xffffffff),
//               headerBackgroundColorOpened: Colors.amber,
//               content: Accordion(
//                 maxOpenSections: 1,
//                 headerBackgroundColorOpened: Colors.black54,
//                 headerPadding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//                 children: [
//                   breakfast,
//                   AccordionSection(
//                     isOpen: false,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     header: Text('Bữa trưa', style: _headerStyle),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     contentBorderColor: Colors.black54,
//                     content: Row(
//                       children: [
//                         const Icon(Icons.compare_rounded,
//                             size: 120, color: Colors.orangeAccent),
//                         Flexible(
//                             flex: 1,
//                             child: Text(_loremIpsum, style: _contentStyle)),
//                       ],
//                     ),
//                   ),
//                   AccordionSection(
//                     isOpen: false,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     header: Text('Bữa tối', style: _headerStyle),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     contentBorderColor: Colors.black54,
//                     content: Row(
//                       children: [
//                         const Icon(Icons.compare_rounded,
//                             size: 120, color: Colors.orangeAccent),
//                         Flexible(
//                             flex: 1,
//                             child: Text(_loremIpsum, style: _contentStyle)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.food_bank, color: Colors.white),
//               header: Text('Thứ 4', style: _headerStyle),
//               content: DataTable(
//                 sortAscending: true,
//                 sortColumnIndex: 1,
//                 dataRowHeight: 40,
//                 showBottomBorder: false,
//                 columns: [
//                   DataColumn(
//                       label: Text('ID', style: _contentStyleHeader),
//                       numeric: true),
//                   DataColumn(
//                       label: Text('Description', style: _contentStyleHeader)),
//                   DataColumn(
//                       label: Text('Price', style: _contentStyleHeader),
//                       numeric: true),
//                 ],
//                 rows: [
//                   DataRow(
//                     cells: [
//                       DataCell(Text('1',
//                           style: _contentStyle, textAlign: TextAlign.right)),
//                       DataCell(Text('Fancy Product', style: _contentStyle)),
//                       DataCell(Text(r'$ 199.99',
//                           style: _contentStyle, textAlign: TextAlign.right))
//                     ],
//                   ),
//                   DataRow(
//                     cells: [
//                       DataCell(Text('2',
//                           style: _contentStyle, textAlign: TextAlign.right)),
//                       DataCell(Text('Another Product', style: _contentStyle)),
//                       DataCell(Text(r'$ 79.00',
//                           style: _contentStyle, textAlign: TextAlign.right))
//                     ],
//                   ),
//                   DataRow(
//                     cells: [
//                       DataCell(Text('3',
//                           style: _contentStyle, textAlign: TextAlign.right)),
//                       DataCell(Text('Really Cool Stuff', style: _contentStyle)),
//                       DataCell(Text(r'$ 9.99',
//                           style: _contentStyle, textAlign: TextAlign.right))
//                     ],
//                   ),
//                   DataRow(
//                     cells: [
//                       DataCell(Text('4',
//                           style: _contentStyle, textAlign: TextAlign.right)),
//                       DataCell(
//                           Text('Last Product goes here', style: _contentStyle)),
//                       DataCell(Text(r'$ 19.99',
//                           style: _contentStyle, textAlign: TextAlign.right))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.contact_page, color: Colors.white),
//               header: Text('Thứ 5', style: _headerStyle),
//               content: Wrap(
//                 children: List.generate(
//                     30,
//                     (index) => const Icon(Icons.contact_page,
//                         size: 30, color: Color(0xff999999))),
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.computer, color: Colors.white),
//               header: Text('Thứ 6', style: _headerStyle),
//               content: const Icon(Icons.computer,
//                   size: 200, color: Color(0xff999999)),
//             ),
//           ],
//         ),
//       );
// } //__
