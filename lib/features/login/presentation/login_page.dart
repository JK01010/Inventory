import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:oauth2/oauth2.dart';
import 'package:oauth_webauth/oauth_webauth.dart';
import '../../../config/identity_server/identity_server_configuration.dart';
import '../../../config/identity_server/maersk_identity_dev_configuration.dart';
import '../../../core/constants/api_constant.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/extensions/theme_extension.dart';
import '../../../core/routes/route_name.dart';
import '../../bagging_tagging_confirmtaion/presentation/widgets/login_base_url_widget.dart';
import '../../widgets/app_flat_button.dart';
import '../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../widgets/gradient_background_widget.dart';
import '../data/models/credentials_formatter.dart';
import '../data/models/identity_server_model.dart';
import 'login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginSuccess == false && state.errorMessage.isNotEmpty) {
          showSuccessPopup(state.errorMessage, context);
        }
        if (state.loginSuccess == true) {
          context.pushReplacement(AppRoute.dashboard.path);
        }
      },
      listenWhen: (previous, current) {
        return (previous.loginSuccess != current.loginSuccess);
      },
      builder: (context, state) {
        return GradientBackground(
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.scaffoldPadding * 3,
                    right: AppPadding.padding15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          showLoginBaseUrlPopup(context);
                        },
                        child: SvgPicture.asset(
                          AppIcons.settingsIcon,
                          height: AppSize.size24,
                          width: AppSize.size24,
                        ),
                      ),
                    ],
                  ),
                ),
                //maersk logo
                Padding(
                  padding: const EdgeInsets.all(AppPadding.scaffoldPadding * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LogoWidget(),
                      SizedBox(height: AppSize.size20),
                      _LoginButtonWidget(),
                    ],
                  ),
                ),
                //app Support
                _AppSupportWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppFlatButton(
        text: context.l.login,
        backgroundColor: AppColor.colorPrimary,
        textColor: AppColor.colorWhite,
        onPressed: () async {
          ApiConstant();
          IdentityServerConfiguration identityServerConfig =
              MaerskIdentityServerDevConfig();
          GetStorage storage = GetStorage();
         String? url =  storage.read("vesselURL");
         if(url!=null && url.isNotEmpty){
           final identityServerResponse = await loginWithIdentityServer(
             context: context,
             identityServerConfig: identityServerConfig,
           );

           if (context.mounted) {
             if (identityServerResponse != null) {
               context.read<LoginBloc>().add(
                 IdentityServerLoginVerification(
                   identityServerResponse: identityServerResponse,
                   verificationBaseUrl: identityServerConfig.baseUrl ?? '',
                 ),
               );
             } else {
               showSuccessPopup('Login Failed!', context);
             }
           }
         }else{
           showSuccessPopup('Test URL is not set', context);
         }

        },
      ),
    );
  }

  Future<IdentityServerResponse?> loginWithIdentityServer({
    required BuildContext context,
    required IdentityServerConfiguration identityServerConfig,
  }) async {
    try {
      if (await context.read<LoginBloc>().isNetworkConnected ()) {
        final authConfiguration = OAuthConfiguration(
          authorizationEndpointUrl:
              identityServerConfig.getAuthorizationEndpointUrl(),
          tokenEndpointUrl: identityServerConfig.getTokenEndpointUrl(),
          clientSecret: identityServerConfig.clientSecret,
          clientId: identityServerConfig.clientId ?? '',
          redirectUrl: identityServerConfig.redirectUrl ?? '',
          scopes: identityServerConfig.scopes,

          backButton: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white10,
              shape: const CircleBorder(side: BorderSide(color: Colors.grey)),
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          onCertificateValidate: (certificate) {
            if (certificate.checkValidity()) {
              return true;
            } else {
              return false;
            }
          },
        );
        if (context.mounted) {
          final result = await OAuthWebScreen.start(
            context: context,
            configuration: authConfiguration,
          );
          if (result is Credentials) {
            String authResponse = CredentialsJsonFormatter.format(result);
            return IdentityServerAuthenticationResult(
              message: authResponse,
              credential: result,
            );
          } else {
            return null;
          }
        }
        return null;
      } else {
        if (context.mounted) {
          showSuccessPopup('No Internet Connection!', context);
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class _AppSupportWidget extends StatelessWidget {
  const _AppSupportWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppPadding.padding50,
      left: AppPadding.padding0,
      right: AppPadding.padding0,
      child: Column(
        children: [
          Text(
            context.l.appSupport,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.colorPrimary,
              fontSize: AppFontSize.fontSize14,
              fontFamily: 'Maersk Text',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'V1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.slateGrayishPurpleColor,
              fontSize: AppFontSize.fontSize12,
              fontFamily: 'Maersk Text',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      context.isDarkMode ? AppImage.maerskLogoDark : AppImage.maerskLogoLight,
      fit: BoxFit.contain,
      height: AppSize.size43,
      width: AppSize.size187,
    );
  }
}
