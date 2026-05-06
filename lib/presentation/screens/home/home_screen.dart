// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:path/path.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hi Welcome Back',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),

//                       Text(
//                         'Good Morning',
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),

//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.white,
//                     ),
//                     child: IconButton(onPressed: (){
//                       context.go('/notifications');
//                     }, icon: Icon(Icons.notifications_none,color: Colors.black,),
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildBalanceInfo(context, 'Total Balance','\$7,783.00',Colors.white),
//                   Container(width: 1,height: 40,color: Colors.white,),
//                   _buildBalanceInfo(context, 'Total Expence','-\$1.187.40',const Color(0xFF1B3D3D)),
//                 ],
//               ),
//             ),

//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         height: 12,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),

//                       Container(
//                         height: 12,
//                         width: MediaQuery.of(context).size.width * 0.3,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF1B3D3D),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       )
//                     ],
//                   ),

//                   const SizedBox(height: 8,),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('30%', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                       Text('\$20,000.00',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                     ],
//                   )
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20,),

//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(25),
//                   child: Column(
//                     children: [
//                       //week
//                       _buildWeeklyStatsCard(context),
//                       const SizedBox(height: 20,),

//                       //time a choose (Daily,Weekly,Monthly)
//                       _buildPeriodSelector(),
//                       const SizedBox(height: 20,),

//                       //List transaction
//                       _buildTransactionItem('Salary','Monthly','\$4,000.00',Icons.account_balance_wallet,Colors.blue),
//                       _buildTransactionItem('Groceries', 'Pantry', '-\$100.00', Icons.shopping_bag, Colors.orange),
//                       _buildTransactionItem('Rent', 'Rent', '-\$674.40', Icons.vpn_key, Colors.indigo),
//                     ],
//                   ),
//                 ),
//               ))
//           ],
//         )
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: const Color(0xFF00D19E),
//         unselectedItemColor: Colors.black,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         currentIndex: 0,
//         onTap: (index) {
//           if(index == 0) context.go('/home');
//           if (index == 1) { // Екінші иконка - Analysis
//               context.go('/analysis');
//           }
//           if(index == 2) context.go('/transaction');
//           if(index == 3) context.go('/categories');
//           if(index == 4) context.go('/profile');
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
//           BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Transfer'),
//           BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Cards'),
//           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
//         ]
//       ),
//     );
//   }
  
//   Widget _buildBalanceInfo(BuildContext context, String title,String amount,Color amountColor){
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//              IconButton(onPressed: (){
//               context.go('/accountBalance');
//              }, icon: Icon(Icons.analytics_outlined,size: 14,color: Colors.black,)),
//             const SizedBox(width: 5,),
//             Text(title,style: TextStyle(color: Colors.black),)
//           ],
//         ),
//         Text(
//           amount,
//           style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: amountColor),
//         )
//       ],
//     );
//   }

//   Widget _buildWeeklyStatsCard(BuildContext context) { // context қосуды ұмытпа
//   return GestureDetector(
//     onTap: () {
//       // Осы жерде өзің жасаған 'Quickly Analysis' бетінің бағытын (path) жаз
//       context.push('/quiklyanalytics'); 
//     },
//     child: Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF00D19E),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.white,
//             child: Icon(Icons.directions_car, color: Color(0xFF00D19E)), // Түсін жасыл қылсаң жақсы көрінеді
//           ),
//           const SizedBox(width: 15),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Revenue Last Week', style: TextStyle(color: Colors.black54, fontSize: 12)),
//                 Text('\$4,000.00', style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold, fontSize: 18)),
//                 Divider(color: Colors.white30),
//                 Text('Food Last Week', style: TextStyle(color: Colors.black54, fontSize: 12)),
//                 Text('-\$100.00', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 18)),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

//   Widget _buildTransactionItem(String title,String category,String amount,IconData icon,Color iconBg){
//     return Container(
//       margin: EdgeInsets.only(bottom: 15),
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: iconBg.withOpacity(0.1),
//             child: Icon(icon,color: iconBg,),
//           ),
//           const SizedBox(width: 15,),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
//                 Text(category,style: TextStyle(color: Colors.black,fontSize: 12),),
//               ],
//             )),

//             Text(
//               amount,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: amount.startsWith('-') ? Colors.blueAccent : Colors.black,
//               ),
//             )
//         ],
//       ),
//     );
//   }

//   Widget _buildPeriodSelector() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//          const Text('Daily', style: TextStyle(color: Colors.black)),
//          const Text('Weekly', style: TextStyle(color: Colors.black)),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           decoration: BoxDecoration(
//             color: const Color(0xFF00D19E),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: const Text('Monthly', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         ),
//       ],
//     );
//   }
// }


import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
import 'package:fintrack/presentation/blocs/auth/auth_state.dart';
import 'package:fintrack/presentation/blocs/home/bloc/home_bloc.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// Өз жолыңмен Блокты импортта:
// import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
String selectedPeriod = 'Monthly';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      String userName = "Guest";
                      if (state is Authenticated) {
                        // Firebase-те сақталған displayName болса соны, болмаса email-ды аламыз
                        userName = state.user.name ?? state.user.email!.split('@')[0];
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, $userName',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            'Good Morning',
                            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                          ),
                        ],
                      );
                    },
                  ),
                  // Тек хабарламалар мен профильге өту батырмалары
                  Row(
                    children: [
                      _buildHeaderIcon(context, Icons.notifications_none, '/notifications'),
                      
                    ],
                  ),
                ],
              ),
            ),

            // BALANCE INFO
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final income = state is HomeLoaded ? state.income : 0.0;
                final expense = state is HomeLoaded ? state.expense : 0.0;
                final balance = state is HomeLoaded ? state.balance : 0.0;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBalanceInfo(context, 'Total Balance', '\$${balance.toStringAsFixed(2)}', Colors.white),
                      Container(width: 1, height: 40, color: Colors.white24),
                      _buildBalanceInfo(context, 'Total Expense', '-\$${expense.toStringAsFixed(2)}', const Color(0xFF1B3D3D)),
                    ],
                  ),
                );
              },
            ),

            // PROGRESS BAR
            _buildProgressBar(context),

            const SizedBox(height: 20),

            // WHITE CONTENT AREA
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF141414) : Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      _buildWeeklyStatsCard(context),
                      const SizedBox(height: 20),
                      _buildRecentTransactionsHeader(),
                      const SizedBox(height: 20),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          final recent = state is HomeLoaded
                              ? state.recentTransactions
                              : <TransactionEntity>[];
                          if (recent.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text('No recent transactions'),
                            );
                          }
                          return Column(
                            children: recent
                                .map(
                                  (tx) => _buildTransactionItem(
                                    context,
                                    tx.title,
                                    tx.categoryId,
                                    tx.type == TransactionType.expense ? '-\$${tx.amount.toStringAsFixed(2)}' : '\$${tx.amount.toStringAsFixed(2)}',
                                    tx.type == TransactionType.expense ? Icons.call_received : Icons.arrow_outward,
                                    tx.type == TransactionType.expense ? Colors.orange : Colors.blue,
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // Header белгішелеріне арналған ортақ метод
  Widget _buildHeaderIcon(BuildContext context, IconData icon, String route) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? const Color(0xFF1A1A1A) : Colors.amber,
      ),
      child: IconButton(
        onPressed: () => context.go(route),
        icon: Icon(icon, color: isDark ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    // Ағымдағы жолды анықтау (currentIndex үшін)
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF00D19E),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: 0, // Басты бет белсенді
      onTap: (index) {
        switch (index) {
          case 0: context.go('/home'); break;
          case 1: context.go('/analysis'); break;
          case 2: context.go('/transaction'); break;
          case 3: context.go('/categories'); break;
          case 4: context.go('/profile'); break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Transfer'),
        BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Cards'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }

  // --- Дизайн компоненттері ---
  
  Widget _buildBalanceInfo(BuildContext context, String title, String amount, Color amountColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.analytics_outlined, size: 16, color: isDark ? Colors.white70 : Colors.black54),
            const SizedBox(width: 5),
            Text(title, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
          ],
        ),
        const SizedBox(height: 5),
        Text(amount, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: amountColor)),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 12,
                width: double.infinity,
                decoration: BoxDecoration(color: isDark ? Colors.white24 : Colors.white, borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                height: 12,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('30%', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
              Text('\$20,000.00', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWeeklyStatsCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/quiklyanalytics'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF00D19E),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(Icons.directions_car, color: Color(0xFF00D19E)),
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Revenue Last Week', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  Text('\$4,000.00', style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold, fontSize: 18)),
                  Divider(color: Colors.white30),
                  Text('Food Last Week', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  Text('-\$100.00', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, String title, String category, String amount, IconData icon, Color iconBg) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: iconBg.withOpacity(0.1), child: Icon(icon, color: iconBg)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                Text(category, style: TextStyle(color: isDark ? Colors.white60 : Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: amount.startsWith('-') ? Colors.blueAccent : (isDark ? Colors.white : Colors.black),
            ),
          )
        ],
      ),
    );
  }

  

  Widget _buildRecentTransactionsHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Container(
      width: double.infinity, // Блок бүкіл енді алуы үшін
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF00D19E), // Сенің негізгі жасыл түсің
        borderRadius: BorderRadius.circular(15), // Шеттерін жұмсарту
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D19E).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        'Recent Transactions',
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    ),
  );
}
}

