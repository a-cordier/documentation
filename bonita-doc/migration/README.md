# Migration Bonita

### Avant la migration

 - dumper la base de données du serveur à mettre à jour (engine)
 - sauvegarder la ${bonita-home} du bundle à mettre à jour (généralement /home/bonita/bonita/bonita)

### Téléchargement de l'outil de migration et du nouveau bundle sur le portail client

 - https://customer.bonitasoft.com/

 - le répertoire contenant l'outil de migration sera appelé ${bonita-migration}

 - **copier la ${bonita-home} du serveur à mettre à jour vers ${bonita-migration}/bonita**
 - **copier le jar du driver jdbc vers ${bonita-migration}/lib**

### Configuration du script de migration ( ${bonita-migration}/Config.properties )

**bonita.home** ${bonita-migration}/bonita


**postgres db.driverClass** driver jdbc utilisé pour établir la connection à la base de données 

**org.postgresql.Driver db.url** URL de la base de données utilisée par le serveur à mettre à jour (exemple: jdbc:postgresql://bonita-bdd.univ-lille2.fr:5432/bonita_dev)

**db.user** utilisateur de la base de donnée du serveur à mettre à jour

**db.password** mot de passe de cet utilisateur

### Stopper l'instance 

### Lancement du script 

lancer migration.sh depuis le répertoire de téléchargement de l'outil de migration

### Extraire le bundle de la version à jour

 - le répertoire contenant la version à jour sera appelé ${target-bundle}
 - le répertoire contenant la version à mettre à jour sera appelé ${old-bundle}

 - remplacer ${target-bundle}/bonita par ${bonita-migration}/bonita

 - configurer les fichiers présents dans ${target-bundle}  comme pour une nouvelle installation
   - ${target-bundle}/conf/bitronix-resources.properties (JTA)
   - ${target-bundle}/conf/Catalina/localhost/bonita.xml (Datasources)
   - ${target-bundle}/bonita/client/tenants/1/conf/loginManager-config.properties (CAS)
   - ${target-bundle}/bonita/client/platform/conf/platform-tenant-config.properties (TENANT ID)
   - ${target-bundle}/bonita/server/platform/conf/bonita-platform.properties
   - ${target-bundle}/bonita/server/tenants/1/conf/bonita-server.properties 
   - ${target-bundle}/bonita/server/tenants/1/conf/services/cfg-bonita-authentication-impl.xml
   - ${target-bundle}/bin/setenv.sh (DBOPTS et SECURITYOPTS)
   - ${target-bundle}/bin/ul2startup.sh (Coeurs processeur)

   - copier ${old-bundle}/conf/jaas.conf vers ${target-bundle}/conf/jass.conf (CAS)

 - copier le jar du client CAS dans ${target-bundle}/lib (dernière version)
 - copier le jar du driver JDBC dans ${target-bundle}/lib (il est disponible dans le répertoire lib du bundle à mettre à jour)

### Démarrer l'instance

### Stopper l'instance

 - copier ${old-bundle}/webapps/bonita/WEB-INF/lib/ul2-*.jar vers ${target-bundle}/webapps/bonita/WEB-INF/lib 

### Pour la production

 - Appliquer les modifications décrites [ici](https://subversion.univ-lille2.fr/gitlab/78232/bonita-doc/blob/6.4.2/durcissement/README.md)
 - Ajouter la ligne suivante dans  ${target-bundle}/conf/bitronix-config.properties
  - bitronix.tm.timer.defaultTransactionTimeout=160

### Démarrer l'instance

 
