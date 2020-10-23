*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 21.10.2020 at 13:27:02
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZCAD_CUPON......................................*
DATA:  BEGIN OF STATUS_ZCAD_CUPON                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCAD_CUPON                    .
CONTROLS: TCTRL_ZCAD_CUPON
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZCAD_CUPON                    .
TABLES: ZCAD_CUPON                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
