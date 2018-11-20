CREATE SCHEMA parlamento
    AUTHORIZATION presupuestos;

COMMENT ON SCHEMA parlamento
    IS 'Esquema para la aplicación de Enmiendas Prespuestarias.';


CREATE SCHEMA parlamento_chap
    AUTHORIZATION presupuestos;

COMMENT ON SCHEMA parlamento_chap
    IS 'Esquema auxiliar que se usa para las importaciones/exportaciones de MS-Access';
