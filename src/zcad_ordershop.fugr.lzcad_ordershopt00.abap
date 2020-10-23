*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 21.10.2020 at 14:42:17
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZCAD_ORDERSHOP..................................*
DATA:  BEGIN OF STATUS_ZCAD_ORDERSHOP                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCAD_ORDERSHOP                .
CONTROLS: TCTRL_ZCAD_ORDERSHOP
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZCAD_ORDERSHOP                .
TABLES: ZCAD_ORDERSHOP                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
