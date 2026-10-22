import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homex/features/splash/presentation/screens/splash_screen.dart';

import '../../features/auth/account_verified_screen.dart';
import '../../features/auth/auth_kyc/auth_kyc_role_verification_screen.dart';
import '../../features/auth/auth_kyc/auth_link_settlement_bank_screen.dart';
import '../../features/auth/auth_kyc/auth_set_escrow_pin_pcreen.dart';
import '../../features/auth/auth_role_screen.dart';
import '../../features/auth/create_account_identification_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/verify_otp_screen.dart';
import '../../features/dispute_center/dispute-center_details_screen.dart';
import '../../features/dispute_center/dispute_center_page.dart';
import '../../features/dispute_center/dispute_summary_page.dart';
import '../../features/dispute_center/report_problem_page.dart';
import '../../features/dispute_center/submit_evidence_page.dart';
import '../../features/escrow/active_escrow_tracker_screen.dart';
import '../../features/escrow/escrow_page.dart';
import '../../features/escrow/escrow_statement_screen.dart';
import '../../features/escrow/fund_escrow_screen.dart';
import '../../features/escrow/funding_instructions_screen.dart';
import '../../features/home/presentation/screens/explore_properties_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/inspection_confirmed_screen.dart';
import '../../features/home/presentation/screens/make_an_offer-screen.dart';
import '../../features/home/presentation/screens/offer_confirmed_screen.dart';
import '../../features/home/presentation/screens/profile_screen.dart';
import '../../features/home/presentation/screens/property_details.dart';
import '../../features/home/presentation/screens/seller_profile.dart';
import '../../features/notification/notifications_screen.dart';
import '../../features/offer/accept_lock_escrow_screen.dart';
import '../../features/offer/counter_offer_screen.dart';
import '../../features/offer/offer_review_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/request_property/add_property/add_property_location_page.dart';
import '../../features/request_property/add_property/listing_preview_page.dart';
import '../../features/request_property/add_property/photos_video_page.dart';
import '../../features/request_property/add_property/property_details_page.dart';
import '../../features/request_property/add_property/property_type_page.dart';
import '../../features/request_property/add_property/trust_verification_page.dart';
import '../../features/request_property/portfolio_deals_hub_screen.dart';
import '../../features/request_property/request_screen.dart';
import '../../features/restriction/account_restricted_screen.dart';
import '../../features/restriction/appeal_restriction_screen.dart';
import '../../features/restriction/appeal_submitted_screen.dart';
import '../../features/settings/display/display_options_screen.dart';
import '../../features/settings/indentity/identity_kyc_screen.dart';
import '../../features/settings/profile/edit_profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/settlement/edit_settlement_account_screen.dart';
import '../../features/settings/settlement/link_settlement_bank_screen.dart';
import '../../features/settings/settlement/settlement_bank_accounts_screen.dart';
import '../../features/settings/settlement/settlement_bank_linked_screen.dart';
import '../../features/settings/transaction_pin/change_transaction_pin_screen.dart';
import '../../features/settings/transaction_pin/pin_verification_success-screen.dart';
import '../../features/settings/transaction_pin/reset_transaction_pin_otp_screen.dart';
import '../../features/settings/transaction_pin/reset_transaction_pin_screen.dart';
import '../../features/settings/transaction_pin_security_screen.dart';
import '../../features/wallet/escrow_release_page.dart';
import '../../features/wallet/official_receipt_certificate_screen.dart';
import '../../features/wallet/review_seller.dart';
import '../../features/wallet/settlement_receipt_screen.dart';
import '../../features/wallet/transaction_details_screen.dart';
import '../../features/wallet/wallet_screen.dart';
import '../../features/wrapper_screen.dart';

class AppRoutes {
  AppRoutes._();

  // ============================================================
  // ROUTE NAMES
  // ============================================================

  static const String splashScreen = 'splashScreen';
  static const String userWrapperScreen = 'userWrapperScreen';
  static const String onboardingScreen = 'onboardingScreen';
  static const String walletScreen = 'walletScreen';
  static const String homeScreen = 'HomeScreen';
  static const String propertyDetailsScreen = 'propertyDetailsScreen';
  static const String profileScreen = 'profileScreen';
  static const String portfolioDealsHubScreen = 'portfolioDealsHubScreen';
  static const String propertyDetailsPage = 'propertyDetailsPage';
  static const String propertyTypePage = 'propertyTypePage';
  static const String addPropertyLocationPage = 'addPropertyLocationPage';
  static const String photosVideoPage = 'photosVideoPage';
  static const String listingPreviewPage = 'listingPreviewPage';
  static const String trustVerificationPage = 'trustVerificationPage';
  static const String escrowReleasePage = 'escrowReleasePage';
  static const String reviewSellerScreen = 'reviewSellerScreen';
  static const String appealRestrictionScreen = 'appealRestrictionScreen';
  static const String appealSubmittedScreen = 'appealSubmittedScreen';
  static const String accountRestrictedScreen = 'accountRestrictedScreen';
  static const String disputeCenterPage = 'disputeCenterPage';
  static const String reportProblemPage = 'reportProblemPage';
  static const String submitEvidencePage = 'submitEvidencePage';
  static const String disputeSummaryPage = 'disputeSummaryPage';
  static const String escrowDashboardScreen = 'escrowDashboardScreen';
  static const String fundEscrowScreen = 'fundEscrowScreen';
  static const String escrowStatementScreen = 'escrowStatementScreen';
  static const String activeEscrowTrackerScreen = 'activeEscrowTrackerScreen';
  static const String fundingInstructionsScreen = 'fundingInstructionsScreen';
  static const String explorePropertiesScreen = 'explorePropertiesScreen';
  static const String officialReceiptCertificateScreen =
      'officialReceiptCertificateScreen';
  static const String transactionDetailsScreen = 'transactionDetailsScreen';
  static const String settlementReceiptScreen = 'settlementReceiptScreen';
  static const String accountSettingsScreen = 'accountSettingsScreen';
  static const String chooseYourRoleScreen = 'chooseYourRoleScreen';
  static const String createAccountIdentificationScreen =
      'createAccountIdentificationScreen';
  static const String secureLoginScreen = 'secureLoginScreen';
  static const String verifyOtpScreen = 'verifyOtpScreen';
  static const String transactionPinSecurityScreen =
      'transactionPinSecurityScreen';
  static const String displayOptionsScreen = 'displayOptionsScreen';
   static const String editProfileScreen = 'editProfileScreen';
   static const String linkSettlementBankScreen = 'linkSettlementBankScreen';
   static const String editSettlementAccountScreen = 'editSettlementAccountScreen';
   static const String settlementBankAccountsScreen = 'settlementBankAccountsScreen';
   static const String changeTransactionPinScreen = 'changeTransactionPinScreen';
     static const String resetTransactionPinOtpScreen = 'resetTransactionPinOtpScreen';
   static const String resetTransactionPinScreen = 'resetTransactionPinScreen';
   static const String makeAnOfferScreen = 'makeAnOfferScreen';
   static const String offerConfirmedScreen = 'offerConfirmedScreen';
   static const String verifiedSellerProfileScreen = 'verifiedSellerProfileScreen';
   static const String inspectionConfirmedScreen = 'inspectionConfirmedScreen';
   static const String notificationsScreen = 'notificationsScreen';
   static const String offerReviewScreen = 'offerReviewScreen';
   static const String acceptLockEscrowScreen = 'acceptLockEscrowScreen';
   static const String counterOfferScreen = 'counterOfferScreen';
    static const String disputeCenterScreen = 'disputeCenterScreen';
   static const String settlementBankLinkedScreen = 'settlementBankLinkedScreen';
   static const String pinVerificationSuccessScreen = 'pinVerificationSuccessScreen';
   static const String identityKycScreen = 'identityKycScreen';
   static const String accountVerifiedScreen = 'accountVerifiedScreen';
   static const String authLinkSettlementBankScreen = 'authLinkSettlementBankScreen';
  static const String authRoleVerificationScreen = 'authRoleVerificationScreen';
  static const String authSetEscrowPinScreen = 'authSetEscrowPinScreen';


     // ============================================================
  // ROUTES
  // ============================================================

  static final Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => const SplashScreen(),
    onboardingScreen: (context) => OnboardingScreen(),
    userWrapperScreen: (context) => const UserWrapperScreen(),
    homeScreen: (context) => const HomeScreen(),
    propertyDetailsScreen: (context) => const PropertyDetailsScreen(),
    profileScreen: (context) => const ProfileScreen(),
    walletScreen: (context) => const WalletScreen(),
    portfolioDealsHubScreen: (context) => const PortfolioDealsHubScreen(),
    propertyDetailsPage: (context) => const PropertyDetailsPage(),
    propertyTypePage: (context) => const PropertyTypePage(),
    addPropertyLocationPage: (context) => const AddPropertyLocationPage(),
    photosVideoPage: (context) => const PhotosVideoPage(),
    trustVerificationPage: (context) => const TrustVerificationPage(),
    listingPreviewPage: (context) => const ListingPreviewPage(),
    escrowReleasePage: (context) => const EscrowReleasePage(),
    reviewSellerScreen: (context) => const ReviewSellerScreen(),
    appealRestrictionScreen: (context) => const AppealRestrictionScreen(),
    appealSubmittedScreen: (context) => const AppealSubmittedScreen(),
    accountRestrictedScreen: (context) => const AccountRestrictedScreen(),
    disputeCenterPage: (context) => const DisputeCenterPage(),
    reportProblemPage: (context) => const ReportProblemPage(),
    submitEvidencePage: (context) => const SubmitEvidencePage(),
    disputeSummaryPage: (context) => const DisputeSummaryPage(),
    escrowDashboardScreen: (context) => const EscrowDashboardScreen(),
    fundEscrowScreen: (context) => const FundEscrowScreen(),
    escrowStatementScreen: (context) => const EscrowStatementScreen(),
    activeEscrowTrackerScreen: (context) => const ActiveEscrowTrackerScreen(),
    fundingInstructionsScreen: (context) => const FundingInstructionsScreen(),
    explorePropertiesScreen: (context) => const ExplorePropertiesScreen(),
    officialReceiptCertificateScreen: (context) =>
        const OfficialReceiptCertificateScreen(),
    transactionDetailsScreen: (context) => const TransactionDetailsScreen(),
    settlementReceiptScreen: (context) => const SettlementReceiptScreen(),
    accountSettingsScreen: (context) => const AccountSettingsScreen(),
    chooseYourRoleScreen: (context) => const ChooseYourRoleScreen(),
    createAccountIdentificationScreen: (context) =>
        const CreateAccountIdentificationScreen(),
    secureLoginScreen: (context) => const SecureLoginScreen(),
    verifyOtpScreen: (context) => const VerifyOtpScreen(),
    transactionPinSecurityScreen: (context) =>
        const TransactionPinSecurityScreen(),
    displayOptionsScreen: (context) => const DisplayOptionsScreen(),
    editProfileScreen: (context) => const EditProfileScreen(),
    linkSettlementBankScreen: (context) => const LinkSettlementBankScreen(),
    editSettlementAccountScreen: (context) => const EditSettlementAccountScreen(),
    settlementBankAccountsScreen: (context) => const SettlementBankAccountsScreen(),
    changeTransactionPinScreen: (context) => const ChangeTransactionPinScreen(),
    resetTransactionPinOtpScreen: (context) => const ResetTransactionPinOtpScreen(),
    resetTransactionPinScreen: (context) => const ResetTransactionPinScreen(),
    makeAnOfferScreen: (context) => const MakeAnOfferScreen(),
    offerConfirmedScreen: (context) => const OfferConfirmedScreen(),
    verifiedSellerProfileScreen: (context) => const VerifiedSellerProfileScreen(),
    inspectionConfirmedScreen: (context) => const InspectionConfirmedScreen(),
    notificationsScreen: (context) => const NotificationsScreen(),
    offerReviewScreen: (context) => const OfferReviewScreen(),
    acceptLockEscrowScreen : (context) => const AcceptLockEscrowScreen(),
    counterOfferScreen: (context) => const CounterOfferScreen(),
    disputeCenterScreen: (context) => const DisputeCenterScreen(),
    settlementBankLinkedScreen : (context) => const SettlementBankLinkedScreen(),
    pinVerificationSuccessScreen : (context) => const PinVerificationSuccessScreen(),
    identityKycScreen: (context) => const IdentityKycScreen(),
    accountVerifiedScreen: (context) => const AccountVerifiedScreen(),
    authLinkSettlementBankScreen: (context) => const AuthLinkSettlementBankScreen(),
    authRoleVerificationScreen: (context) => const AuthRoleVerificationScreen(),
    authSetEscrowPinScreen: (context) => const AuthSetEscrowPinScreen(),
  };

  // ============================================================
  // GENERATE ROUTE
  // ============================================================

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final builder = routes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }

    return CupertinoPageRoute(
      builder: (_) => errorView(settings.name ?? 'Unknown'),
      settings: settings,
    );
  }

  // ============================================================
  // ERROR PAGE
  // ============================================================

  static Widget errorView(String name) {
    return Scaffold(
      body: Center(
        child: Text('404\n$name View not found', textAlign: TextAlign.center),
      ),
    );
  }
}
