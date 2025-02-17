import 'dart:io';

class Account {
  int accountNumber;
  String ownerName;
  double balance;

  Account({
    required this.accountNumber,
    required this.ownerName,
    required this.balance,
  });

  void displayBalance(String currencyType) {
    if (currencyType == 'U') {
      print("Current Balance: \$${balance.toStringAsFixed(2)} USD");
    } else if (currencyType == 'E') {
      print("Current Balance: €${(balance * 0.92).toStringAsFixed(2)} EUR");
    } else {
      print("Invalid currency type.");
    }
  }
}

abstract class Transaction {
  int transactionId;

  Transaction({required this.transactionId});

  double execute(Account account);
}

class Deposit extends Transaction implements Rollback {
  double amount;

  Deposit({required this.amount, required super.transactionId});

  @override
  double execute(Account account) {
    account.balance += amount;
    return account.balance;
  }

  @override
  double cancelTransaction(Account account) {
    account.balance -= amount;
    return account.balance;
  }
}

class Withdraw extends Transaction implements Rollback {
  double amount;

  Withdraw({required this.amount, required super.transactionId});

  @override
  double execute(Account account) {
    if (amount > account.balance) {
      print("Insufficient balance!");
      return account.balance;
    }
    account.balance -= amount;
    return account.balance;
  }

  @override
  double cancelTransaction(Account account) {
    account.balance += amount;
    return account.balance;
  }
}

class BalanceInquiry extends Transaction {
  String currencyType;

  BalanceInquiry({required this.currencyType, required super.transactionId});

  @override
  double execute(Account account) {
    account.displayBalance(currencyType);
    return account.balance;
  }
}

abstract class Rollback {
  double cancelTransaction(Account account);
}

void main() {
  Account? account;
  List<Rollback> transactionHistory = [];

  while (true) {
    print("\n=== Banking System Menu ===");
    print("1. Enter Account Details");
    print("2. Deposit");
    print("3. Withdraw");
    print("4. Show Current Balance");
    print("5. Cancel Last Transaction");
    print("6. Exit");
    stdout.write("Enter your choice: ");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Enter Account Number: ");
        int accNumber = int.parse(stdin.readLineSync()!);
        stdout.write("Enter Owner Name: ");
        String owner = stdin.readLineSync() ?? '';
        stdout.write("Enter Initial Balance: ");
        double balance = double.parse(stdin.readLineSync()!);
        account = Account(
          accountNumber: accNumber,
          ownerName: owner,
          balance: balance,
        );
        print("Account Created Successfully!");
        break;

      case '2':
        if (account == null) {
          print("No account found! Please enter account details first.");
          break;
        }
        stdout.write("Enter deposit amount: ");
        double amount = double.parse(stdin.readLineSync()!);
        Deposit deposit = Deposit(
          amount: amount,
          transactionId: DateTime.now().millisecondsSinceEpoch,
        );
        deposit.execute(account);
        transactionHistory.add(deposit);
        print(
          "Deposited \$${amount.toStringAsFixed(2)} USD. New Balance: \$${account.balance.toStringAsFixed(2)}",
        );
        break;

      case '3':
        if (account == null) {
          print("No account found! Please enter account details first.");
          break;
        }
        stdout.write("Enter withdrawal amount: ");
        double amount = double.parse(stdin.readLineSync()!);
        Withdraw withdraw = Withdraw(
          amount: amount,
          transactionId: DateTime.now().millisecondsSinceEpoch,
        );
        withdraw.execute(account);
        transactionHistory.add(withdraw);
        print(
          "Withdrawn \$${amount.toStringAsFixed(2)} USD. New Balance: \$${account.balance.toStringAsFixed(2)}",
        );
        break;

      case '4':
        if (account == null) {
          print("No account found! Please enter account details first.");
          break;
        }
        stdout.write("Enter currency type (U for USD, E for EUR): ");
        String currencyType = stdin.readLineSync()!;
        BalanceInquiry inquiry = BalanceInquiry(
          currencyType: currencyType,
          transactionId: DateTime.now().millisecondsSinceEpoch,
        );
        inquiry.execute(account);
        break;

      case '5':
        if (account == null || transactionHistory.isEmpty) {
          print("No transaction to cancel!");
          break;
        }
        Rollback lastTransaction = transactionHistory.removeLast();
        lastTransaction.cancelTransaction(account);
        print(
          "Last transaction canceled. New Balance: \$${account.balance.toStringAsFixed(2)}",
        );
        break;

      case '6':
        print("Exiting the Banking System. Thank you!");
        return;

      default:
        print("Invalid choice! Please enter a number between 1-6.");
    }
  }
}
