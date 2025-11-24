import 'package:flutter/material.dart';

/// to control all colors, app theme, without any need to dig into code
/// any new color or existing color will have a const with its value
/// there is a stand alone variable for any widget, text, image or icon
///
/// All name colors according to https://chir.ag/projects/name-that-color
///   100% - FF
///   95% - F2
///   90% - E6
///   85% - D9
///   80% - CC
///   75% - BF
///   70% - B3
///   65% - A6
///   60% - 99
///   55% - 8C
///    50% - 80
///    45% - 73
///    40% - 66
///    35% - 59
///   30% - 4D
///   25% - 40
///   20% - 33
///   15% - 26
///   10% - 1A
///    5% - 0D
///   0% - 00

class AppColors {
  static const _black = Colors.black;
  static const _white = Colors.white;
  static const _grey = Colors.grey;

  static const _transparent = Colors.transparent;

  static const _cloudBurst = Color(0xff183059);
  static const _wildSand = Color(0xffF5F5F5);
  static const _yellowOrange = Color(0xffFAAF40);
  static const _bilbao = Color(0xff21790D);
  static const _bluish = Color(0xff276FBF);

  static const _red = Color(0xffDC0000);
  static const _amaranth = Color(0xffF03A47);
  static const _amaranth15 = Color(0x26F03A47);

  static const _frenchGray = Color(0xffCFCFD0);

  static const _blackCow = Color(0xff494947);
  static const _concrete = Color(0xffF2F2F2);
  static const _bananaYellow = Color(0xffFDE74C);
  static const _alto = Color(0xffD9D9D9);
  static const _nobel = Color(0xffB7B7B7);
  static const _geyser = Color(0xffCBD6DE);
  static const _apple = Color(0xff35C139);
  static const _hintOfRed = Color(0xffF6F4F3);
  static const _solitude = Color(0xffe9f2fe);
  static const _starDust = Color(0xff9D9D9C);
  static const _altoD7 = Color(0xffD7D7D7);
  static const _biscay = Color(0xFF183059);
  static const _brightSun = Color(0xffFFCB47);
  static const _dodgerBlue = Color(0xff477BFF);
  static const _turquoise = Color(0xff47D1CB);
  static const _electricViolet = Color(0xff6F47FF);
  static const _concreteF3 = Color(0xffF3F3F3);
  static const _codGray = Color(0xFF1E1E1E);
  static const _doveGray = Color(0xFF6C6C6C);
  static const _scienceBlue = Color(0xff0A75DF);
  static const _gallery = Color(0xffECECEC);
  static const _bluish19 = Color(0x19276FBF);
  static const _fuscousGray = Color(0xff494947);
  static const _gallerySolid = Color(0xFFEFEFEF);
  static const _altoD0 = Color(0xFFD0D0D0);
  static const _mercury = Color(0xFFE2E2E2);
  static const _scorpion = Color(0xFF585858);
  static const _zircon = Color(0xffF8FBFF);
  static const _bridesmaid = Color(0xffFEF0F0);

  /// app main theme ...
  static const colorSchemeSeed = _cloudBurst;
  static const colorPrimary = _bluish;
  static const focus = _bluish;
  static const scaffoldBackground = _transparent;
  static const iconTheme = _bluish;
  static const placeholder = _nobel;

  static const bottomNavigationBackground = _white;
  static const bottomNavigationSelectedItem = _bluish;
  static const bottomNavigationUnselectedItem = _alto;

  static const appBarBackground = _bluish;
  static const appBarTextColor = _white;
  static const appBarIcon = _white;

  static const appMainButton = _bluish;
  static const appSecondButton = _white;
  static const cancelButtonColor = _scorpion;

  static const floatActionBtnIcon = _white;
  static const floatActionBtnBackground = appSecondButton;

  static const titleMedium = _bluish;
  static const headlineMedium = _blackCow;
  static const bodyMedium = _cloudBurst;
  static const bodyLarge = _white;
  static const labelLarge = _blackCow;
  static const labelMedium = _alto;

  static const labelSmall = _alto;
  static const titleSmall = _amaranth;
  static const displayMedium = _nobel;
  static const displayLarge = _black;
  static const displaySmall = _biscay;
  static const bodySmall = _nobel;
  static const titleLarge = _codGray;
  static const headlineLarge = _doveGray;
  static const headlineSmall = _amaranth;

  static const stackedScaffoldBackground = _transparent;

  /// screen modals

  static const modalSheetBackground = _cloudBurst;

  /// toast ..
  static const toastBackground = _black;
  static const toastText = _white;

  /// home widget ..
  static const verifiedCardBackground = _apple;
  static const unVerifiedCardBackground = _amaranth;
  static const verifiedOrUnverifiedCardText = _white;
  static const verifiedDetailsText = _white;
  static const notificationIcon = _cloudBurst;
  static const investmentValue = _bluish;
  static const investmentProfit = _apple;

  /// Auth widget ..
  static const authModeBackground = _concrete;
  static const authActiveModeButtonBackground = _yellowOrange;
  static const authActiveModeButtonText = _white;
  static const authDeActiveModeButtonText = _cloudBurst;
  static const authTextButton = _yellowOrange;
  static const orSocialSection = _alto;
  static const requestOtpMessage = _black;
  static const authSuccessIcon = _bilbao;
  static const authSuccessText = _bilbao;
  static const pinCodeTextFieldFill = _white;
  static const pinCodeTextFieldText = colorPrimary;
  static const socialButtonBackground = _white;
  static const formFieldTitle = _cloudBurst;
  static const loginErrorBackground = _bridesmaid;

  /// app form field
  static const appFormFieldFill = _white;
  static const enabledAppFormFieldBorder = _white;
  static const suffixIcon = _alto;
  static const focusIcon = _yellowOrange;
  static const formFieldText = _black;
  static const formFieldProfileEnableBorder = _frenchGray;
  static const formFieldProfileFocusIBorder = _yellowOrange;
  static const formFieldProfileErrorIBorder = _red;
  static const formFieldFocusIBorder = _cloudBurst;

  /// dialogs ..
  static const closeDialogIcon = _nobel;

  /// countdown widget ..
  static const countdownTxt = _red;

  /// content Locked Widget ..
  static const contentLockedBackground = _bluish;
  static const contentLockedText = _white;
  static const contentLockedIcon = _white;

  /// app buttons
  static const appButtonText = _white;
  static const appButtonBlueBackground = colorPrimary;
  static const appButtonBlueText = colorPrimary;
  static const appButtonWhiteBackground = _white;
  static const appTextButtonText = colorPrimary;
  static const appOutlinedButtonText = colorPrimary;
  static const appOutlinedButtonBorder = colorPrimary;
  static const appShareIcon = _alto;

  /// Search Bar Widget
  static const searchFilterIconBackground = colorPrimary;
  static const searchFilterIcon = _white;
  static const searchIcon = _cloudBurst;
  static const searchText = _geyser;

  /// Investment Widget
  static const investmentCategoryBackground = _bananaYellow;
  static const investmentCompanyHolderBackground = _alto;
  static const investmentCompanyPriceUnite = _nobel;
  static const investmentCompanyOldPrice = _red;

  static const newsDateIcon = _nobel;
  static const newsDateText = _nobel;

  /// Onboarding  Widget
  static const onboardingSliderActiveIndicator = colorPrimary;
  static const onboardingSliderDisableIndicator = _alto;

  /// Project Details Screen
  static const projectDetailsSectionTitle = _cloudBurst;
  static const projectDetailsShowMoreText = colorPrimary;
  static const productSliderActiveIndicator = _bluish;
  static const productSliderDisableIndicator = _alto;
  static const productDetailsFeatureSubtitle = _nobel;
  static const productDetailsFeatureIcon = colorPrimary;
  static const productDetailsFeatureBackground = _hintOfRed;
  static const productDetailsDeveloperInfoBackground = _zircon;
  static const productDetailsDeveloperInfoBorder = _solitude;
  static const productDetailsDeveloperInfoDivider = _nobel;
  static const productDetailsDeveloperInfoImageBackground = _starDust;
  static const productDetailsDeveloperInfoText = _nobel;
  static const productDetailsDeveloperInfoImageText = _white;
  static const outOfStockIcon = _amaranth;

  /// project list screen
  static const resaleInvestmentFeatureText = _nobel;
  static const resaleInvestmentFeatureValue = _blackCow;
  static const projectListSelectedFilterBg = colorPrimary;
  static const projectListUnSelectedFilterBg = _transparent;
  static const projectListFilterBorder = colorPrimary;
  static const projectListSelectedFilterText = _white;
  static const projectListUnSelectedFilterText = colorPrimary;

  /// profile screen
  static const profileScreenVerifyYourAccountCard = _bluish;
  static const profileScreenVerifyYourAccountCardIcon = _white;
  static const profileScreenVerifyYourAccountText = _white;
  static const profileScreenEmailText = _nobel;
  static const profileScreenGeneralText = _nobel;
  static const profileScreenLogOutButtonContent = _amaranth;
  static const profileScreenLogOutButtonBackground = _amaranth15;
  static const profileScreenGeneralSettingLeadingIconBackground = _geyser;
  static const profileScreenProfitExpenseCardDivider = _hintOfRed;
  static const profileScreenProfitExpenseTitles = _nobel;
  static const profileScreenProfitExpenseMoneyAmount = _black;
  static const profileScreenProfitArrow = _apple;
  static const profileScreenExpenseArrow = _amaranth;
  static const profileImageBackground = _hintOfRed;

  /// account details
  static const accountDetailsDivider = _hintOfRed;
  static const accountDetailsDialogBarrier = _cloudBurst;
  static const accountDetailsCardLeadingText = _nobel;
  static const accountDetailsBankAccountDetailsText = _nobel;
  static const accountDetailsButtonBackground = _amaranth15;
  static const accountDetailsButtonContent = _amaranth;
  static const accountDetailsDialogDivider = _geyser;
  static const accountDetailsDeleteMyAccountText = _amaranth;
  static const accountDetailsDeleteMyAccountCloseIcon = _nobel;
  static const accountDetailsDialogDeleteButton = _amaranth;
  static const accountDetailsDialogDeleteButtonText = _white;
  static const accountDetailsDialogCancelButton = _scorpion;
  static const accountDetailsDialogCancelButtonText = _scorpion;

  /// edit account details

  static const editAccountDetailsIconCard = _white;
  static const editAccountDetailsSaveButtonText = _white;
  static const editAccountDetailsCancelButtonText = _nobel;
  static const editAccountDetailsCancelButton = _altoD7;
  static const editAccountDetailsIcon = _bluish;

  /// change password

  static const changePasswordSuccessModalBarrier = _cloudBurst;
  static const changePasswordSuccessText = _bluish;
  static const changePasswordSuccessModalDivider = _geyser;
  static const changePasswordSuccessModalCloseIcon = _geyser;

  /// update profile screen
  static const updateProfileStepDoneIcon = _apple;
  static const updateProfileStepDoneTexts = _nobel;
  static const updateProfileContinueButtonText = _white;

  /// upload id details

  static const uploadIdDetailsAccepted = _apple;
  static const uploadIdDetailsRejected = _amaranth;
  static const uploadIdDetailsBackground = _white;

  /// verify id
  static const verifyIdChooseActionItemText = _black;
  static const verifyIdChooseActionItemIcon = _bluish;
  static const verifyIdChooseActionSheetBarrier = _cloudBurst;
  static const verifyIdChooseActionSheetUpperDivider = _geyser;
  static const verifyIdChooseActionSheetDivider = _hintOfRed;

  /// bankDetails
  static const bankDetailsTextFormFieldHintText = _geyser;
  static const bankDetailsVericalDivider = _black;

  /// payment history
  static const calendarIcon = _blackCow;
  static const paymentHistoryDivider = _concrete;
  static const paymentHistoryListViewBackground = _white;
  static const orderListViewBackground = _white;
  static const closeIcon = _nobel;
  static const currentBalanceBackground = _hintOfRed;
  static const linkIcon = _blackCow;
  static const paymentItemOverDue = _amaranth;
  static const paymentItemUpcoming = _bluish;
  static const paymentItemFulFilled = _apple;
  static const paymentsBlockIcon = _bluish;
  static const paymentsBlockWidgetBackground = _white;
  static const installmentsHistoryCancelButtonBackground = _altoD7;
  static final penaltyBg = _amaranth.withValues(alpha: 0.1);
  static const penaltyText = _amaranth;

  /// bottom sheets
  static const bottomSheetsBackground = _white;
  static const bottomSheetTextFieldBorder = _hintOfRed;
  static const bottomSheetDivider = _geyser;
  static const bottomSheetAddAndRemoveIcon = _bluish;
  static const bottomSheetCancelButton = _scorpion;
  static const bottomSheetArrowDown = _geyser;

  /// more
  static const arrowForward = _white;
  static const customArrowForwardIconBackground = _bluish;
  static const divider = _concrete;

  /// notification
  static const notificationItemBackground = _white;
  static const readNotificationItemBackground = _alto;
  static const leadingIconNotification = _concrete;

  /// sell listing
  static const apartmentsTextBackground = _bananaYellow;
  static const sellListingItemBackground = _white;
  static const sellListingItemStatusCash = _blackCow;
  static const sellListingItemSpaceIcon = _blackCow;
  static const sellListingItemStatusNotCash = _amaranth;
  static const sellListingDelete = _red;

  /// offer resale screen
  static const offerResaleOfferDetailsTitle = _nobel;
  static const offerResaleOfferDetailsPercentage = _blackCow;
  static const offerResaleFilterListSelected = _bluish;
  static const offerResaleFilterListUnSelected = _transparent;

  /// filter modal sheet
  static const filterTitles = _black;
  static const filterUnitTypeUnselectedItemBackGround = _wildSand;
  static const filterUnitTypeSelectedItemBorder = _bluish;
  static const filterUnitTypeUnSelectedItemBorder = _wildSand;
  static const filterUnitTypeSelectedItemBackground = _white;
  static const filterUnitTypeItemTitle = _cloudBurst;
  static const investmentTypeBorder = _hintOfRed;
  static const chooseInvestmentType = _bluish;
  static const notChooseInvestmentType = _alto;

  static const filterDropDownMenuBorder = _hintOfRed;
  static const filterDropDownMenuIcon = _geyser;
  static const filterDropDownMenuHintText = _geyser;
  static const filterResetAllButtonBackground = _scorpion;
  static const filterResetAllButtonText = _nobel;
  static const filterDropDownMenu = _white;

  /// multi selecte drop down
  static const multiDropDownSelectedItemIcon = _bluish;
  static const multiDropDownBorder = _hintOfRed;
  static const multiDropDownFocusBorder = _cloudBurst;
  static const multiDropDownSelectedItemBackground = _bluish;

  /// portfolio
  static const portfolioRetailPercentage = _brightSun;
  static const portfolioApartmentPercentage = _dodgerBlue;
  static const portfolioOfficesPercentage = _electricViolet;
  static const portfolioVillasPercentage = _turquoise;
  static const portfolioMetersOwnedText = _nobel;
  static const portfolioMetersOwnedIcon = _blackCow;
  static const portfolioProfitIcon = _apple;
  static const portfolioInvestmentItemDivider = _concreteF3;
  static const installmentsArrowIcon = _amaranth;

  /// wallet
  static const walletAssetBalanceValues = _black;
  static const walletWithdrawLeading = _bluish;
  static const walletTransactionDetails = _nobel;
  static const walletTransactionStatusSuccess = _apple;
  static const walletTransactionStatusPending = _bluish;
  static const walletTransactionStatusFailure = _amaranth;

  /// rewards
  static const rewardsMoneyAmounts = _black;
  static const rewardsItemIcons = _bluish;

  /// investment Settings
  static const investmentSettingsCheckBoxFill = _white;
  static const investmentSettingsItem = _white;
  static const investmentSettingsCheckBoxBorderSelected = _bluish;
  static const investmentSettingsCheckBoxBorderUnselected = _hintOfRed;
  static const investmentSettingsLocationBorder = _hintOfRed;
  static const investmentSettingsSearchIcon = _cloudBurst;
  static const investmentSettingsSearchText = _geyser;

  /// settings
  static const notAllowToggelIcon = _grey;
  static const languagesWidgetBackground = _white;
  static const helpItemWidgetBackground = _white;
  static const aboutUsItemWidgetBackground = _white;
  static const helpDetailsItemWidgetBackground = _white;
  static const helpIcons = _bluish;
  static const faqDropdownBackground = _white;
  static const faqDropdownIcon = _cloudBurst;

  /// contact us
  static const contactUsItemIconBackground = _bluish;
  static const contactUsIcon = _bluish;

  /// submit resale
  static const submitResaleDropDownMenusBorder = _hintOfRed;
  static const submitResaleCancelButton = _scorpion;
  static const submitResaleLegalPapers = _scienceBlue;
  static const submitResaleLegalPapersCancel = _black;
  static const placeIcon = _bluish;
  static const locateMeContainerBackground = _white;

  /// project statistics
  static const projectStatisticPriceTitle = _nobel;
  static const projectStatisticPricingWidget = _white;
  static const projectStatisticPricingWidgetBar = _geyser;
  static const projectStatisticUnSelectedListBar = _gallery;
  static const projectStatisticSelectedListBar = _bluish;
  static const projectStatisticOfferItemIcon = _white;
  static const projectStatisticOfferItemIconCard = _bluish;
  static const projectStatisticOfferItemPerMeterText = _nobel;
  static const projectStatisticProfit = _apple;

  /// paging
  static const paginationLoadingBackground = _white;

  /// SearchResultScreen

  static const filterDataIcon = colorPrimary;
  static const filterDataText = colorPrimary;
  static const filterDataBackground = _bluish19;

  /// buy an investment

  static const notChooseYourBuyMethodIcon = _alto;
  static const chooseYourBuyMethodIcon = _bluish;
  static const chooseYourBuyMethodBackground = _wildSand;
  static const noActiveButtonBackground = _altoD7;
  static const buttonTitleInCaseDisabled = _nobel;

  /// buy now screen

  static const addAndRemoveButtonBackground = _white;
  static const totalPriceContainerBackground = _bluish;

  /// payment screen

  static const paymentMethodItemImageBackground = _hintOfRed;
  static const paymentMethodItemImageBackgroundnotActive = _mercury;
  static const paymentMethodItemBackground = _white;
  static const paymentMethodItemBackgroundNoActive = _altoD7;
  static const notChooseYourPaymentMethodIcon = _gallerySolid;
  static const notChooseYourNotActivePaymentMethodIcon = _altoD0;
  static const chooseYourPaymentMethodIcon = _bluish;
  static const installmentPlanDetailsBackground = _white;

  /// payment summary screen

  static const purchaseSummaryBackground = _white;
  static const purchaseSummaryDivider = _gallery;
  static const purchaseSummaryCheckBoxBlank = _alto;
  static const purchaseSummaryCheckBox = _bluish;
  static const paymentScheduleBackground = _white;
  static const paymentScheduleIcon = _geyser;
  static const paymentScheduleDivider = _geyser;
  static const paymentScheduleDownPaymentIcon = _bluish;
  static const negativeValue = _amaranth;

  /// secondary market

  static const secondaryMarketItemBorder = _hintOfRed;
  static const secondaryMarketItemBorderSelected = _bluish;

  /// application update
  static const systemUpdateIcon = _bluish;

  /// resale screen
  static const resaleUnitBackground = _white;
  static const resaleUnitApprovedStatus = _apple;
  static const resaleUnitRejectedStatus = _amaranth;
  static const resaleUnitPendingStatus = _bananaYellow;
  static const resaleUnitDivider = _concreteF3;
  static const resaleUnitDetailsBackground = _white;
  static const legalPapersText = _scienceBlue;
  static const legalPapersSizeText = _fuscousGray;

  /// bookMark
  static const bookMarkIconBackground = _bluish;

  /// add funds screen
  static const addfundsMessageBackground = _bluish;
  static const bankAccountNumberBackground = _geyser;

  /// Tags
  static const orderSellingTag = _bluish;
  static const orderBuyingTag = _biscay;
  static const orderTagFont = _white;

  /// Shimmers
  static const baseShimmerColor = _alto;
  static const highlightShimmerColor = _wildSand;
  static const whiteShimmerColor = _white;
  static final whiteWithOpacity = _white.withValues(alpha: 0.1);

  /// Loader
  static const whiteLoader = _white;

  /// Terms and Conditions
  static const termsOfUseBackground = _white;

  static const headerBookmarkButton = _white;
  static const headerBookmarkLoader = _white;

  /// Transaction details screen
  static const transactionDetailsItemBackground = _white;
}
