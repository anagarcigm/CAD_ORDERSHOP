*&---------------------------------------------------------------------*
*& Report ZCAD_LISTSALES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcad_listsales.
TABLES zcad_ordershop.
DATA: t_data    TYPE TABLE OF zcad_ordershop,
      t_catalog TYPE slis_t_fieldcat_alv.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_id FOR zcad_ordershop-id.
SELECTION-SCREEN END OF BLOCK b1.


START-OF-SELECTION.

  SELECT * INTO TABLE t_data
    FROM zcad_ordershop
  WHERE id IN s_id.

END-OF-SELECTION.

  IF t_data[] IS INITIAL.
    MESSAGE i002(ls).
  ELSE.

    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
*       I_PROGRAM_NAME         =
*       I_INTERNAL_TABNAME     =
        i_structure_name       = 'ZCAD_ORDERSHOP'
        i_client_never_display = 'X'
*       I_INCLNAME             =
*       I_BYPASSING_BUFFER     =
*       I_BUFFER_ACTIVE        =
      CHANGING
        ct_fieldcat            = t_catalog
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        it_fieldcat   = t_catalog
      TABLES
        t_outtab      = t_data[]
      EXCEPTIONS
        program_error = 1
        OTHERS        = 2.



  ENDIF.
