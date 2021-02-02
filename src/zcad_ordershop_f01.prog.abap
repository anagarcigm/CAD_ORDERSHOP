*----------------------------------------------------------------------*
***INCLUDE ZCAD_ORDERSHOP_F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form calcular_imp
*&---------------------------------------------------------------------*
*& Calcular importe
*&---------------------------------------------------------------------*
FORM calcular_imp  USING    VALUE(pe_product) TYPE ze_idproduct
                             n_piezas TYPE int1
                            CHANGING ps_importe TYPE ze_totalp.
  DATA: lv_texto  TYPE c LENGTH 50,
        lv_return LIKE sy-subrc,
        lv_save   TYPE sy-ucomm.


  CLEAR lv_return.

  CALL FUNCTION 'ZCAD_CALCULAR_PVP'
    EXPORTING
      numero_piezas = n_piezas
      product       = pe_product
    IMPORTING
      precio        = ps_importe
      control_stock = lv_return.

  IF ps_importe EQ 0.
    lv_texto = TEXT-001.
    REPLACE FIRST OCCURRENCE OF '&' IN lv_texto WITH pe_product.
    MESSAGE i001(ls) WITH lv_texto.
    gv_error = abap_true.
  ELSEIF lv_return NE 0.
    MESSAGE i001(ls) WITH TEXT-005 pe_product.
    gv_error = abap_true.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form GRABAR_ORDER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM grabar_order .

  DATA: lx_error TYPE REF TO cx_root.

  TRY.
      ls_order-order_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    CATCH cx_uuid_error INTO lx_error.
      ASSERT lx_error IS INITIAL.  " fails always here
  ENDTRY.

  PERFORM update_stock.
  CHECK gv_error IS INITIAL.
  SELECT MAX( id ) INTO ls_order-id
    FROM zcad_ordershop.

  ADD 1 TO ls_order-id.
  ls_order-id = |{ ls_order-id ALPHA = IN }|.

  INSERT zcad_ordershop FROM ls_order.
  IF sy-subrc EQ 0.
    MESSAGE i001(ls) WITH TEXT-004.
  ENDIF.
  PERFORM limpiar.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form LIMPIAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM limpiar .
  CLEAR:ls_order,
          gv_error.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form UPDATE_STOCK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM update_stock .

  IF ls_order-screw IS NOT INITIAL.
    PERFORM update_tab_stock USING 'SCREW_01'
                                ls_order-screw
                                'X'.
    CHECK gv_error IS INITIAL.

  ENDIF.
  IF ls_order-nuts IS NOT INITIAL.
    PERFORM  update_tab_stock USING 'NUTS_01'
                               ls_order-nuts
                               'X'.

    CHECK gv_error IS INITIAL.
  ENDIF.
  IF ls_order-washers IS NOT INITIAL.

    PERFORM  update_tab_stock USING 'WASHER_01'
                                    ls_order-washers
                                   'X'.

    CHECK gv_error IS INITIAL.
  ENDIF.
  IF ls_order-bolts IS NOT INITIAL.

    PERFORM update_tab_stock USING 'BOLTS_01'
                                    ls_order-bolts
                                    'X'.

    CHECK gv_error IS INITIAL.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form UPDATE_TAB_STOCK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> LS_ORDER_SCREW
*&      --> P_
*&---------------------------------------------------------------------*
FORM update_tab_stock  USING    VALUE(p_producto)
                                pe_piezas TYPE int1
                                VALUE(p_save).

  DATA: lv_retorno LIKE sy-subrc.
  CALL FUNCTION 'ZCAD_CALCULAR_PVP'
    EXPORTING
      numero_piezas = pe_piezas
      product       = p_producto
      save_stock    = p_save
    IMPORTING
*     PRECIO        =
      control_stock = lv_retorno.
  IF lv_retorno NE 0.
    MESSAGE i001(ls) WITH TEXT-006.
    gv_error = abap_true.
  ENDIF.


ENDFORM.
