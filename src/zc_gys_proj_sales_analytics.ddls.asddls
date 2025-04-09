@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Analytics Consumption View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//Uncomment the Commented Code and Press f8 for Running the application in Analytics
//@Analytics.query: true
define view entity ZC_GYS_PROJ_SALES_ANALYTICS as select from ZC_GYS_PROJ_SALES_CUBE
{
    key _BusinessPartner.CompanyName,
    key _BusinessPartner.CountryName,
    @Aggregation.default: #SUM
    @Semantics.amount.currencyCode:'CurrencyCode'
    //@AnalyticsDetails.query.axis: #COLUMNS
    GrossAmount,
    //@AnalyticsDetails.query.axis: #ROWS
    //@Consumption.filter.selectionType: #SINGLE
    CurrencyCode,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    //@AnalyticsDetails.query.axis: #COLUMNS
    Quantity,
    //@AnalyticsDetails.query.axis: #ROWS
    UnitOfMeasure
}
