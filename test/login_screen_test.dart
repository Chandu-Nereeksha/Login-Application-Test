import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_example/login_screen.dart';

void main() {
  
  testWidgets('Should have a title', (WidgetTester tester) async {

    //Arrange - Load a widget inside a test file
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    //Act
    Finder title = find.byKey(const ValueKey('title'));

    //Asset
    expect(title, findsNothing);
  });

  testWidgets("Should have one text field form to collect user email id",
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder userNameTextField = find.byKey(const ValueKey("email_id"));

    // Assert
    expect(userNameTextField, findsOneWidget);
  });

  testWidgets("Should have one text field form to collect password",
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder passwordTextField = find.byKey(const ValueKey("password"));

    // Assert
    expect(passwordTextField, findsOneWidget);
  });

  testWidgets("Should have one login button",
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder loginButton = find.byType(ElevatedButton);

    // Assert
    expect(loginButton, findsOneWidget);
  });

  testWidgets("Should show required fields error message if user email id and pwd is empty",
   (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    //ACT
    Finder loginButton = find.byType(ElevatedButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    Finder errorTexts = find.text("Required Field");

    //ASSERT 
    expect(errorTexts, findsNWidgets(2));
  });

  testWidgets("Should show error message when an invalid email is entered",
   (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    //ACT
    Finder userNameTextField = find.byKey(const ValueKey("email_id"));
    Finder loginButton = find.byType(ElevatedButton);

    await tester.enterText(userNameTextField, "ggfsggheh");
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    Finder errorTexts = find.text("Please enter a valid email id");

    //ASSERT 
    expect(errorTexts, findsOneWidget);
  });

  testWidgets("Should show error message when an invalid password is entered",
   (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    //ACT
    Finder passwordTextField = find.byKey(const ValueKey("password"));
    Finder loginButton = find.byType(ElevatedButton);

    await tester.enterText(passwordTextField, "ujjj");
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    Finder errorTexts = find.text("Please enter atleast 8 charater for password");

    //ASSERT 
    expect(errorTexts, findsOneWidget);
  });

  //Test for successful login
  testWidgets("Should submit form when user email id and password is valid", 
   (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    //ACT
    Finder userNameTextField = find.byKey(const ValueKey("email_id"));
    Finder passwordTextField = find.byKey(const ValueKey("password"));
    Finder loginButton = find.byType(ElevatedButton);

    await tester.enterText(userNameTextField, "richa@gmail.com");
    await tester.enterText(passwordTextField, "password");
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    Finder errorTexts = find.text("Required Field");

    expect(errorTexts, findsNothing);
   });
}