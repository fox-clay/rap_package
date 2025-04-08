@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Master Data CDS Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_GYS_PROJ_PRODUCT as select from zgys_proj_prod
{
    key product_id as ProductId,
    name as Name,
    category as Category,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    currency as Currency,
    discount as Discount
}
