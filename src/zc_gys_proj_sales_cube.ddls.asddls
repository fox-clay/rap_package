@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Composite Cube View for Sales Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.dataCategory: #CUBE
define view entity ZC_GYS_PROJ_SALES_CUBE as select from ZI_GYS_PROJ_SALES
association[1] to ZI_GYS_PROJ_BP as _BusinessPartner on
$projection.Buyer = _BusinessPartner.BpId
association[1] to ZI_GYS_PROJ_PRODUCT as _PRoduct on 
$projection.Product = _PRoduct.ProductId
{
    key ZI_GYS_PROJ_SALES.OrderId,
    key ZI_GYS_PROJ_SALES._Items.item_id as ItemId,
    ZI_GYS_PROJ_SALES.OrderNo,
    ZI_GYS_PROJ_SALES.Buyer,
    ZI_GYS_PROJ_SALES.CreatedBy,
    ZI_GYS_PROJ_SALES.CreatedOn,
    /* Associations */
    ZI_GYS_PROJ_SALES._Items.product as Product,
    @DefaultAggregation: #SUM
    @Semantics.amount.currencyCode: 'CurrencyCode'
    ZI_GYS_PROJ_SALES._Items.amount as GrossAmount,
    ZI_GYS_PROJ_SALES._Items.currency as CurrencyCode,
    @DefaultAggregation: #SUM
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    ZI_GYS_PROJ_SALES._Items.qty as Quantity,
    ZI_GYS_PROJ_SALES._Items.uom as UnitOfMeasure,
    _PRoduct,
    _BusinessPartner
}
