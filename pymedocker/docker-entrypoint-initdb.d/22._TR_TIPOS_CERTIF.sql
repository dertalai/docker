DEF OWNER="TREWA"


Insert into &OWNER..TR_TIPOS_CERTIF
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_TPCR, 
    C_NOMBRE, D_DESCRIPCION, T_URL_CONSULTA, T_CLASE_IMPLEM, CREADO_API, 
    MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 1, 
    'DISCAPACIDAD', 'CERTIFICADO DE DATOS DE DISCAPACIDAD', 'https://ws056.juntadeandalucia.es/map/processes/solicitudCertificadoDiscapacidad.jpd', 'es.juntadeandalucia.plataforma.consultaSCSP.consultaDiscapacidad.ConsultaDatosDiscapacidad', '-', 
    '-');
Insert into &OWNER..TR_TIPOS_CERTIF
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_TPCR, 
    C_NOMBRE, D_DESCRIPCION, T_URL_CONSULTA, T_CLASE_IMPLEM, CREADO_API, 
    MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 2, 
    'FAMILIA_NUM', 'CERTIFICADO DE DATOS DE FAMILIA NUMEROSA', 'https://ws056.juntadeandalucia.es/map/processes/solicitudCertificadoFamiliaNumerosa.jpd', 'es.juntadeandalucia.plataforma.consultaSCSP.consultaFamiliaNum.ConsultaDatosFamiliaNum', '-', 
    '-');
Insert into &OWNER..TR_TIPOS_CERTIF
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_TPCR, 
    C_NOMBRE, D_DESCRIPCION, T_URL_CONSULTA, T_CLASE_IMPLEM, CREADO_API, 
    MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 3, 
    'IDENTIDAD', 'CERTIFICADO DE DATOS DE IDENTIDAD', 'http://ws055.juntadeandalucia.es/scspv3/processes/ConsultaDatosIdentidadDGP.jpd', 'es.juntadeandalucia.plataforma.consultaSCSP.consultaIdentidad.ConsultaDatosIdentidad', '-', 
    '-');
Insert into &OWNER..TR_TIPOS_CERTIF
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_TPCR, 
    C_NOMBRE, D_DESCRIPCION, T_URL_CONSULTA, T_CLASE_IMPLEM, CREADO_API, 
    MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 4, 
    'RESIDENCIA', 'CERTIFICADO DE DATOS DE RESIDENCIA', 'https://ws056.juntadeandalucia.es/map/processes/solicitudSincronaDatosResidencia.jpd', 'es.juntadeandalucia.plataforma.consultaSCSP.consultaResidencia.ConsultaDatosResidencia', '-', 
    '-');
Insert into &OWNER..TR_TIPOS_CERTIF
   (CREADO, F_CREACION, MODIFICADO, F_MODIFICA, X_TPCR, 
    C_NOMBRE, D_DESCRIPCION, T_URL_CONSULTA, T_CLASE_IMPLEM, CREADO_API, 
    MODIFICADO_API)
 Values
   (USER, SYSDATE, USER, SYSDATE, 5, 
    'TGSS', 'CONSULTA DE ESTAR AL CORRIENTE DE PAGO CON LA SEGURIDAD SOCIAL', 'https://ws056.juntadeandalucia.es/scspv3/processes/ConsultaEstarAlCorrienteDePagosTGSS.jpd', 'es.juntadeandalucia.plataforma.consultaSCSP.consultaCorrientePagosTGSS.ConsultaPagosTGSS', '-', 
    '-');	
COMMIT;
