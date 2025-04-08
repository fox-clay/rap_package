@AbapCatalog.sqlViewName: 'ZGYSPROJCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Old Approach of CDS Views'
@Metadata.ignorePropagatedAnnotations: true
define view ZGYS_PROJ_CDS as select from zgys_proj_bp
{
    key bp_id as BpId,
    bp_role as BpRole,
    company_name as CompanyName,
    street as Street,
    country as Country,
    region as Region,
    city as City
}
