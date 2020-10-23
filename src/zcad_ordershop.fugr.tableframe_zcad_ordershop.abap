*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZCAD_ORDERSHOP
*   generation date: 21.10.2020 at 14:42:16
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZCAD_ORDERSHOP     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
