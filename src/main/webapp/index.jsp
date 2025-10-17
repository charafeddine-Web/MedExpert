<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.medexpert.model.Utilisateur" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>MedExpert - Plateforme Médicale Professionnelle</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInRight {
            from { opacity: 0; transform: translateX(30px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .animate-fadeIn {
            animation: fadeIn 0.6s ease-out forwards;
        }

        .animate-slideInRight {
            animation: slideInRight 0.8s ease-out forwards;
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
        }

        .btn-primary {
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(14, 165, 233, 0.3);
        }

        .gradient-text {
            background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-pattern {
            background-image:
                    linear-gradient(to right, #f0f9ff 1px, transparent 1px),
                    linear-gradient(to bottom, #f0f9ff 1px, transparent 1px);
            background-size: 60px 60px;
        }
    </style>
</head>
<body class="bg-white">
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
%>

<!-- Navigation -->
<nav class="fixed top-0 left-0 right-0 z-50 bg-white/95 backdrop-blur-md border-b border-gray-100">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
            <!-- Logo -->
            <div class="flex items-center space-x-3">
                <div class="w-11 h-11 bg-sky-600 rounded-xl flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                </div>
                <div>
                    <h1 class="text-2xl font-bold text-gray-900">MedExpert</h1>
                    <p class="text-xs text-gray-500 -mt-1">Plateforme médicale</p>
                </div>
            </div>

            <!-- Menu Desktop -->
            <div class="hidden md:flex items-center space-x-8">
                <a href="#features" class="text-gray-600 hover:text-sky-600 font-medium transition">Fonctionnalités</a>
                <a href="#about" class="text-gray-600 hover:text-sky-600 font-medium transition">À propos</a>
                <a href="#contact" class="text-gray-600 hover:text-sky-600 font-medium transition">Contact</a>
            </div>

            <!-- Auth buttons -->
            <div class="flex items-center space-x-4">
                <% if (utilisateur != null) { %>
                <div class="hidden sm:flex items-center space-x-3 px-4 py-2 bg-gray-50 rounded-xl border border-gray-100">
                    <div class="w-8 h-8 bg-sky-600 rounded-full flex items-center justify-center">
                        <span class="text-white text-sm font-bold"><%= utilisateur.getNom().substring(0, 1) %></span>
                    </div>
                    <span class="text-sm font-semibold text-gray-700"><%= utilisateur.getNom() %> <%= utilisateur.getPrenom() %></span>
                </div>
                <form action="logout" method="post" class="inline">
                    <button type="submit" class="px-5 py-2.5 text-gray-600 hover:text-gray-900 font-medium rounded-xl hover:bg-gray-50 transition">
                        Déconnexion
                    </button>
                </form>
                <% } else { %>
                <a href="views/login.jsp" class="px-5 py-2.5 text-gray-600 hover:text-gray-900 font-medium rounded-xl hover:bg-gray-50 transition">
                    Connexion
                </a>
                <a href="views/register.jsp" class="px-6 py-2.5 bg-sky-600 hover:bg-sky-700 text-white font-semibold rounded-xl shadow-sm btn-primary">
                    Inscription
                </a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="pt-32 pb-20 px-4 sm:px-6 lg:px-8 hero-pattern">
    <div class="max-w-7xl mx-auto">
        <div class="grid lg:grid-cols-2 gap-16 items-center">
            <!-- Left Content -->
            <div class="animate-fadeIn">
                <% if (utilisateur != null) { %>
                <div class="inline-flex items-center space-x-2 px-4 py-2 bg-sky-50 rounded-full border border-sky-100 mb-6">
                    <span class="w-2 h-2 bg-sky-600 rounded-full animate-pulse"></span>
                    <span class="text-sky-700 text-sm font-medium">Bienvenue, <%= utilisateur.getNom() %> <%= utilisateur.getPrenom() %></span>
                </div>
                <% } %>

                <h1 class="text-5xl sm:text-6xl lg:text-7xl font-extrabold text-gray-900 leading-tight mb-6">
                    La santé au
                    <span class="block gradient-text">cœur de l'innovation</span>
                </h1>

                <p class="text-xl text-gray-600 leading-relaxed mb-10">
                    MedExpert offre une solution complète et sécurisée pour la gestion de vos dossiers médicaux, consultations et expertises professionnelles.
                </p>

                <div class="flex flex-col sm:flex-row gap-4 mb-12">
                    <% if (utilisateur == null) { %>
                    <a href="views/register.jsp" class="group inline-flex items-center justify-center px-8 py-4 bg-sky-600 hover:bg-sky-700 text-white font-semibold rounded-xl shadow-lg btn-primary">
                        <span>Commencer maintenant</span>
                        <svg class="w-5 h-5 ml-2 group-hover:translate-x-1 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"/>
                        </svg>
                    </a>
                    <a href="#features" class="inline-flex items-center justify-center px-8 py-4 bg-white hover:bg-gray-50 text-gray-700 font-semibold rounded-xl border border-gray-200 transition">
                        En savoir plus
                    </a>
                    <% } else { %>
                    <a href="views/dashboard.jsp" class="group inline-flex items-center justify-center px-8 py-4 bg-sky-600 hover:bg-sky-700 text-white font-semibold rounded-xl shadow-lg btn-primary">
                        <span>Accéder au tableau de bord</span>
                        <svg class="w-5 h-5 ml-2 group-hover:translate-x-1 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"/>
                        </svg>
                    </a>
                    <% } %>
                </div>

                <!-- Stats -->
                <div class="grid grid-cols-3 gap-8">
                    <div>
                        <p class="text-3xl font-bold text-gray-900">12K+</p>
                        <p class="text-sm text-gray-600 mt-1">Patients actifs</p>
                    </div>
                    <div>
                        <p class="text-3xl font-bold text-gray-900">850+</p>
                        <p class="text-sm text-gray-600 mt-1">Professionnels</p>
                    </div>
                    <div>
                        <p class="text-3xl font-bold text-gray-900">99.9%</p>
                        <p class="text-sm text-gray-600 mt-1">Disponibilité</p>
                    </div>
                </div>
            </div>

            <!-- Right Content - Dashboard Preview -->
            <div class="hidden lg:block animate-slideInRight">
                <div class="relative">
                    <!-- Main Card -->
                    <div class="bg-white rounded-2xl shadow-2xl border border-gray-100 p-8">
                        <div class="flex items-center justify-between mb-8">
                            <div>
                                <p class="text-sm text-gray-500 mb-1">Tableau de bord</p>
                                <h3 class="text-2xl font-bold text-gray-900">Activité du jour</h3>
                            </div>
                            <div class="w-12 h-12 bg-sky-50 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                                </svg>
                            </div>
                        </div>

                        <div class="space-y-6">
                            <div class="flex items-center justify-between p-4 bg-gray-50 rounded-xl">
                                <div class="flex items-center space-x-4">
                                    <div class="w-10 h-10 bg-sky-600 rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="text-sm font-semibold text-gray-900">Consultations</p>
                                        <p class="text-xs text-gray-500">Complétées aujourd'hui</p>
                                    </div>
                                </div>
                                <p class="text-2xl font-bold text-gray-900">24</p>
                            </div>

                            <div class="flex items-center justify-between p-4 bg-gray-50 rounded-xl">
                                <div class="flex items-center space-x-4">
                                    <div class="w-10 h-10 bg-gray-700 rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="text-sm font-semibold text-gray-900">En attente</p>
                                        <p class="text-xs text-gray-500">Demandes à traiter</p>
                                    </div>
                                </div>
                                <p class="text-2xl font-bold text-gray-900">7</p>
                            </div>

                            <div class="flex items-center justify-between p-4 bg-gray-50 rounded-xl">
                                <div class="flex items-center space-x-4">
                                    <div class="w-10 h-10 bg-gray-700 rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="text-sm font-semibold text-gray-900">Patients</p>
                                        <p class="text-xs text-gray-500">Nouveaux ce mois</p>
                                    </div>
                                </div>
                                <p class="text-2xl font-bold text-gray-900">142</p>
                            </div>
                        </div>
                    </div>

                    <!-- Floating Badge -->
                    <div class="absolute -top-6 -right-6 bg-sky-600 text-white px-6 py-3 rounded-xl shadow-lg">
                        <p class="text-sm font-semibold">100% Sécurisé</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="py-24 px-4 sm:px-6 lg:px-8 bg-gray-50">
    <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
            <h2 class="text-4xl sm:text-5xl font-extrabold text-gray-900 mb-4">
                Fonctionnalités complètes
            </h2>
            <p class="text-xl text-gray-600 max-w-3xl mx-auto">
                Une plateforme tout-en-un pour gérer efficacement votre pratique médicale
            </p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            <!-- Feature 1 -->
            <div class="card-hover bg-white rounded-2xl p-8 border border-gray-100">
                <div class="w-14 h-14 bg-sky-50 rounded-xl flex items-center justify-center mb-6">
                    <svg class="w-7 h-7 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-3">Dossiers médicaux</h3>
                <p class="text-gray-600 leading-relaxed">Gestion centralisée et sécurisée de tous vos dossiers patients avec accès instantané.</p>
            </div>

            <!-- Feature 2 -->
            <div class="card-hover bg-white rounded-2xl p-8 border border-gray-100">
                <div class="w-14 h-14 bg-sky-50 rounded-xl flex items-center justify-center mb-6">
                    <svg class="w-7 h-7 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-3">Gestion des rendez-vous</h3>
                <p class="text-gray-600 leading-relaxed">Calendrier intelligent avec rappels automatiques pour une organisation optimale.</p>
            </div>

            <!-- Feature 3 -->
            <div class="card-hover bg-white rounded-2xl p-8 border border-gray-100">
                <div class="w-14 h-14 bg-sky-50 rounded-xl flex items-center justify-center mb-6">
                    <svg class="w-7 h-7 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-3">Collaboration médicale</h3>
                <p class="text-gray-600 leading-relaxed">Travaillez en équipe et partagez des informations en toute sécurité.</p>
            </div>

            <!-- Feature 4 -->
            <div class="card-hover bg-white rounded-2xl p-8 border border-gray-100">
                <div class="w-14 h-14 bg-sky-50 rounded-xl flex items-center justify-center mb-6">
                    <svg class="w-7 h-7 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-3">Analyses détaillées</h3>
                <p class="text-gray-600 leading-relaxed">Tableaux de bord intuitifs et rapports complets pour suivre votre activité.</p>
            </div>

            <!-- Feature 5 -->
            <div class="card-hover bg-white rounded-2xl p-8 border border-gray-100">
                <div class="w-14 h-14 bg-sky-50 rounded-xl flex items-center justify-center mb-6">
                    <svg class="w-7 h-7 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-3">Sécurité maximale</h3>
                <p class="text-gray-600 leading-relaxed">Cryptage de niveau bancaire et conformité totale aux normes RGPD.</p>
            </div>

            <!-- Feature 6 -->
            <div class="card-hover bg-white rounded-2xl p-8 border border-gray-100">
                <div class="w-14 h-14 bg-sky-50 rounded-xl flex items-center justify-center mb-6">
                    <svg class="w-7 h-7 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-3">Accès mobile</h3>
                <p class="text-gray-600 leading-relaxed">Consultez vos données partout, à tout moment depuis tous vos appareils.</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="py-24 px-4 sm:px-6 lg:px-8">
    <div class="max-w-4xl mx-auto text-center">
        <h2 class="text-4xl sm:text-5xl font-extrabold text-gray-900 mb-6">
            Prêt à commencer ?
        </h2>
        <p class="text-xl text-gray-600 mb-10 max-w-2xl mx-auto">
            Rejoignez des milliers de professionnels qui font confiance à MedExpert pour leur pratique quotidienne.
        </p>
        <% if (utilisateur == null) { %>
        <a href="views/register.jsp" class="inline-flex items-center space-x-2 px-10 py-5 bg-sky-600 hover:bg-sky-700 text-white font-semibold rounded-xl shadow-lg btn-primary text-lg">
            <span>Créer un compte gratuit</span>
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"/>
            </svg>
        </a>
        <% } else { %>
        <a href="views/dashboard.jsp" class="inline-flex items-center space-x-2 px-10 py-5 bg-sky-600 hover:bg-sky-700 text-white font-semibold rounded-xl shadow-lg btn-primary text-lg">
            <span>Accéder à mon espace</span>
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"/>
            </svg>
        </a>
        <% } %>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-50 border-t border-gray-100 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-7xl mx-auto">
        <div class="grid md:grid-cols-4 gap-8 mb-12">
            <div>
                <div class="flex items-center space-x-2 mb-4">
                    <div class="w-10 h-10 bg-sky-600 rounded-xl flex items-center justify-center">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <span class="text-xl font-bold text-gray-900">MedExpert</span>
                </div>
                <p class="text-gray-600 text-sm leading-relaxed">La plateforme médicale professionnelle de référence.</p>
            </div>

            <div>
                <h4 class="font-bold text-gray-900 mb-4">Produit</h4>
                <ul class="space-y-3 text-sm">
                    <li><a href="#features" class="text-gray-600 hover:text-sky-600 transition">Fonctionnalités</a></li>
                    <li><a href="#" class="text-gray-600 hover:text-sky-600 transition">Tarifs</a></li>
                    <li><a href="#" class="text-gray-600 hover:text-sky-600 transition">Documentation</a></li>
                </ul>
            </div>

            <div>
                <h4 class="font-bold text-gray-900 mb-4">Entreprise</h4>
                <ul class="space-y-3 text-sm">
                    <li><a href="#about" class="text-gray-600 hover:text-sky-600 transition">À propos</a></li>
                    <li><a href="#" class="text-gray-600 hover:text-sky-600 transition">Blog</a></li>
                    <li><a href="#contact" class="text-gray-600 hover:text-sky-600 transition">Contact</a></li>
                </ul>
            </div>

            <div>
                <h4 class="font-bold text-gray-900 mb-4">Légal</h4>
                <ul class="space-y-3 text-sm">
                    <li><a href="#" class="text-gray-600 hover:text-sky-600 transition">Confidentialité</a></li>
                    <li><a href="#" class="text-gray-600 hover:text-sky-600 transition">Conditions d'utilisation</a></li>
                    <li><a href="#" class="text-gray-600 hover:text-sky-600 transition">Mentions légales</a></li>
                </ul>
            </div>
        </div>

        <div class="border-t border-gray-200 pt-8 flex flex-col md:flex-row items-center justify-between">
            <p class="text-gray-600 text-sm">© <%= java.time.Year.now() %> MedExpert. Tous droits réservés.</p>
            <div class="flex space-x-6 mt-4 md:mt-0">
                <a href="#" class="text-gray-400 hover:text-sky-600 transition">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                    </svg>
                </a>
                <a href="#" class="text-gray-400 hover:text-sky-600 transition">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                    </svg>
                </a>
                <a href="#" class="text-gray-400 hover:text-sky-600 transition">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                    </svg>
                </a>
                <a href="#" class="text-gray-400 hover:text-sky-600 transition">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 0C5.374 0 0 5.373 0 12c0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23A11.509 11.509 0 0112 5.803c1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576C20.566 21.797 24 17.3 24 12c0-6.627-5.373-12-12-12z"/>
                    </svg>
                </a>
            </div>
        </div>
    </div>
</footer>

<script>
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    let lastScroll = 0;
    const navbar = document.querySelector('nav');

    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;

        if (currentScroll > 100) {
            navbar.classList.add('shadow-lg');
        } else {
            navbar.classList.remove('shadow-lg');
        }

        lastScroll = currentScroll;
    });
</script>
</body>
</html>