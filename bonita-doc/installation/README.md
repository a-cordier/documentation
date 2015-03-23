# Installation de BonitaBPMSubscription-6.3.2

Ce document décrit comment installer un environement de développement (cf document à venir pour le tunning)

SGBD de référence PostgreSQL 9.3

**Pour postgreSQL:**

- Si la jvm est une 1.6  utiliser le driver PostgreSQL JDBC4
 - Si la jvm est une 1.7  utiliser le driver JDBC41 
- la valeur de l'option max\prepared\_transaction doit correspondre à la valeur de l'option max_connections (postgresql.conf)

** Télécharger et extraire BonitaBPMSubscription-6.3.2-Tomcat-6.0.37.zip**

** Extraire support.zip**

### Convention

Chemin d'extraction du fichier support.zip  := $SUPPORT
 
Répertoire d'extraction du bundle tomcat := $BONITA_BASE 

Utilisateur exécutant tomcat startup.sh := $USER 

### Editer les fichiers dans  $SUPPORT 

Editer bitronix-resources.properties pour configurer le gestionnaire de transaction pour le datasource de bonita  **et le datasource métier**

Editer bonita.xml pour configurer le datasource bonita **et le datasource métier**

Editer bonita-platform.properties (identifiants du platformAdmin)

Editer platform-tenant-config.properties (identifiants du "technical user")

Editer bonita-server.properties (identifiants du "technical user" + businessdata.hibernate.dialect conforme au SGBD)

Editer setenv.sh (DB_OPTS="-Dsysprop.bonita.db.vendor=postgres")

** Attention à la correspondance des identifiants pour le "technical user" entre les fichiers

### Ecraser les fichiers

Contenu du fichier Export.sh
```
cp -v $SUPPORT/bonita.xml $BONITA_BASE/conf/Catalina/localhost/bonita.xml
cp -v $SUPPORT/bitronix-resources.properties $BONITA_BASE/conf/bitronix-resources.properties
cp -v $SUPPORT/setenv.sh $BONITA_BASE/bin/setenv.sh
cp -v $SUPPORT/bonita-server.properties $BONITA_BASE/bonita/server/platform/tenant-template/conf/bonita-server.properties
cp -v $SUPPORT/bonita-platform.properties $BONITA_BASE/bonita/server/platform/conf/bonita-platform.properties
cp -v $SUPPORT/platform-tenant-config.properties $BONITA_BASE/bonita/client/platform/conf/platform-tenant-config.properties
```

### Copier le driver JDBC

Dans $BONITA_BASE/lib

### Fichier de licence

Dans $BONITA_BASE/bonita/server/licenses

###  Droits

chown -R $USER.$USER $BONITA_BASE

### Script de démarrage

[Basic example attached](bonita.sh)

### Démarrer l'instance

### Authentification LDAP

#### Créer un fichier jaas.conf dans $BONITA_BASE/conf

[Example](support/jaas-ldap.conf)

Editer $BONITA_BASE/bin/setenv.sh pour ajouter

SECURITY_OPTS="-Djava.security.auth.login.config=$CATALINA_HOME/conf/jaas.conf"

Ajouter ${SECURITY\_OPTS} à CATALINA_OPTS 

#### Injection de dépendance

cp -v $SUPPORT/cfg-bonita-authentication-impl.xml $BONITA_BASE/bonita/server/tenants/1/conf/services/cfg-bonita-authentication-impl.xml




