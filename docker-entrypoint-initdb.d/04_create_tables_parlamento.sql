COMMENT ON SCHEMA parlamento IS 'Esquema para la aplicación de Enmiendas Prespuestarias.';

DROP TABLE IF EXISTS parlamento.fichero CASCADE;

CREATE TABLE parlamento.fichero (
	id int8 NOT NULL,
	content_type varchar(255) NULL,
	"extension" varchar(255) NULL,
	fichero oid NULL,
	nombre varchar(255) NULL,
	CONSTRAINT fichero_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS parlamento.ggpp CASCADE;

CREATE TABLE parlamento.ggpp (
	id int8 NOT NULL,
	texto_firma_portavoz varchar(255) NULL,
	letra_codigo_enmienda varchar(255) NULL,
	nombre_abreviado varchar(255) NULL,
	nombre_completo varchar(255) NULL,
	ou_ldap varchar(255) NULL,
	nombre_portavoz varchar(255) NULL,
	id_fichero_logo_ggpp int8 NULL,
	CONSTRAINT ggpp_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_fichero_logo_ggpp FOREIGN KEY (id_fichero_logo_ggpp) REFERENCES parlamento.fichero(id)
);


DROP TABLE IF EXISTS parlamento.proyecto_ley CASCADE;

CREATE TABLE parlamento.proyecto_ley (
	id int8 NOT NULL,
	activo bool NULL,
	anio int4 NOT NULL,
	flag_eliminado bool NULL,
	expediente varchar(255) NULL,
	f_fin_fiscalizacion date NULL,
	f_fin_registro date NULL,
	f_inicio_fiscalizacion date NULL,
	f_inicio_registro date NULL,
	fichero_access bool NULL,
	id_fichero_pdf int8 NULL,
	CONSTRAINT proyecto_ley_pkey PRIMARY KEY (id),
	CONSTRAINT uk_anio_proyecto_ley UNIQUE (anio),
	CONSTRAINT fk_id_fichero_pdf FOREIGN KEY (id_fichero_pdf) REFERENCES parlamento.fichero(id)
);


DROP TABLE IF EXISTS parlamento.aplicacion cascade;

CREATE TABLE parlamento.aplicacion (
	tipo_presupuesto varchar(31) NOT NULL,
	id int8 NOT NULL,
	aplicacion varchar(255) NULL,
	aplicacion_enm_creacion bool NULL DEFAULT false,
	aplieco varchar(6) NULL,
	articulo varchar(2) NULL,
	capitulo varchar(255) NULL,
	concepto varchar(3) NULL,
	denominacion varchar(140) NULL,
	importe float8 NULL,
	medida varchar(15) NULL,
	programa varchar(255) NULL,
	provincia varchar(2) NULL,
	proyecto varchar(255) NULL,
	seccion varchar(255) NULL,
	servicio varchar(255) NULL,
	id_proyecto_ley int8 NULL,
	CONSTRAINT aplicacion_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_proyecto_ley FOREIGN KEY (id_proyecto_ley) REFERENCES parlamento.proyecto_ley(id)
);

DROP TABLE IF EXISTS parlamento.programa CASCADE;

CREATE TABLE parlamento.programa (
	id int8 NOT NULL,
	anio int2 NULL,
	codigo_programa varchar(255) NULL,
	denom_corta varchar(255) NULL,
	denom_larga varchar(255) NULL,
	id_proyecto_ley int8 NULL,
	CONSTRAINT programa_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_proyecto_ley FOREIGN KEY (id_proyecto_ley) REFERENCES parlamento.proyecto_ley(id)
);


DROP TABLE IF EXISTS parlamento.seccion CASCADE;

CREATE TABLE parlamento.seccion (
	id int8 NOT NULL,
	codigo_seccion varchar(255) NULL,
	denom_corta varchar(255) NULL,
	denom_larga varchar(255) NULL,
	id_proyecto_ley int8 NULL,
	CONSTRAINT seccion_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_proyecto_ley FOREIGN KEY (id_proyecto_ley) REFERENCES parlamento.proyecto_ley(id)
);



DROP TABLE IF EXISTS parlamento.servicio;

CREATE TABLE parlamento.servicio (
	id int8 NOT NULL,
	anio int2 NULL,
	codigo_servicio varchar(255) NULL,
	denom_corta varchar(255) NULL,
	denom_larga varchar(255) NULL,
	id_proyecto_ley int8 NULL,
	id_seccion int8 NULL,
	CONSTRAINT servicio_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_proyecto_ley FOREIGN KEY (id_proyecto_ley) REFERENCES parlamento.proyecto_ley(id),
	CONSTRAINT fk_id_seccion FOREIGN KEY (id_seccion) REFERENCES parlamento.seccion(id)
);


DROP TABLE IF EXISTS parlamento.tipo_enm_articulado CASCADE;

CREATE TABLE parlamento.tipo_enm_articulado (
	tipo_enmienda_articulado varchar(31) NOT NULL,
	id int8 NOT NULL,
	CONSTRAINT tipo_enm_articulado_pkey PRIMARY KEY (id)
);



DROP TABLE IF EXISTS parlamento.tipo_enmienda_presup cascade;

CREATE TABLE parlamento.tipo_enmienda_presup (
	id int8 NOT NULL,
	enabled bool NULL DEFAULT true,
	sub_tipo_enmienda varchar(255) NULL,
	tipo_enmienda varchar(255) NULL,
	CONSTRAINT tipo_enmienda_presup_pkey PRIMARY KEY (id)
);


DROP TABLE IF EXISTS parlamento.enmienda CASCADE;

CREATE TABLE parlamento.enmienda (
	tipo_enmienda varchar(31) NOT NULL,
	id int8 NOT NULL,
	contador int8 NULL,
	usuario_actualizacion varchar(255) NULL,
	usuario_creacion varchar(255) NULL,
	id_ggpp int8 NULL,
	id_proyecto_ley int8 NULL,
	CONSTRAINT enmienda_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_ggpp FOREIGN KEY (id_ggpp) REFERENCES parlamento.ggpp(id),
	CONSTRAINT fk_id_proyecto_ley FOREIGN KEY (id_proyecto_ley) REFERENCES parlamento.proyecto_ley(id)
);


DROP TABLE IF EXISTS parlamento.aplicacion_enm_presupuestaria;

CREATE TABLE parlamento.aplicacion_enm_presupuestaria (
	id_aplicacion int8 NOT NULL,
	id_enm_presupuestaria int8 NOT NULL,
	importe float8 NULL,
	CONSTRAINT aplicacion_enm_presupuestaria_pkey PRIMARY KEY (id_aplicacion, id_enm_presupuestaria)
);


DROP TABLE IF EXISTS parlamento.enmienda_articulado;

CREATE TABLE parlamento.enmienda_articulado (
	id_enmienda varchar(255) NULL,
	texto_justificacion varchar(255) NULL,
	seccion_nueva varchar(255) NULL,
	seccion_origen varchar(255) NULL,
	texto_nuevo varchar(255) NULL,
	texto_original varchar(255) NULL,
	id int8 NOT NULL,
	id_tipo_enmienda_articulado int8 NULL,
	CONSTRAINT enmienda_articulado_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_enmienda FOREIGN KEY (id) REFERENCES parlamento.enmienda(id),
	CONSTRAINT fk_id_tipo_enmienda_articulado FOREIGN KEY (id_tipo_enmienda_articulado) REFERENCES parlamento.tipo_enm_articulado(id)
);



DROP TABLE IF EXISTS parlamento.enmienda_presupuestaria;

CREATE TABLE parlamento.enmienda_presupuestaria (
	id_enmienda varchar(255) NULL,
	importe float8 NULL,
	nueva_descripcion varchar(255) NULL,
	proyecto varchar(255) NULL,
	texto_enmienda varchar(255) NULL,
	texto_justificacion varchar(255) NULL,
	id int8 NOT NULL,
	id_aplicacion int8 NULL,
	id_tipo_enm_presupuestaria int8 NULL,
	CONSTRAINT enmienda_presupuestaria_pkey PRIMARY KEY (id),
	CONSTRAINT fk_id_aplicacion FOREIGN KEY (id_aplicacion) REFERENCES parlamento.aplicacion(id),
	CONSTRAINT fk_id_enmienda FOREIGN KEY (id) REFERENCES parlamento.enmienda(id),
	CONSTRAINT fk_id_tipo_enm_presupuestaria FOREIGN KEY (id_tipo_enm_presupuestaria) REFERENCES parlamento.tipo_enmienda_presup(id)
);
