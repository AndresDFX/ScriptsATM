DIA=`date +"%d"`
MES=`date +"%m"`
ANIO=`date +"%Y"`
HORA=`date +"%H"`
MINUTO=`date +"%M"`

N_DIAS=2

NOMBRE_DB="database"
NOMBRE_PROYECTO="proyecto"
FORMATO_NOMBRE="${ANIO}_${MES}_${DIA}"

######## RUTA DE BACKUP LOCAL ########
RUTA_LOCAL_BACKUP="/var/www/html/backups"
RUTA_LOCAL_BACKUP_DB="${RUTA_LOCAL_BACKUP}/backup_${FORMATO_NOMBRE}/base_datos"
RUTA_LOCAL_BACKUP_MEDIA="${RUTA_LOCAL_BACKUP}/backup_${FORMATO_NOMBRE}/media"
RUTA_LOCAL_BACKUP_APPS="${RUTA_LOCAL_BACKUP}/backup_${FORMATO_NOMBRE}/apps"

######## CONFIGURACION BACKUP LOCAL DE NOMBRE DE CARPETAS PARA BASE DE ######## DATOS Y MEDIA ########
nombre_archivo_backup_bd="${NOMBRE_DB}_${FORMATO_NOMBRE}.db"
nombre_archivo_backup_media="media_${FORMATO_NOMBRE}.zip"

######## CONFIGURACION BACKUP CARPETA APPS ########
nombre_carpeta_apps='apps' 
nombre_archvio_backup_apps="${nombre_carpeta_apps}_${FORMATO_NOMBRE}.zip" 
RUTA_APPS="/var/www/html/parir/${nombre_carpeta_apps}/*"
RUTA_APPS_TEMPORAL="/var/www/html/${NOMBRE_PROYECTO}/apps_temp"

######## CREACION CARPETAS ########
mkdir -p "${RUTA_APPS_TEMPORAL}/${nombre_carpeta_apps}"
mkdir -p ${RUTA_LOCAL_BACKUP_DB}
mkdir -p ${RUTA_LOCAL_BACKUP_MEDIA}
mkdir -p ${RUTA_LOCAL_BACKUP_APPS}

######## CONFIGURACION PARA ACCEDER A LA BASE DE DATOS ########
contrasenia_base_datos='parir_servidor_produccion'
host='localhost'
usuario_base_datos='postgres'
base_de_datos='${NOMBRE_DB}'
puerto=5432

PGPASSWORD=${contrasenia_base_datos} pg_dump -h ${host} -U ${usuario_base_datos} -p ${puerto} ${base_de_datos} > "${RUTA_LOCAL_BACKUP_DB}/${nombre_archivo_backup_bd}"

######## BORRAR CARPETA BACKUP MAYOR A N_DIAS ########
find ${RUTA_LOCAL_BACKUP} -name 'backup*' -mtime +$((N_DIAS)) -exec rm -r {} +

######## CREAR BACKUP CARPETA APPS ########
for file in $RUTA_APPS ;do
        filename=$(basename "m$file")
        if [ $filename != 'media' ] && [ $filename != 'static' ]; then
                if [ $filename != 'templates' ];
                then
                        echo "Nombre del ficehro: $filename";
                        cp -r $file "${RUTA_APPS_TEMPORAL}/${nombre_carpeta_apps}/"
                fi
        fi
done;

######## CREAR BACKUP DE CARPETA APPS ########
cd "${RUTA_APPS_TEMPORAL}" 
zip -r "${RUTA_LOCAL_BACKUP_APPS}/$nombre_archvio_backup_apps" parir;
rm -rf "${RUTA_APPS_TEMPORAL}"

######## CREAR BACKUP DE MEDIA ######## cd /var/www/html/parir/parir/ 
cd "/var/www/html/parir/parir"
zip -r "${RUTA_LOCAL_BACKUP_MEDIA}/${nombre_archivo_backup_media}" media;
