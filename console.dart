import 'dart:io';
import 'dart:math';

//enumeration for the type of transaction
enum TransactionType { income, expense }
//****************************************************************************
// the user class
class User {
  int _userId;
  String username;
  String email;
  String currency;
//constructor
  User(this._userId, this.username, this.email, this.currency);
//get function for user id
  int get userId => _userId;
//function to display user
  void displayUser() {
    print("User ID: $_userId, Name: $username, Email: $email, Currency: $currency");
  }
}
//****************************************************************************
// Transaction Class
class Transaction {
  int _transactionId;
  int userID;
  double amount;
  String category;
  TransactionType type;
  DateTime date;
  String? notes;
//constructor
  Transaction(this._transactionId, this.userID, this.amount, this.category,
      this.type, this.date,
      {this.notes});
//get function for transaction id
  int get transactionId => _transactionId;
//function to display transaction
  void displayTransaction() {
    print(
        "ID: $_transactionId, User: $userID, Amount: $amount, Category: $category, Type: ${type.name}, Date: ${date.toLocal()}, Notes: ${notes ?? 'N/A'}");
  }
}
//****************************************************************************
//Budget class
class Budget {
  int _budgetId;
  int userID;
  String category;
  double amount;
  DateTime start_Date;
  DateTime end_Date;
//constructor
  Budget(this._budgetId, this.userID, this.category, this.amount, this.start_Date,
      this.end_Date);
//get function for budget id
  int get budgetId => _budgetId;
//function to display budget
  void displayBudget() {
    print(
        "Budget ID: $_budgetId, User: $userID, Category: $category, Amount: $amount, Start: ${start_Date.toLocal()}, End: ${end_Date.toLocal()}");
  }
}
//****************************************************************************
//****************************************************************************
//global lists we will used to store data, list for user, list for transaction and list for budget
List<User> users_list = [];
List<Transaction> transactions_list = [];
List<Budget> budgets_list = [];

// to generate unique ID
int generateId() => Random().nextInt(10000);

// to find user by ID
User? findUserById(int userId) {
  return users_list.firstWhere(
          (u) => u.userId == userId,
      orElse: () => User(0, 'Not Found', '', '')
  );
}

// to find transaction by ID
Transaction? findTransactionById(int transactionId) {
  return transactions_list.firstWhere(
          (t) => t.transactionId == transactionId,
      orElse: () => Transaction(0, 0, 0.0, '', TransactionType.expense, DateTime.now())
  );
}

//****************************************************************************
//****************************************************************************

// function to add a new user
void addUser() {
  stdout.write("Enter name: ");
  String name = stdin.readLineSync() ?? ""; //read name of the user

  stdout.write("Enter email: ");
  String email = stdin.readLineSync() ?? ""; //read email

  stdout.write("Enter currency: ");
  String currency = stdin.readLineSync() ?? ""; //read currency

  int id = generateId(); // generate id
  users_list.add(User(id, name, email, currency)); //add user to the list

  print("User added successfully with ID: $id");
}
//------------------------------------------------------------------------
// function to display every user in the users_list
void displayUsers() {
  if (users_list.isEmpty) { //if users_list is empty
    print("No users found.");
    return;
  }
  users_list.forEach((user) => user.displayUser()); //display users
}
//------------------------------------------------------------------------
// function to add a new transaction
void addTransaction() {
  stdout.write("Enter User ID: ");
  int userId = int.tryParse(stdin.readLineSync() ?? "") ?? -1; //read user id
  User? user = findUserById(userId); //search for user from id

  if (user == null) {
    print("Error: User ID not found.");
    return;
  }

  stdout.write("Enter amount: ");
  double amount = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

  stdout.write("Enter category: ");
  String category = stdin.readLineSync() ?? "";

  stdout.write("Enter type (income/expense): ");
  String typeInput = stdin.readLineSync()?.toLowerCase() ?? "";
  TransactionType? type = typeInput == "income" //check if is income type
      ? TransactionType.income
      : typeInput == "expense" //check if is expense type
      ? TransactionType.expense
      : null;

  if (type == null) {
    print("Error: Invalid transaction type.");
    return;
  }

  stdout.write("Enter date (YYYY-MM-DD): "); //
  DateTime date;
  try {
    date = DateTime.parse(stdin.readLineSync() ?? ""); //date
  } catch (e) {
    print("Error: Invalid date format.");
    return;
  }

  stdout.write("Enter optional notes: ");
  String? notes = stdin.readLineSync(); //read note

  int id = generateId(); //generate id
  //add transaction to transaction list
  transactions_list.add(Transaction(id, userId, amount, category, type, date, notes: notes));

  print("Transaction added successfully with ID: $id");
}
//------------------------------------------------------------------------
// function to display all transactions in transactions_list
void displayTransactions() {
  if (transactions_list.isEmpty) {
    print("No transactions found.");
    return;
  }
  transactions_list.forEach((t) => t.displayTransaction()); //display transaction
}
//------------------------------------------------------------------------
// function to add a new budget
void addBudget() {
  stdout.write("Enter User ID: ");
  int userId = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
  User? user = findUserById(userId); //check user id

  if (user == null) {
    print("Error: User ID not found.");
    return;
  }

  stdout.write("Enter category: ");
  String category = stdin.readLineSync() ?? "";

  stdout.write("Enter budget amount: ");
  double amount = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

  stdout.write("Enter start date (YYYY-MM-DD): ");
  DateTime startDate;
  try {
    startDate = DateTime.parse(stdin.readLineSync() ?? "");
  } catch (e) {
    print("Error: Invalid date format.");
    return;
  }

  stdout.write("Enter end date (YYYY-MM-DD): ");
  DateTime endDate;
  try {
    endDate = DateTime.parse(stdin.readLineSync() ?? "");
  } catch (e) {
    print("Error: Invalid date format.");
    return;
  }

  int id = generateId(); //generate id
  budgets_list.add(Budget(id, userId, category, amount, startDate, endDate));

  print("Budget added successfully with ID: $id");
}
//------------------------------------------------------------------------
// function to display all budgets in budgets_list
void displayBudgets() {
  if (budgets_list.isEmpty) {
    print("No budgets found.");
    return;
  }
  budgets_list.forEach((b) => b.displayBudget());  //display budgets
}
//------------------------------------------------------------------------
// function to delete transaction
void deleteTransaction() {
  if (transactions_list.isEmpty) { //check if transaction list is empty
    print("No transactions available to delete.");
    return;
  }

  stdout.write("Enter Transaction ID to delete: ");
  int id = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
  Transaction? transaction = findTransactionById(id); //find transaction

  if (transaction == null) {
    print("Error: Transaction ID not found.");
    return;
  }

  transactions_list.remove(transaction); //remove from the transaction list
  print("Transaction deleted successfully.");
}
//------------------------------------------------------------------------
//function to update transaction
void updateTransaction() {
  stdout.write("Enter Transaction ID to update: ");
  int transId = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  Transaction? t;
  try {
    t = transactions_list.firstWhere((tr) => tr.transactionId == transId);
  } catch (e) {
    print("Transaction not found.");
    return;
  }

  stdout.write("New amount (leave blank to keep '${t.amount}'): ");
  String amtInput = stdin.readLineSync() ?? ""; //read the new amount
  if (amtInput.isNotEmpty) t.amount = double.tryParse(amtInput) ?? t.amount;

  stdout.write("New category (leave blank to keep '${t.category}'): ");
  String cat = stdin.readLineSync() ?? ""; //read new category
  if (cat.isNotEmpty) t.category = cat;

  stdout.write("New type (income/expense, leave blank to keep '${t.type.name}'): ");
  String typeInput = stdin.readLineSync()?.toLowerCase() ?? ""; //read new type
  if (typeInput == 'income' || typeInput == 'expense') {
    t.type = typeInput == 'income' ? TransactionType.income : TransactionType.expense;
  }

  stdout.write("New date (YYYY-MM-DD, leave blank to keep current): ");
  String dateInput = stdin.readLineSync() ?? ""; //read new date
  if (dateInput.isNotEmpty) {
    try {
      t.date = DateTime.parse(dateInput);
    } catch (_) {
      print("Invalid date format.");
    }
  }

  stdout.write("New notes (leave blank to keep existing): ");
  String? notes = stdin.readLineSync();
  if (notes != null && notes.isNotEmpty) t.notes = notes;

  print("Transaction updated successfully.");
}
//------------------------------------------------------------------------
// view all transactions for a specific user
void viewTransactionsByUser() {
  stdout.write("Enter User ID to view transactions: ");
  int userId = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
  User? user = findUserById(userId); //check user id

  if (user == null || user.userId == 0) {
    print("Error: User not found.");
    return;
  }

  var userTransactions =
  transactions_list.where((t) => t.userID == userId).toList();

  if (userTransactions.isEmpty) {
    print("No transactions found for this user.");
    return;
  }

  print("Transactions for ${user.username}:"); //all transaction for that user
  userTransactions.forEach((t) => t.displayTransaction());
}
//------------------------------------------------------------------------
// calculate total income and expenses for a specific user
void calculateUserSummary() {
  stdout.write("Enter User ID to calculate summary: ");
  int userId = int.tryParse(stdin.readLineSync() ?? "") ?? -1;
  User? user = findUserById(userId);

  if (user == null || user.userId == 0) {
    print("Error: User not found.");
    return;
  }

  double income = 0;
  double expenses = 0;

  for (var t in transactions_list.where((t) => t.userID == userId)) {
    if (t.type == TransactionType.income) {
      income += t.amount;
    } else {
      expenses += t.amount;
    }
  }

  print("Financial Summary for ${user.username}:");
  print("Total Income: ${income.toStringAsFixed(2)} ${user.currency}");
  print("Total Expenses: ${expenses.toStringAsFixed(2)} ${user.currency}");
}
//------------------------------------------------------------------------
void filterTransactionsByCategory() {
  stdout.write("Enter category to filter: ");
  String category = stdin.readLineSync()?.toLowerCase() ?? "";

  var filtered = transactions_list.where((t) => t.category.toLowerCase() == category).toList();

  if (filtered.isEmpty) {
    print("No transactions found for category '$category'.");
  } else {
    print("Transactions in category '$category':");
    filtered.forEach((t) => t.displayTransaction());
  }
}
//------------------------------------------------------------------------
void searchUserByName() {
  stdout.write("Enter part of username to search: ");
  String query = stdin.readLineSync()?.toLowerCase() ?? "";

  var found = users_list.where((u) => u.username.toLowerCase().contains(query)).toList();

  if (found.isEmpty) {
    print("No users found with name containing '$query'.");
  } else {
    print("Matching users:");
    found.forEach((u) => u.displayUser());
  }
}


// menu in main function
void main() {
  while (true) {
    print("\n===== Smart Budget Tracker Console App =====");
    print("1- Add User");
    print("2- Display Users");
    print("3- Add Transaction");
    print("4- Display Transactions");
    print("5- Add Budget");
    print("6- Display Budgets");
    print("7- Delete Transaction");
    print("8- Update Transaction");
    print("9- View Transactions by User");
    print("10- Calculate Income & Expenses Summary");
    print("11- Search User by Name");
    print("12- Filter Transactions by Category");
    print("13- Exit");


    stdout.write("Choose an option: ");
    int choice = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    switch (choice) {
      case 1:
        addUser();
        break;
      case 2:
        displayUsers();
        break;
      case 3:
        addTransaction();
        break;
      case 4:
        displayTransactions();
        break;
      case 5:
        addBudget();
        break;
      case 6:
        displayBudgets();
        break;
      case 7:
        deleteTransaction();
        break;
      case 8:
        updateTransaction();
        break;
      case 9:
        viewTransactionsByUser();
        break;
      case 10:
        calculateUserSummary();
        break;
      case 11:
        searchUserByName();
        break;
      case 12:
        filterTransactionsByCategory();
        break;
      case 13:
        print("Exit...");
        exit(0);
      default:
        print("Error: Invalid choice, try again.");
    }
  }
}
