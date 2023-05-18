import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:login_example/login_screen.dart';

void main() {
  group('Login Flow Test', () { 
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    //Login flow - Error Case when nothing has been entered
    testWidgets('Should show required field error message when user taps on login button without entering email id and password',
     (WidgetTester tester) async {
      // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    //ACT
    Finder loginButton = find.byType(ElevatedButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    //It will not navigate to home screen
    Finder errorText = find.text("Required Field");

    //ASSERT
    expect(errorText, findsNWidgets(2));
     });

    //Login flow - Sucess Case with valid email and password
    testWidgets('Should show home screen when user taps on login button after entering valid email id and password',
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

    //It will navigate to home screen after clicking on login button
    Finder welcomeText = find.byType(Text);

    //ASSERT
    expect(welcomeText, findsOneWidget);
     });
  });
}