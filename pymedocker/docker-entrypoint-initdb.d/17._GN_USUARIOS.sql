DEF OWNER="TREWA"

Insert into &OWNER..GN_USUARIOS
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, C_USUARIO, 
    V_TIPO_IDENT, T_IDENTIFICADOR, T_APELLIDO1, T_APELLIDO2, T_NOMBRE, 
    V_SEXO, F_ALTA, F_BAJA, T_EMAIL, T_CLAVE, 
    C_ANAGRAMA_FISCAL, CREADO_API, MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 'TREWA', 
    'D', '30971231Y', 'TRAMITADOR', ' DE PROCEDIMIENTOS', 'TREWA', 
    'F', SYSDATE, NULL, NULL, '0cc175b9c0f1b6a831c399e269772661', 
    'SXSERVIZOS', "-", "-");
COMMIT;
