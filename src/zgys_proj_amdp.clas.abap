CLASS zgys_proj_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    INTERFACES if_oo_adt_classrun .

    CLASS-METHODS add_numbers IMPORTING VALUE(A) TYPE i
                                        VALUE(B) TYPE i
                              EXPORTING VALUE(RESULT) TYPE i.
    CLASS-METHODS get_customer_by_id IMPORTING
                        VALUE(i_bp_id) type zgys_proj_de_id
                        EXPORTING
                         value(e_res) type char40.

    CLASS-METHODS get_product_mrp IMPORTING
                            VALUE(i_tax) type i
                        EXPORTING
                            VALUE(otab) type zgys_proj_tt_product_mrp.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgys_proj_amdp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    zgys_proj_amdp=>get_product_mrp(
      EXPORTING
        i_tax = 18
      IMPORTING
        otab  = data(itab)
    ).

     out->write(
      EXPORTING
        data   = itab
    ).

*    zgys_proj_amdp=>get_customer_by_id(
*      EXPORTING
*        i_bp_id = 'F2BA35A5B4531FE08588CCE715B17639'
*      IMPORTING
*        e_res   =  data(lv_res)
*    ).
*
*    out->write(
*      EXPORTING
*        data   = |The result of AMDP Execution is ---> { lv_res }|
*    ).

*    zgys_proj_amdp=>add_numbers(
*      EXPORTING
*        a      = 34
*        b      = 68
*       IMPORTING
*         result = data(lv_res)
*    ).
*    out->write(
*      EXPORTING
*        data   = |The result of AMDP Execution is ---> { lv_res }|
*    ).
  ENDMETHOD.
  METHOD add_numbers BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY.
    DECLARE X INTEGER;
    DECLARE Y INTEGER;
    X := A;
    Y := B;
    RESULT := :X + :Y;

  ENDMETHOD.

  METHOD get_customer_by_id BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
                            options read-only
                            USING zgys_proj_bp .
         Select company_name into e_res from zgys_proj_bp where bp_id = :i_bp_id;
  ENDMETHOD.
  METHOD get_product_mrp by DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
                         options READ-ONLY
                         using ZGYS_PROJ_PROD.
*        DECLARE Variables
         DECLARE lv_Count INTEGER;
         DECLARE i INTEGER;
         DECLARE lv_mrp BIGINT;
         DECLARE lv_price_d INTEGER;
*        Get all the products in a implicit table (like a internal table in abap)
         lt_prod = SELECT * from zgys_proj_prod;
*        Get the record count of the table records
         lv_count := record_count( :lt_prod );
*        Loop at each record one by one and calculate the price after discount (dbtable)
         for i in 1..:lv_count do
*        Calculate the MRP based on input tax
         lv_price_d := :lt_prod.price[i] * ( 100 - :lt_prod.discount[i]) / 100;
         lv_mrp := :lv_price_d * ( 100 + :i_tax ) / 100;
*        If the MRP id more than 15k, an additional 10% discount to be applied
         if lv_mrp > 15000 then
            lv_mrp := :lv_mrp * 0.90;
         end if;
*        Fill the otab for result(like in abap we fill another internal table with data)
         :otab.insert((
                          :lt_prod.name[i],
                          :lt_prod.category[i],
                          :lt_prod.price[i],
                          :lt_prod.currency[i],
                          :lt_prod.discount[i],
                          :lv_price_d,
                          :lv_mrp ), i );
         END FOR;
  ENDMETHOD.

ENDCLASS.
