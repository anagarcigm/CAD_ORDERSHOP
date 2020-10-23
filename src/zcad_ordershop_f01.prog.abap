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
  DATA: lv_texto TYPE c LENGTH 50.
  CALL FUNCTION 'ZCAD_CALCULAR_PVP'
    EXPORTING
      numero_piezas = n_piezas
      product       = pe_product
    IMPORTING
      precio        = ps_importe.

  IF ps_importe EQ 0.
    lv_texto = TEXT-001.
    REPLACE FIRST OCCURRENCE OF '&' IN lv_texto WITH pe_product.
    MESSAGE i001(ls) WITH lv_texto.
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

  SELECT MAX( id ) INTO ls_order-id
    FROM zcad_ordershop.

  ADD 1 TO ls_order-id.
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
          gv_error,
          gv_code.
ENDFORM.
