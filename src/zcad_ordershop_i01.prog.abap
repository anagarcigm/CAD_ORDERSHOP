*----------------------------------------------------------------------*
***INCLUDE ZCAD_ORDERSHOP_I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

*  if sy-ucomm eq
  IF sy-ucomm EQ '&F03' OR sy-ucomm EQ '&F12' OR sy-ucomm EQ '&F15'.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_9000 INPUT.


  CASE okcode.
    WHEN 'BUTTON_OK'.
      IF gv_error IS INITIAL.
        PERFORM grabar_order.
      ELSE.
        MESSAGE e001(ls) WITH TEXT-002.
      ENDIF.

    WHEN 'BUTTON_CANC'.
       PERFORM LIMPIAR.
  ENDCASE.
  clear okcode.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CALCULAR_PVP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE calcular_pvp INPUT.


  DATA: lv_importe TYPE ze_totalp.

  CLEAR: ls_order-totalprice,
        gv_error.
  CHECK sy-ucomm NE 'BUTTON_CANC'.

  IF ls_order-screw IS NOT INITIAL.
    PERFORM calcular_imp USING 'SCREW_01'
                                ls_order-screw
                          CHANGING lv_importe.
    IF lv_importe IS NOT INITIAL.
      ADD lv_importe TO ls_order-totalprice.
    ENDIF.
  ENDIF.
  IF ls_order-nuts IS NOT INITIAL.
    PERFORM calcular_imp USING 'NUTS_01'
                               ls_order-nuts
                         CHANGING lv_importe.
    IF lv_importe IS NOT INITIAL.
      ADD lv_importe TO ls_order-totalprice.
    ENDIF.

  ENDIF.
  IF ls_order-washers IS NOT INITIAL.

    PERFORM calcular_imp USING 'WASHER_01'
                                    ls_order-washers
                              CHANGING lv_importe.
    IF lv_importe IS NOT INITIAL.
      ADD lv_importe TO ls_order-totalprice.
    ENDIF.
  ENDIF.
  IF ls_order-bolts IS NOT INITIAL.

    PERFORM calcular_imp USING 'BOLTS_01'
                                    ls_order-bolts
                              CHANGING lv_importe.
    IF lv_importe IS NOT INITIAL.
      ADD lv_importe TO ls_order-totalprice.
    ENDIF.
  ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  DETERMINAR_TTAL  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE determinar_ttal INPUT.
  DATA: ls_cupon TYPE zcad_cupon.
  CHECK sy-ucomm NE 'BUTTON_CANC'.
  IF gv_code = space.
    ls_order-discountedprice =  ls_order-totalprice.
  ELSE.
    SELECT SINGLE * INTO ls_cupon
      FROM zcad_cupon
      WHERE code = gv_code.
    IF sy-subrc EQ 0.
      ls_order-discountedprice =  ls_order-totalprice -
        ( ls_order-totalprice * ls_cupon-percentaje ).
    ELSE.
      MESSAGE i001(ls) WITH TEXT-003.
      ls_order-discountedprice =  ls_order-totalprice.
    ENDIF.
  ENDIF.
ENDMODULE.
