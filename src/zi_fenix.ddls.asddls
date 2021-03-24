@AbapCatalog.sqlViewName: 'ZIFENIX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vista de ZCAD_FENIX'
@VDM.viewType: 'Basic'
@Analytics.dataCategory: #FACT

define root view ZI_FENIX
  as select from ZCAD_FENIX
{
  key project as project,
  key centersNumberEmployee as centersNumberEmployee,
  description as description,
  center as center,
  serverPassword as serverPassword,
  isAutenticated as isAutenticated,
  alert as alert,
  creationDate as creationDate,
  startDate as startDate
}
