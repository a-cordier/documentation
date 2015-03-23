# Migration Nuxeo5.8 -> Nuxeo6.0

## Stopper et sauvegarder la 5.8

 - nuxeo.data.dir
 - dump de la base de données

### Télécharger nuxeo-cap-6.0-tomcat.zip

 - extraire l'archive dans /home/nuxeo

### Sauvegarder le fichier nuxeo.conf
 
 - mv /etc/nuxeo/nuxeo.conf{,.bak}
 - cp /home/nuxeo/nuxeo-cap-5.8-tomcat/bin/nuxeo.conf /etc/nuxeo/nuxeo.conf

### Changer le lien symbolique

 - rm /home/nuxeo/nuxeo
 - ln -s /home/nuxeo/nuxeo-cap-5.8-tomcat /home/nuxeo/nuxeo
 
### Vérifier la version de java

 - java7 minimum

### mv /var/lib/nuxeo{,58}

### mkdir /var/lib/nuxeo

### Démarrer l'instance

 - service nuxeo start

### Configurer l'instance en mode "UI"

 - les informations utiles sont dans /etc/nuxeo/nuxeo.conf.bak (informations de connexion à la bdd)
 - configuration ldap
   - 

### Stopper l'instance

### importer le contenu du template custom dans /home/nuxeo/nuxeo/templates/custom

 - répertoire joint 
 - les mots de passe supprimés des fichiers suivants sont à récupérer dans les fichiers de conf. de la 56
   - /home/nuxeo/nuxeo/templates/custom/default-ldap-users-directory-bundle.xml
   - /home/nuxeo/nuxeo/templates/custom/default-virtual-groups-bundle.xml

### cp -r /var/lib/nuxeo56/binaries /var/lib/nuxeo

### activer le template custom dans /etc/nuxeo/nuxeo.conf

 - nuxeo.templates=postgresql,custom

### installer le bundle studio

 - télécharger le bundle sur connect.nuxeo.com
 - copier le bundle dans /home/nuxeo/nuxeo/nxserver/bundles

### démarrer l'instance 

### Installation de packages

 - les hotfixes ...
 - le package cas-authenticator du market place

### copier le contenu du template cas2 dans /home/nuxeo/nuxeo/templates/
 
 - répertoire joint

### installer nuxeo-web-mobile-dm*.jar

 

