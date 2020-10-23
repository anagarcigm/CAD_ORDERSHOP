*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 20.10.2020 at 15:32:40
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZCAD_PRODUCT....................................*
DATA:  BEGIN OF STATUS_ZCAD_PRODUCT                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCAD_PRODUCT                  .
CONTROLS: TCTRL_ZCAD_PRODUCT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZCAD_PRODUCT                  .
TABLES: ZCAD_PRODUCT                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
