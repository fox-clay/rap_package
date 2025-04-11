@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Rank'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:
{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_GYS_PROJ_SALES_RANK
  as select from ZGYS_PROJ_TF( p_clnt: $session.client ) as ranked
    inner join   zgys_proj_bp                            as bpa   on ranked.company_name = bpa.company_name
//    inner join   zgys_proj_region                        as regio on bpa.region = regio.region
{
  key ranked.company_name,
  @Semantics.amount.currencyCode: 'currency_code'
  ranked.total_sales,
  ranked.currency_code,
  ranked.customer_rank
//  regio.regionname
}
