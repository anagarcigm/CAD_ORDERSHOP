*&---------------------------------------------------------------------*
*& Report ZCAD_MANTEINANCE_TABLES101
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcad_manteinance_tables101.
DATA: gv_tabla TYPE tabname.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: r_op1 RADIOBUTTON GROUP gr1,
              r_op3 RADIOBUTTON GROUP gr1 DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK b1.


END-OF-SELECTION.
  CLEAR gv_tabla.
  IF r_op1 EQ abap_true.
    gv_tabla = 'ZCAD_PRODUCT'.
  ELSEIF r_op3 EQ abap_true.
    gv_tabla = 'ZCAD_CUPON'.
  ENDIF.
  CHECK gv_tabla IS NOT INITIAL.
  CALL FUNCTION 'VIEW_MAINTENANCE_CALL'
    EXPORTING
      action                       = 'U'
      view_name                    = gv_tabla
    EXCEPTIONS
      client_reference             = 1
      foreign_lock                 = 2
      invalid_action               = 3
      no_clientindependent_auth    = 4
      no_database_function         = 5
      no_editor_function           = 6
      no_show_auth                 = 7
      no_tvdir_entry               = 8
      no_upd_auth                  = 9
      only_show_allowed            = 10
      system_failure               = 11
      unknown_field_in_dba_sellist = 12
      view_not_found               = 13
      maintenance_prohibited       = 14
      OTHERS                       = 15.
