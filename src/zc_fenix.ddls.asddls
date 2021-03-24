@EndUserText.label: 'Proyection ZI_FENIX'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define root view entity ZC_FENIX as projection on ZI_FENIX
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
