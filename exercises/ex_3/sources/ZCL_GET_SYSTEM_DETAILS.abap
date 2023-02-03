class ZCL_GET_SYSTEM_DETAILS definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GET_SYSTEM_DETAILS IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   TRY.

        DATA lv_result TYPE string.
        DATA lv_sysinfo TYPE string.
        DATA lv_client TYPE string.
        DATA lv_sid TYPE string.
        DATA msg       TYPE bapiret2.

        CALL FUNCTION 'Z_GET_SYSTEM_DETAILS'
          EXPORTING
            userid   = sy-uname
          IMPORTING
            sys_info = lv_sysinfo
            sid      = lv_sid
            client   = lv_client
            e_msg    = msg
          .

        CONCATENATE lv_sid ':' lv_client ' with Embedded Steampunk' INTO lv_result.

      CATCH cx_root INTO DATA(lx_root).
    ENDTRY.

    response->set_text( lv_result ).


  endmethod.
ENDCLASS.
