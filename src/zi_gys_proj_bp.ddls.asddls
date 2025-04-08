@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity ZI_GYS_PROJ_BP as select from zgys_proj_bp
association[1] to I_Country as _Country on
$projection.CountryCode = _Country.Country
{
    key bp_id as BpId,
    bp_role as BpRole,
    company_name as CompanyName,
    street as Street,
    country as CountryCode,
    region as Region,
    city as City,
    _Country._Text[Language = $session.system_language].CountryName as CountryName
}
