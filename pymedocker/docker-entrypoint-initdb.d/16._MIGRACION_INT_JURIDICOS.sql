DECLARE
   --busca si existe un interesado con los datos de interesado juridico
   CURSOR intecursor (ident_empresa IN VARCHAR2)
   IS
      SELECT x_inte
        FROM tr_interesados
       WHERE t_identificador = ident_empresa;

   --busca el tipo de contacto representacion para las relaciones interesado
   CURSOR tipconcursor
   IS
      SELECT x_tcon, c_abreviatura
        FROM tr_tipos_contacto
       WHERE c_abreviatura = 'REP';

   --busca una razon de interes dada su abreviatura
   CURSOR razintcursor (c_abrev IN VARCHAR2)
   IS
      SELECT x_rain
        FROM tr_razones_interes
       WHERE c_abreviatura = c_abrev;

   -- busca si existe un interesado expediente
   CURSOR intexpcursor (
      id_expe   IN   NUMBER,
      id_inte   IN   NUMBER,
      id_rain   IN   NUMBER
   )
   IS
      SELECT expe_x_expe
        FROM tr_interesados_expediente
       WHERE expe_x_expe = id_expe
         AND inte_x_inte = id_inte
         AND rain_x_rain = id_rain;

   id_inte_nuevo            NUMBER (10, 2) := NULL;
   abrev_tipo_contacto      VARCHAR2 (10)  := NULL;
   id_tipo_contacto         NUMBER (10, 2) := NULL;
   raz_social               VARCHAR2 (100) := '-';
   id_nueva_relacion        NUMBER (10, 2) := NULL;
   id_abrev_solicitante     NUMBER (10, 2) := NULL;
   id_abrev_representante   NUMBER (10, 2) := NULL;
   id_expe_intexp           NUMBER (10, 2) := -1;
BEGIN
   OPEN tipconcursor;

   FETCH tipconcursor
    INTO id_tipo_contacto, abrev_tipo_contacto;

   CLOSE tipconcursor;

   OPEN razintcursor ('SOLICITANT');

   FETCH razintcursor
    INTO id_abrev_solicitante;

   CLOSE razintcursor;

   OPEN razintcursor ('REPLEGAL');

   FETCH razintcursor
    INTO id_abrev_representante;

   CLOSE razintcursor;

   IF id_tipo_contacto IS NULL
   THEN
      SELECT tr_s_tcon.NEXTVAL
        INTO id_tipo_contacto
        FROM DUAL;

      INSERT INTO tr_tipos_contacto
                  (x_tcon, c_abreviatura, d_tipo_contacto, l_obsoleto
                  )
           VALUES (id_tipo_contacto, 'REP', 'REPRESENTANTE', 'N'
                  );
   END IF;

--recoore todos los interesados que tienen interesado fisico y juridico en una misma tupla
   FOR reg IN (SELECT x_inte, tiid_c_abreviatura, t_identificador, t_nombre,
                      tiid_c_abrev_empr, t_ident_empresa, t_razon_social,
                      f_creacion, daco_x_daco
                 FROM tr_interesados
                WHERE tiid_c_abrev_empr IS NOT NULL
                  AND tiid_c_abrev_empr = 'CIF'
                  AND t_ident_empresa IS NOT NULL
                  AND t_ident_empresa <> t_identificador)
   LOOP
      OPEN intecursor (reg.t_ident_empresa);

      FETCH intecursor
       INTO id_inte_nuevo;

      CLOSE intecursor;

      IF id_inte_nuevo IS NULL
      --si el interesado juridico no existe lo creamos en la tabla de interesados
      THEN
         SELECT tr_s_inte.NEXTVAL
           INTO id_inte_nuevo
           FROM DUAL;

         IF reg.t_razon_social IS NOT NULL
         THEN
            raz_social := reg.t_razon_social;
         END IF;

         --apellido 2 y sexo por defecto incluyen '-'
         INSERT INTO tr_interesados
                     (x_inte, tiid_c_abreviatura,
                      t_identificador, t_apellido1, t_nombre,
                      tiid_c_abrev_empr, t_ident_empresa, t_razon_social,
                      daco_x_daco
                     )
              VALUES (id_inte_nuevo, reg.tiid_c_abrev_empr,
                      reg.t_ident_empresa, '-', raz_social,
                      reg.tiid_c_abrev_empr, reg.t_ident_empresa, raz_social,
                      reg.daco_x_daco
                     );

         --actualizamos a null los datos de interesado juridico de la tupla de interesado fisico
         UPDATE tr_interesados
            SET tiid_c_abrev_empr = NULL,
                t_ident_empresa = NULL,
                t_razon_social = NULL
          WHERE x_inte = reg.x_inte;

         -- buscamos todos los interesados expediente al que pertence el interesado
         FOR int_exp IN (SELECT f_modifica, expe_x_expe, inte_x_inte,
                                rain_x_rain, daco_x_daco
                           FROM tr_interesados_expediente
                          WHERE inte_x_inte = reg.x_inte)
         LOOP
            SELECT tr_s_rein.NEXTVAL
              INTO id_nueva_relacion
              FROM DUAL;

            --insertamos la relacion del interesado fisico como representante del juridico creado
            INSERT INTO tr_relaciones_interesado
                        (x_rein, inte_x_inte_ini, inte_x_inte_fin,
                         tcon_x_tcon, f_ini_vig, l_representa
                        )
                 VALUES (id_nueva_relacion, reg.x_inte, id_inte_nuevo,
                         id_tipo_contacto, int_exp.f_modifica, 'S'
                        );

            --insertamos un limite de relacion para todos los expedientes con la relacion
            --de representacion creada
            INSERT INTO tr_limites_relacion
                        (x_lire, rein_x_rein,
                         expe_x_expe, f_ini_vig
                        )
                 VALUES (tr_s_lire.NEXTVAL, id_nueva_relacion,
                         int_exp.expe_x_expe, int_exp.f_modifica
                        );

            --necesitamos crear el nuevo interesado expediente para el interesado creado por cada expediente donde estuviese,
            --con razon de interes solicitante.
            INSERT INTO tr_interesados_expediente
                        (expe_x_expe, inte_x_inte,
                         rain_x_rain, daco_x_daco
                        )
                 VALUES (int_exp.expe_x_expe, id_inte_nuevo,
                         id_abrev_solicitante, int_exp.daco_x_daco
                        );
         END LOOP;

         --ademas, para todos los interesados expediente del interesado, modificamos la razon
          --de interesa para que ahora el interesado fisico sea representante legal
         EXECUTE IMMEDIATE 'ALTER TABLE TR_NOTIFICACIONES_INTE DISABLE CONSTRAINT NOIN_INDO_FK';
         EXECUTE IMMEDIATE 'ALTER TABLE TR_INTERESADOS_DOCUMENTO DISABLE CONSTRAINT INDO_INEX_FK';

         UPDATE tr_notificaciones_inte
            SET indo_x_rain_inex = id_abrev_representante
          WHERE indo_x_inte = reg.x_inte;

         UPDATE tr_interesados_documento
            SET inex_x_rain = id_abrev_representante
          WHERE inex_x_inte = reg.x_inte;

         UPDATE tr_interesados_expediente
            SET rain_x_rain = id_abrev_representante
          WHERE inte_x_inte = reg.x_inte;

         EXECUTE IMMEDIATE 'ALTER TABLE TR_NOTIFICACIONES_INTE ENABLE CONSTRAINT NOIN_INDO_FK';
         EXECUTE IMMEDIATE 'ALTER TABLE TR_INTERESADOS_DOCUMENTO ENABLE CONSTRAINT INDO_INEX_FK';
         
      ELSIF id_inte_nuevo IS NOT NULL
      THEN
         --actualizamos a null los datos de interesado juridico de la tupla de interesado
         UPDATE tr_interesados
            SET tiid_c_abrev_empr = NULL,
                t_ident_empresa = NULL,
                t_razon_social = NULL
          WHERE x_inte = reg.x_inte;

         -- buscamos todos los interesados expediente al que pertence el interesado
         FOR int_exp IN (SELECT f_modifica, expe_x_expe, inte_x_inte,
                                rain_x_rain, daco_x_daco
                           FROM tr_interesados_expediente
                          WHERE inte_x_inte = reg.x_inte)
         LOOP
            SELECT tr_s_rein.NEXTVAL
              INTO id_nueva_relacion
              FROM DUAL;

            --insertamos la relacion del interesado fisico como representante del juridico
            INSERT INTO tr_relaciones_interesado
                        (x_rein, inte_x_inte_ini, inte_x_inte_fin,
                         tcon_x_tcon, f_ini_vig, l_representa
                        )
                 VALUES (id_nueva_relacion, reg.x_inte, id_inte_nuevo,
                         id_tipo_contacto, int_exp.f_modifica, 'S'
                        );

            --insertamos un limite de relacion para todos los expedientes con la relacion
            --de representacion creada
            INSERT INTO tr_limites_relacion
                        (x_lire, rein_x_rein,
                         expe_x_expe, f_ini_vig
                        )
                 VALUES (tr_s_lire.NEXTVAL, id_nueva_relacion,
                         int_exp.expe_x_expe, int_exp.f_modifica
                        );

            --necesitamos crear el nuevo interesado expediente para el interesado juridico por cada expediente donde estuviese,
            --con razon de interes solicitante.
            OPEN intexpcursor (int_exp.expe_x_expe,
                               id_inte_nuevo,
                               id_abrev_solicitante
                              );

            FETCH intexpcursor
             INTO id_expe_intexp;

            CLOSE intexpcursor;

            --si no existe interesado expediente previo lo insertamos
            IF id_expe_intexp IS NULL
            THEN
               INSERT INTO tr_interesados_expediente
                           (expe_x_expe, inte_x_inte,
                            rain_x_rain, daco_x_daco
                           )
                    VALUES (int_exp.expe_x_expe, id_inte_nuevo,
                            id_abrev_solicitante, int_exp.daco_x_daco
                           );
            END IF;
         END LOOP;

         --ademas, para todos los interesados expediente del interesado, modificamos la razon
          --de interesa para que ahora el interesado fisico sea representante legal
         EXECUTE IMMEDIATE 'ALTER TABLE TR_NOTIFICACIONES_INTE DISABLE CONSTRAINT NOIN_INDO_FK';
         EXECUTE IMMEDIATE 'ALTER TABLE TR_INTERESADOS_DOCUMENTO DISABLE CONSTRAINT INDO_INEX_FK';

         UPDATE tr_notificaciones_inte
            SET indo_x_rain_inex = id_abrev_representante
          WHERE indo_x_inte = reg.x_inte;

         UPDATE tr_interesados_documento
            SET inex_x_rain = id_abrev_representante
          WHERE inex_x_inte = reg.x_inte;

         UPDATE tr_interesados_expediente
            SET rain_x_rain = id_abrev_representante
          WHERE inte_x_inte = reg.x_inte;

         EXECUTE IMMEDIATE 'ALTER TABLE TR_NOTIFICACIONES_INTE ENABLE CONSTRAINT NOIN_INDO_FK';
         EXECUTE IMMEDIATE 'ALTER TABLE TR_INTERESADOS_DOCUMENTO ENABLE CONSTRAINT INDO_INEX_FK';
         
      END IF;

      id_inte_nuevo := NULL;
      raz_social := '-';
      id_expe_intexp := -1;
   END LOOP;
END;
/