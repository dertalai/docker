DEF OWNER="TREWA"

Insert into &OWNER..TR_ESTELAB_ENI
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_ESLA, 
    C_ESTELAB_ENI, D_ESTELAB_ENI, CREADO_API, MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 1, 
    'EE01', 'Original', '-', '-');
Insert into &OWNER..TR_ESTELAB_ENI
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_ESLA, 
    C_ESTELAB_ENI, D_ESTELAB_ENI, CREADO_API, MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 2, 
    'EE02', 'Copia electrónica auténtica con cambio de formato', '-', '-');
Insert into &OWNER..TR_ESTELAB_ENI
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_ESLA, 
    C_ESTELAB_ENI, D_ESTELAB_ENI, CREADO_API, MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 3, 
    'EE03', 'Copia electrónica auténtica de documento papel', '-', '-');
Insert into &OWNER..TR_ESTELAB_ENI
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_ESLA, 
    C_ESTELAB_ENI, D_ESTELAB_ENI, CREADO_API, MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 4, 
    'EE04', 'Copia electrónica parcial auténtica', '-', '-');
Insert into &OWNER..TR_ESTELAB_ENI
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_ESLA, 
    C_ESTELAB_ENI, D_ESTELAB_ENI, CREADO_API, MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 5, 
    'EE99', 'Otros', '-', '-');
COMMIT;
