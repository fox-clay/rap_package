@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Analytics Consumption View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@Analytics.query: true
define view entity ZC_GYS_PROJ_SALES_ANALYTICS as select from ZC_GYS_PROJ_SALES_CUBE
{
    key _BusinessPartner.CompanyName,
    key _BusinessPartner.CountryName,
    GrossAmount,
    CurrencyCode,
    Quantity,
    UnitOfMeasure
}
