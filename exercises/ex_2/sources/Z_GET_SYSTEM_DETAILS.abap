FUNCTION Z_GET_SYSTEM_DETAILS
 IMPORTING
    VALUE(userid) TYPE syuname OPTIONAL
  EXPORTING
    VALUE(sys_info) TYPE string
    VALUE(sid) TYPE string
    VALUE(client) TYPE string
    VALUE(e_msg) TYPE bapiret2
  RAISING
    cx_sca_remote_connection_error.



  TRY.

      DATA lv_result TYPE rfcsi.
      DATA lv_msg TYPE bapiret2.

      CLEAR lv_msg.

      CALL FUNCTION 'BAPI_USER_EXISTENCE_CHECK'
        EXPORTING
          username = userid
        IMPORTING
          return   = lv_msg.

      IF lv_msg-number <> '088'.
*      error message
        sys_info = '0'.
        client = '0'.
        sid = '0'.
        e_msg = lv_msg.

      ELSE.

        CALL FUNCTION 'RFC_SYSTEM_INFO'
          IMPORTING
            rfcsi_export          = lv_result
          EXCEPTIONS
            system_failure        = 1
            communication_failure = 2
            OTHERS                = 3.

        sys_info = lv_result.
        client = sy-mandt.
        sid = lv_result-rfcsysid.
      ENDIF.

    CATCH cx_sca_remote_connection_error INTO DATA(lx_remote).
  ENDTRY.


ENDFUNCTION.
