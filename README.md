# 🏥 MedExpert - Système de Télé-Expertise Médicale

## 📋 Description du Projet

MedExpert est un système de télé-expertise médicale développé en Java Web qui optimise le parcours patient en facilitant la coordination entre médecins généralistes et spécialistes. Le système permet une collaboration médicale à distance et assure une prise en charge efficace et rapide des patients.

## 🎯 Objectifs du Projet

- Faciliter la coordination entre médecins généralistes et spécialistes
- Optimiser le parcours patient
- Permettre une prise en charge médicale efficace et rapide
- Favoriser la collaboration médicale à distance

## 🔗 Liens Importants

- **Maquettes Figma** : [Voir les designs](https://www.figma.com/design/Zy8jc8VIS3Q9LqlG08qIk8/MedExpert?node-id=0-1&t=1a1gh2ecCc7uw2Ys-1)
- **Gestion de Projet (JIRA)** : [Accéder au board](https://charafeddinetbibzat.atlassian.net/jira/software/projects/TEM/boards/178/backlog?atlOrigin=eyJpIjoiYWQ5NTQ5NDAwODA5NDRkZDgzYzRkNDZiZGUzZjcxNmMiLCJwIjoiaiJ9)

## ✨ Fonctionnalités

### TICKET-001 : Modules Infirmier + Médecin Généraliste
**Deadline : 10/10/2025**

#### Module Infirmier
- ✅ Enregistrement des patients avec informations complètes et signes vitaux
- ✅ Consultation de la liste des patients du jour
- ✅ Visualisation des statuts des patients en temps réel

#### Module Médecin Généraliste
- ✅ Visualisation des patients en attente de consultation
- ✅ Création de consultations pour les patients
- ✅ Ajout d'actes techniques à une consultation
- ✅ Scénario A : Prise en charge par le généraliste

### TICKET-002 : Module Spécialiste
**Deadline : 17/10/2025**

#### Module Médecin Généraliste (Extension)
- 🔍 Recherche de spécialistes par spécialité et tarif (avec Stream API)
- 📅 Consultation des créneaux disponibles d'un spécialiste
- 📝 Création de demandes de télé-expertise
- 💰 Visualisation détaillée des consultations avec calcul automatique des coûts

#### Module Spécialiste
- ⚙️ Configuration du profil (tarif, spécialité)
- 📋 Consultation de la liste des demandes d'expertise
- 🔎 Filtrage des expertises par statut (EN_ATTENTE, TERMINEE)
- 📄 Visualisation détaillée des demandes avec dossier patient complet
- 💬 Fourniture d'avis d'expert avec recommandations
- 📊 Consultation des statistiques (nombre d'expertises, revenus)

## 🛠️ Technologies Utilisées

- **Backend** : Java, Jakarta EE
- **ORM** : JPA/Hibernate
- **Base de données** : MySQL
- **Architecture** : Architecture en couches (MVC)
- **Tests** : JUnit
- **Gestion de projet** : JIRA
- **Design** : Figma

## 📁 Structure du Projet

```
medexpert/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── com/medexpert/
│   │   │   │   ├── dao/           # Couche d'accès aux données
│   │   │   │   ├── entities/      # Entités JPA/Hibernate
│   │   │   │   ├── services/      # Logique métier
│   │   │   │   ├── controllers/   # Contrôleurs
│   │   │   │   └── utils/         # Classes utilitaires
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       └── views/
│   └── test/
│       └── java/                   # Tests unitaires
├── sql/
│   ├── schema.sql                  # Schéma de la base de données
│   └── data.sql                    # Données d'initialisation
├── docs/
│   └── diagramme-classes.png       # Diagramme UML
├── pom.xml
└── README.md
```

## 🚀 Installation et Configuration

### Prérequis

- JDK 17 
- Maven 3.6+
- Serveur d'applications (Tomcat 9+, WildFly, etc.)
- MySQL 8.0+ 

### Étapes d'installation

1. **Cloner le repository**
```bash
git clone https://github.com/charafeddine-Web/MedExpert
cd MedExpert
```

2. **Configurer la base de données**
```bash
# Créer la base de données
mysql -u root -p < sql/schema.sql

# Initialiser les données
mysql -u root -p < sql/data.sql
```

3. **Configurer persistence.xml**
```xml
<property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/medexpert"/>
<property name="javax.persistence.jdbc.user" value="votre_utilisateur"/>
<property name="javax.persistence.jdbc.password" value="votre_mot_de_passe"/>
```

4. **Compiler le projet**
```bash
mvn clean package
```

5. **Déployer le WAR**
```bash
# Copier le fichier WAR généré dans le dossier de déploiement de votre serveur
cp target/medexpert.war $CATALINA_HOME/webapps/
```

## 🧪 Tests

Exécuter les tests unitaires :
```bash
mvn test
```

## 📊 Diagramme UML

Le diagramme de classes UML complet du projet est disponible dans le dossier `docs/diagramme-classes.png`.

## 📝 Conventions de Code

- **Nommage des classes** : PascalCase (ex: `MedecinGeneraliste`)
- **Nommage des méthodes** : camelCase (ex: `creerConsultation()`)
- **Nommage des variables** : camelCase (ex: `patientId`)
- **Nommage des constantes** : UPPER_SNAKE_CASE (ex: `MAX_PATIENTS`)
- **Architecture** : Respect strict de l'architecture en couches

## 📅 Planning

| Ticket | Description | Deadline |
|--------|-------------|----------|
| TICKET-001 | Modules Infirmier + Médecin Généraliste | 10/10/2025 |
| TICKET-002 | Module Spécialiste | 17/10/2025 |

**Date de lancement** : 06/10/2025  
**Deadline finale** : 17/10/2025


## 📞 Contact

Pour toute question concernant le projet, veuillez contacter l'équipe de développement. charafeddinetbibzat@gmail.com  0651928482

## 📄 Licence

Ce projet est développé dans un cadre pédagogique.

---

**Développé avec charaf eddine tbibzat dans le cadre d'une formation Java Web**