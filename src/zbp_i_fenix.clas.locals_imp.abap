*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_zi_fenix DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.


       METHODS get_features FOR FEATURES IMPORTING keys
       REQUEST requested_features FOR FENIX RESULT result.
ENDCLASS.
CLASS lhc_zi_fenix IMPLEMENTATION.
 method get_features.

 READ ENTITY ZI_FENIX
         FROM VALUE #( FOR keyval IN keys
                     (  %key            = keyval-%key
                        %control-project = if_abap_behv=>mk-on
                        %control-centersNumberEmployee = if_abap_behv=>mk-on
                                                     ) )
                                    RESULT  DATA(lt_result).
         result = VALUE #( FOR ls_data IN LT_RESULT
       ( %key = ls_data-%key
        %field-project = if_abap_behv=>fc-f-read_only
        %field-centersNumberEmployee = if_abap_behv=>fc-f-read_only
           ) ).

  ENDMETHOD.
ENDCLASS.
