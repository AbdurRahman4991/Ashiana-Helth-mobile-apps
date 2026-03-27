
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../provider/CategoryListProvider.dart';
// import '../../provider/manufacturer_provider.dart';
// import '../../features/home/screen/filterPage.dart';

// class FilterSheet extends StatefulWidget {
//   const FilterSheet({super.key});

//   @override
//   State<FilterSheet> createState() => _FilterSheetState();
// }

// class _FilterSheetState extends State<FilterSheet> {
//   bool isCategory = true;

//   List<bool> selectedCategory = [];
//   List<bool> selectedCompany = [];

//   String searchText = "";

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<CategoryListProvider>(context, listen: false).loadCategories();
//       Provider.of<ManufacturingProvider>(context, listen: false).loadCompanies();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final categoryProvider = Provider.of<CategoryListProvider>(context);
//     // final companyProvider = Provider.of<ManufacturingProvider>(context);

//     // final categories =
//     //     categoryProvider.categories.map((e) => e.name ?? "").toList();
//     // final companies = companyProvider.companies.map((e) => e.name).toList();

//     // if (selectedCategory.length != categories.length) {
//     //   selectedCategory = List.generate(categories.length, (_) => false);
//     // }
//     // if (selectedCompany.length != companies.length) {
//     //   selectedCompany = List.generate(companies.length, (_) => false);
//     // }

//     // final dataList = isCategory ? categories : companies;
//     // final selectedList = isCategory ? selectedCategory : selectedCompany;

//     // final filteredList = searchText.isEmpty
//     //     ? dataList
//     //     : dataList
//     //         .where((e) => e.toLowerCase().contains(searchText.toLowerCase()))
//     //         .toList();

//     // final isLoading = isCategory ? categoryProvider.isLoading : companyProvider.isLoading;
//     // category IDs
// final categoryProvider =
//     Provider.of<CategoryListProvider>(context, listen: false);

// final companyProvider =
//     Provider.of<ManufacturingProvider>(context, listen: false);

// List<int> selectedCategoryIds = [];
// List<int> selectedCompanyIds = [];

// for (int i = 0; i < categoryProvider.categories.length; i++) {
//   if (selectedCategory[i]) {
//     selectedCategoryIds.add(categoryProvider.categories[i].id ?? 0);
//   }
// }

// for (int i = 0; i < companyProvider.companies.length; i++) {
//   if (selectedCompany[i]) {
//     selectedCompanyIds.add(companyProvider.companies[i].id);
//   }
// }

//     return Container(
//       padding: const EdgeInsets.all(16),
//       height: MediaQuery.of(context).size.height * 0.75,
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 const Text(
//                   "Filter By",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),

//                 /// Toggle
//                 Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => setState(() => isCategory = false),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           decoration: BoxDecoration(
//                             color: !isCategory ? Colors.blue : Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Company",
//                               style: TextStyle(
//                                 color: !isCategory ? Colors.white : Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => setState(() => isCategory = true),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           decoration: BoxDecoration(
//                             color: isCategory ? Colors.blue : Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Category",
//                               style: TextStyle(
//                                 color: isCategory ? Colors.white : Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),

//                 /// Search
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Search ${isCategory ? "Category" : "Company"}",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onChanged: (value) => setState(() => searchText = value),
//                 ),
//                 const SizedBox(height: 16),

//                 /// List
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredList.length,
//                     itemBuilder: (context, index) {
//                       final actualIndex = dataList.indexOf(filteredList[index]);
//                       return CheckboxListTile(
//                         value: selectedList[actualIndex],
//                         title: Text(filteredList[index]),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedList[actualIndex] = value ?? false;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),

//                 /// Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedCategory =
//                                 List.generate(categories.length, (_) => false);
//                             selectedCompany =
//                                 List.generate(companies.length, (_) => false);
//                           });
//                         },
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: Colors.red,
//                           side: const BorderSide(color: Colors.red),
//                         ),
//                         child: const Text("Reset"),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           final selectedItems = isCategory
//                               ? List.generate(
//                                   categories.length,
//                                   (i) => selectedCategory[i] ? categories[i] : null,
//                                 ).whereType<String>().toList()
//                               : List.generate(
//                                   companies.length,
//                                   (i) => selectedCompany[i] ? companies[i] : null,
//                                 ).whereType<String>().toList();

//                          // Navigator.pop(context, selectedItems);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => FilterPage(
//                                 categoryIds: selectedCategoryIds,
//                                 companyIds: selectedCompanyIds,
//                                 searchText: searchText,
//                               ),
//                             ),
//                           );
//                                                   },
//                         style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                        child: const Text(
//                           "Apply",
//                           style: TextStyle(color: Colors.white),
//                           ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/CategoryListProvider.dart';
import '../../provider/manufacturer_provider.dart';
import '../../features/home/screen/filterPage.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool isCategory = true;

  List<bool> selectedCategory = [];
  List<bool> selectedCompany = [];

  String searchText = "";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CategoryListProvider>(context, listen: false)
          .loadCategories();
      Provider.of<ManufacturingProvider>(context, listen: false)
          .loadCompanies();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// ✅ MUST listen true
    final categoryProvider = Provider.of<CategoryListProvider>(context);
    final companyProvider = Provider.of<ManufacturingProvider>(context);

    final categories = categoryProvider.categories;
    final companies = companyProvider.companies;

    /// ✅ Sync selection list
    if (selectedCategory.length != categories.length) {
      selectedCategory = List.generate(categories.length, (_) => false);
    }

    if (selectedCompany.length != companies.length) {
      selectedCompany = List.generate(companies.length, (_) => false);
    }

    /// ✅ show list
    final dataList =
        isCategory ? categories.map((e) => e.name ?? "").toList()
                   : companies.map((e) => e.name).toList();

    final selectedList = isCategory ? selectedCategory : selectedCompany;

    /// ✅ search filter
    final filteredList = searchText.isEmpty
        ? dataList
        : dataList
            .where((e) =>
                e.toLowerCase().contains(searchText.toLowerCase()))
            .toList();

    /// ✅ loading
    final isLoading =
        isCategory ? categoryProvider.isLoading : companyProvider.isLoading;

    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.75,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const Text(
                  "Filter By",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                /// 🔘 Toggle
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isCategory = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isCategory
                                ? Colors.blue
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Company",
                              style: TextStyle(
                                color: !isCategory
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isCategory = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isCategory
                                ? Colors.blue
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Category",
                              style: TextStyle(
                                color: isCategory
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// 🔍 Search
                TextField(
                  decoration: InputDecoration(
                    hintText:
                        "Search ${isCategory ? "Category" : "Company"}",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) =>
                      setState(() => searchText = value),
                ),

                const SizedBox(height: 16),

                /// 📋 List
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final actualIndex =
                          dataList.indexOf(filteredList[index]);

                      return CheckboxListTile(
                        value: selectedList[actualIndex],
                        title: Text(filteredList[index]),
                        onChanged: (value) {
                          setState(() {
                            selectedList[actualIndex] = value ?? false;
                          });
                        },
                      );
                    },
                  ),
                ),

                /// 🔘 Buttons
                Row(
                  children: [
                    /// Reset
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory =
                                List.generate(categories.length, (_) => false);
                            selectedCompany =
                                List.generate(companies.length, (_) => false);
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text("Reset"),
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// Apply
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          /// ✅ Collect IDs HERE (correct place)
                          List<int> selectedCategoryIds = [];
                          List<int> selectedCompanyIds = [];

                          for (int i = 0; i < categories.length; i++) {
                            if (selectedCategory[i]) {
                              selectedCategoryIds
                                  .add(categories[i].id ?? 0);
                            }
                          }

                          for (int i = 0; i < companies.length; i++) {
                            if (selectedCompany[i]) {
                              selectedCompanyIds.add(companies[i].id);
                            }
                          }

                          /// 🔥 Navigate
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FilterPage(
                                categoryIds: selectedCategoryIds,
                                companyIds: selectedCompanyIds,
                                searchText: searchText,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text(
                          "Apply",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}