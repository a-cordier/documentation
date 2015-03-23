# $CATALINA_HOME/conf/server.xml

### désactivation du connecteur http

Commenter le fragment de configuration du connecteur HTTP

### AJP en local

Ajouter l'attribut address="127.0.0.1" dans le fragment de configuration du connecteur AJP

### Sécurisation du port de shutdown

Modifier la commande de shutdown et le port de shutdown par défaut dans le fragment de configuration correspondant

### Masquage de la version

- cd $CATALINA_HOME/server/lib
  - jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
  - Retirer $version de la ligne server.info=Apache Tomcat $version
  - jar uf catalina.jar org/apache/catalina/util/ServerInfo.properties

### Frontend APACHE

Voir le fichier 000-default joint

