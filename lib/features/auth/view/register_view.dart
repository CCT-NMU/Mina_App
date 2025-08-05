import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/user.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/day_entry_repository.dart';
import 'package:mina_app/data/repositories/user_repository.dart';
import 'package:mina_app/features/auth/bloc/auth_bloc.dart';
import 'package:mina_app/features/auth/view/login_view.dart';
import 'package:mina_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:mina_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mina_app/features/onboarding/view/name_capture.dart';
import 'package:mina_app/features/period_picker/bloc/period_day_picker_bloc.dart';
import 'package:mina_app/features/period_picker/period_day_picker_view.dart';
import 'package:mina_app/features/widgets/common/adaptive_form_fields.dart';
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
          AuthSignUpRequested(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthAuthenticated) {
          // Only now is the user guaranteed to be authenticated
          final currentUser = SupabaseAuthService().currentUser;
          if (currentUser != null) {
            await Provider.of<UserRepository>(context, listen: false)
                .insertUser(
              User(
                id: currentUser.id,
                name: _nameController.text.trim(),
                email: _emailController.text.trim(),
              ),
            );
            final db = Provider.of<AppDatabase>(context, listen: false);
            final allUsers = db.select(db.appUsers).get();

            allUsers.then((users) {
              print("All users are: $users");
            }).catchError((error) {
              print("Error fetching users: $error");
            });
          }
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DashboardBloc>(
                    create: (context) => DashboardBloc(
                          userRepository: Provider.of<UserRepository>(context,
                              listen: false),
                          cycleRepository: Provider.of<CycleRepository>(context,
                              listen: false),
                          dayEntryRepository: Provider.of<DayEntryRepository>(
                              context,
                              listen: false),
                          dbHelper:
                              Provider.of<AppDatabase>(context, listen: false),
                        )),
                BlocProvider(
                    create: (context) =>
                        OnboardingBloc()..add(OnboardingNameSubmitted())),
                BlocProvider(
                    create: (context) => PeriodDayPickerBloc(
                        Provider.of<DayEntryRepository>(context, listen: false))
                      ..add(PeriodDayPickerUptake(
                          DateTime.now(), currentUser?.id ?? ''))),
              ],
              child: PeriodDayPickerView(focusedDay: DateTime.now()),
            ),
          ));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration successful! You are now logged in.'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(55, 227, 183, 235),
                Color.fromARGB(55, 233, 30, 98)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Logo or App Name
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(178, 132, 77, 151),
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'web/icons/Icon-512.png', // Path relative to web/
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(178, 132, 77, 151),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Join Mina to start tracking your cycle',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Name Field
                  AdaptiveTextFormField(
                    controller: _nameController,
                    labelText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.trim().length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  AdaptiveTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  AdaptiveTextFormField(
                    controller: _passwordController,
                    labelText: "Password",
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  // Confirm Password Field
                  AdaptiveTextFormField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    obscureText: _obscureConfirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return AdaptiveElevatedButton(
                      onPressed: state is AuthLoading ? null : _handleRegister,
                      child: state is AuthLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  }),

                  const SizedBox(height: 16),

                  // Back to Login Link
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AuthBloc(),
                          child: LoginView(),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Already have an account? Sign In',
                      style: TextStyle(
                        color: Color.fromARGB(178, 132, 77, 151),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
