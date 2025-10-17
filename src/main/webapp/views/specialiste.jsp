<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.medexpert.model.DemandeExpertise" %>
<%@ page import="org.example.medexpert.model.Utilisateur" %>
<%@ page import="org.example.medexpert.model.Patient" %>
<%@ page import="org.example.medexpert.model.Specialiste" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Spécialiste - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        .gradient-bg-specialist {
            background: linear-gradient(135deg, #0ea5e9 0%, #6366f1 100%);
        }

        .gradient-bg-accent {
            background: linear-gradient(135deg, #f59e0b 0%, #ef4444 100%);
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        .input-modern {
            transition: all 0.3s ease;
        }

        .input-modern:focus {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(14, 165, 233, 0.2);
        }

        .nav-item {
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: white;
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }

        .nav-item:hover::before {
            transform: scaleY(1);
        }

        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .slide-in {
            animation: slideIn 0.4s ease-out;
        }

        @keyframes slideIn {
            from { transform: translateX(-100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .table-row-hover {
            transition: all 0.2s ease;
        }

        .table-row-hover:hover {
            background: linear-gradient(90deg, rgba(14, 165, 233, 0.05) 0%, rgba(99, 102, 241, 0.05) 100%);
            transform: scale(1.01);
        }

        .badge {
            display: inline-flex;
            align-items: center;
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            transition: all 0.2s;
        }

        .badge-warning {
            background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
            color: white;
        }

        .badge-success {
            background: linear-gradient(135deg, #34d399 0%, #10b981 100%);
            color: white;
        }

        .badge-info {
            background: linear-gradient(135deg, #0ea5e9 0%, #06b6d4 100%);
            color: white;
        }

        .stats-card {
            background: linear-gradient(135deg, rgba(14, 165, 233, 0.1) 0%, rgba(99, 102, 241, 0.1) 100%);
            border-radius: 1rem;
            padding: 1.5rem;
            transition: all 0.3s;
        }

        .stats-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .filter-btn {
            padding: 0.5rem 1.25rem;
            border-radius: 0.75rem;
            font-weight: 600;
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .filter-btn.active {
            background: linear-gradient(135deg, #0ea5e9 0%, #6366f1 100%);
            color: white;
            border-color: transparent;
        }

        .filter-btn:not(.active) {
            background: white;
            color: #64748b;
            border-color: #e2e8f0;
        }

        .filter-btn:not(.active):hover {
            border-color: #0ea5e9;
            color: #0ea5e9;
        }

        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 100;
            display: none;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            max-width: 60rem;
            max-height: 90vh;
            overflow-y: auto;
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .section {
            display: none;
        }

        .section.active {
            display: block;
        }

        /* FullCalendar custom theme overrides */
         #calendar {
             min-height: 800px;
             width: 100%;
         }
        .fc-theme-standard .fc-scrollgrid,
        .fc .fc-daygrid-body,
        .fc .fc-timegrid-body {
            border-radius: 0.75rem; /* rounded-xl */
            border-color: #e5e7eb; /* gray-200 */
        }
        .fc .fc-toolbar.fc-header-toolbar {
            margin-bottom: 0.75rem;
        }
        .fc .fc-toolbar-title {
            font-weight: 700;
            font-size: 1.125rem; /* text-lg */
            background: linear-gradient(135deg, #0ea5e9 0%, #6366f1 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        .fc .fc-button {
            border: none;
            background: linear-gradient(135deg, #0ea5e9 0%, #6366f1 100%);
            color: #fff;
            border-radius: 0.5rem;
            padding: 0.4rem 0.75rem;
            box-shadow: 0 4px 10px rgba(14,165,233,0.2);
        }
        .fc .fc-button:hover { opacity: 0.92; }
        .fc .fc-button:disabled { opacity: 0.6; }
        .fc .fc-col-header-cell-cushion {
            font-weight: 600;
            color: #334155; /* slate-700 */
        }
        .fc .fc-timegrid-slot {
            height: 2.25rem; /* tighter rows */
        }
        .fc .fc-timegrid-axis-cushion,
        .fc .fc-timegrid-slot-label-cushion {
            color: #64748b; /* slate-500 */
            font-size: 0.75rem;
        }
        .fc .fc-event {
            border-radius: 0.5rem;
            border: 0;
        }
        .fc .fc-now-indicator {
            border-color: #ef4444; /* red-500 */
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <%
    HttpSession sessionUser = request.getSession(false);

    Utilisateur user = (Utilisateur) (sessionUser != null ? sessionUser.getAttribute("user") : null);
    Specialiste specialiste = (Specialiste) request.getAttribute("specialiste");
    List<DemandeExpertise> expertises = (List<DemandeExpertise>) request.getAttribute("expertises");
    Integer totalExpertises = (Integer) request.getAttribute("totalExpertises");
    Integer expertisesEnAttente = (Integer) request.getAttribute("expertisesEnAttente");
    Integer expertisesEnCours = (Integer) request.getAttribute("expertisesEnCours");
    Integer expertisesTerminees = (Integer) request.getAttribute("expertisesTerminees");
    Double revenusTotal = (Double) request.getAttribute("revenusTotal");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdfTime = new SimpleDateFormat("dd/MM/yyyy à HH:mm");
%>

<div class="flex w-full min-h-screen">
    <!-- Sidebar Navigation -->
    <nav class="fixed inset-y-0 left-0 w-64 bg-white border-r border-slate-200 text-slate-700 flex flex-col z-50 h-screen">
        <div class="p-8">
            <div class="flex items-center space-x-3 mb-8">
                <div class="w-12 h-12 bg-slate-100 rounded-xl flex items-center justify-center">
                    <svg class="w-7 h-7 text-slate-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                    </svg>
                </div>
                <div>
                    <h2 class="text-2xl font-bold tracking-tight text-slate-900">MedExpert</h2>
                    <p class="text-xs text-slate-500">Module Spécialiste</p>
                </div>
            </div>

            <div class="bg-slate-50 rounded-xl p-4">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-slate-200 rounded-full flex items-center justify-center">
                        <svg class="w-5 h-5 text-slate-700" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm font-semibold text-slate-900">Dr. <%= user.getNom() %> <%= user.getPrenom() %></p>
                        <p class="text-xs text-slate-500"><%= specialiste != null ? specialiste.getSpecialite() : "Spécialiste" %></p>
                    </div>
                </div>
            </div>
        </div>

        <ul class="flex-1 px-4 space-y-2">
            <li>
                <button onclick="showSection('dashboard')" class="nav-item w-full text-left px-6 py-3 rounded-lg hover:bg-slate-100 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-slate-100 rounded-lg flex items-center justify-center group-hover:bg-slate-200 transition">
                        <svg class="w-5 h-5 text-slate-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                        </svg>
                    </div>
                    <span class="font-medium text-slate-900">Tableau de bord</span>
                </button>
            </li>
            <li>
                <button onclick="showSection('profil-config')" class="nav-item w-full text-left px-6 py-3 rounded-lg hover:bg-slate-100 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-slate-100 rounded-lg flex items-center justify-center group-hover:bg-slate-200 transition">
                        <svg class="w-5 h-5 text-slate-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                        </svg>
                    </div>
                    <span class="font-medium text-slate-900">Configurer mon profil</span>
                </button>
            </li>
            <li>
                <button onclick="showSection('expertises-list')" class="nav-item w-full text-left px-6 py-3 rounded-lg hover:bg-slate-100 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-slate-100 rounded-lg flex items-center justify-center group-hover:bg-slate-200 transition">
                        <svg class="w-5 h-5 text-slate-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <span class="font-medium text-slate-900">Demandes d'expertise</span>
                </button>
            </li>

        </ul>

        <div class="p-4 space-y-2">
            <form action="<%=request.getContextPath()%>/logout" method="POST" class="w-full">
                <button type="submit" class="nav-item w-full text-left px-6 py-3 rounded-lg hover:bg-slate-100 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-slate-100 rounded-lg flex items-center justify-center group-hover:bg-slate-200 transition">
                        <svg class="w-5 h-5 text-slate-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                        </svg>
                    </div>
                    <span class="font-medium text-slate-900">Déconnexion</span>
                </button>
            </form>
            <p class="text-xs text-slate-400 text-center pt-4">© <%= java.time.Year.now() %> MedExpert</p>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="flex-1 p-4 lg:p-8 overflow-auto lg:ml-64 ml-0">
        <!-- Messages -->
        <div class="max-w-7xl mx-auto mb-6 fade-in">
            <%
                String infoMessage = (String) request.getAttribute("infoMessage");
                String successMessage = (String) request.getAttribute("successMessage");
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (infoMessage != null) {
            %>
            <div id="messageInfo" class="glass-effect border-l-4 border-blue-400 text-blue-800 p-5 rounded-xl shadow-lg mb-4 flex items-start space-x-3">
                <svg class="w-6 h-6 text-blue-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                </svg>
                <span><%= infoMessage %></span>
            </div>
            <% } %>
            <% if (successMessage != null) { %>
            <div id="messageSuccess" class="glass-effect border-l-4 border-green-400 text-green-800 p-5 rounded-xl shadow-lg mb-4 flex items-start space-x-3">
                <svg class="w-6 h-6 text-green-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                </svg>
                <span><%= successMessage %></span>
            </div>
            <% } %>
            <% if (errorMessage != null) { %>
            <div id="messageError" class="glass-effect border-l-4 border-red-400 text-red-800 p-5 rounded-xl shadow-lg mb-4 flex items-start space-x-3">
                <svg class="w-6 h-6 text-red-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                </svg>
                <span><%= errorMessage %></span>
            </div>
            <% } %>
        </div>

        <!-- Dashboard Section -->
        <section id="dashboard" class="section active w-full max-w-7xl mx-auto py-6 fade-in">
            <div class="mb-8">
                <h2 class="text-3xl font-bold text-slate-900 mb-2">
                    Bienvenue, Dr. <%= user.getNom() %>
                </h2>
                <p class="text-gray-600">Voici un aperçu de votre activité</p>
            </div>

            <!-- Statistics Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="stats-card">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600 mb-1">Total expertises</p>
                            <p class="text-3xl font-bold text-sky-600"><%= totalExpertises != null ? totalExpertises : 0 %></p>
                        </div>
                        <div class="w-14 h-14 bg-sky-600 rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600 mb-1">En attente</p>
                            <p class="text-3xl font-bold text-amber-500"><%= expertisesEnAttente != null ? expertisesEnAttente : 0 %></p>
                        </div>
                        <div class="w-14 h-14 bg-sky-600 rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600 mb-1">Terminées</p>
                            <p class="text-3xl font-bold text-emerald-600"><%= expertisesTerminees != null ? expertisesTerminees : 0 %></p>
                        </div>
                        <div class="w-14 h-14 bg-sky-600 rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600 mb-1">Revenus totaux</p>
                            <p class="text-3xl font-bold text-purple-600">
                                <%= revenusTotal != null ? String.format("%.2f", revenusTotal) : "0.00" %> €
                            </p>
                        </div>
                        <div class="w-14 h-14 bg-sky-600 rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="glass-effect rounded-2xl shadow-2xl p-8">
                <h3 class="text-xl font-bold text-gray-800 mb-6">Actions rapides</h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <button onclick="showSection('expertises-list')" class="p-6 bg-white rounded-xl border-2 border-slate-200 hover:border-slate-300 transition group">
                        <div class="w-12 h-12 bg-sky-600 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                        </div>
                        <h4 class="font-bold text-gray-800 mb-2">Voir les expertises</h4>
                        <p class="text-sm text-gray-600">Consultez vos demandes</p>
                    </button>

                    <button onclick="showSection('profil-config')" class="p-6 bg-white rounded-xl border-2 border-slate-200 hover:border-slate-300 transition group">
                        <div class="w-12 h-12 bg-sky-600 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                        </div>
                        <h4 class="font-bold text-gray-800 mb-2">Configurer profil</h4>
                        <p class="text-sm text-gray-600">Mettez à jour vos informations</p>
                    </button>
                </div>
            </div>
        </section>

        <!-- Configuration du Profil -->
        <section id="profil-config" class="section w-full max-w-7xl mx-auto py-6 fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 lg:p-12 card-hover">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-12 h-12 bg-sky-600 rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-3xl font-bold text-slate-900">Configuration du profil</h3>
                        <p class="text-sm text-gray-500 mt-1">Définissez vos tarifs et spécialité médicale</p>
                    </div>
                </div>

                <form action="<%=request.getContextPath()%>/specialiste/profil" method="post" class="space-y-6">
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Spécialité médicale *</label>
                            <select name="specialite" required
                                    class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-sky-500 focus:outline-none">
                                <option value="">-- Sélectionner une spécialité --</option>
                                <option value="CARDIOLOGIE" <%= specialiste != null && "CARDIOLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Cardiologie</option>
                                <option value="DERMATOLOGIE" <%= specialiste != null && "DERMATOLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Dermatologie</option>
                                <option value="ENDOCRINOLOGIE" <%= specialiste != null && "ENDOCRINOLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Endocrinologie</option>
                                <option value="GASTROENTEROLOGIE" <%= specialiste != null && "GASTROENTEROLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Gastroentérologie</option>
                                <option value="NEUROLOGIE" <%= specialiste != null && "NEUROLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Neurologie</option>
                                <option value="OPHTALMOLOGIE" <%= specialiste != null && "OPHTALMOLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Ophtalmologie</option>
                                <option value="ORL" <%= specialiste != null && "ORL".equals(specialiste.getSpecialite()) ? "selected" : "" %>>ORL</option>
                                <option value="PEDIATRIE" <%= specialiste != null && "PEDIATRIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Pédiatrie</option>
                                <option value="PNEUMOLOGIE" <%= specialiste != null && "PNEUMOLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Pneumologie</option>
                                <option value="PSYCHIATRIE" <%= specialiste != null && "PSYCHIATRIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Psychiatrie</option>
                                <option value="RADIOLOGIE" <%= specialiste != null && "RADIOLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Radiologie</option>
                                <option value="RHUMATOLOGIE" <%= specialiste != null && "RHUMATOLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Rhumatologie</option>
                                <option value="UROLOGIE" <%= specialiste != null && "UROLOGIE".equals(specialiste.getSpecialite()) ? "selected" : "" %>>Urologie</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Tarif </label>
                            <input type="number" step="0.01" min="0" name="tarif" value="<%= specialiste != null && specialiste.getTarif() != null ? specialiste.getTarif() : "" %>"
                                   class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-sky-500 focus:outline-none" placeholder="Ex: 75.00" />
                        </div>
                        </div>

                     <div class="grid grid-cols-1 lg:grid-cols-1 gap-6">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Mes créneaux (Calendrier)</label>
                            <div class="space-y-3">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-2">
                                        <span class="text-xs text-gray-500">Sélection: 30 min, lun → ven (dim & sam caché)</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <button id="save-slots" type="button" class="px-4 py-2 rounded-lg bg-sky-600 hover:bg-sky-700 text-white text-sm font-semibold">Enregistrer</button>
                                        <button id="clear-slots" type="button" class="px-4 py-2 rounded-lg border-2 border-gray-300 text-gray-700 text-sm font-semibold hover:bg-gray-50">Vider</button>
                                    </div>
                                </div>
                                 <div id="calendar" class="glass-effect rounded-2xl p-4 border-2 border-gray-100 shadow-sm w-full" style="height: 800px; min-width: 100%;"></div>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-end space-x-4 mt-8">
                        <button type="button" onclick="showSection('dashboard')"
                                class="px-8 py-4 rounded-xl border-2 border-gray-300 text-gray-700 font-bold hover:bg-gray-50 transition">
                            Annuler
                        </button>
                        <button type="submit" onclick="showSection('dashboard')"
                                class="px-8 py-4 rounded-xl border-2 border-gray-300 text-gray-700 font-bold hover:bg-gray-50 transition">
                            Confirmer
                        </button>
                    </div>
                </form>
            </div>
        </section>

        <!-- Demandes d'Expertise -->
        <section id="expertises-list" class="section w-full max-w-7xl mx-auto py-6 fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl overflow-hidden">
                <div class="p-8 bg-white">
                    <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                        <div class="flex items-center space-x-3">
                            <div class="w-12 h-12 bg-sky-600 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-3xl font-bold text-slate-900">
                                    Demandes d'expertise
                                </h3>
                                <p class="text-sm text-gray-500 mt-1">Gérez vos dossiers médicaux</p>
                            </div>
                        </div>

                        <div class="flex flex-wrap gap-3">
                            <button onclick="filterExpertises('TOUS')" data-filter="TOUS" class="filter-btn active">
                                <svg class="w-4 h-4 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                                </svg>
                                Tous
                            </button>
                            <button onclick="filterExpertises('EN_ATTENTE')" data-filter="EN_ATTENTE" class="filter-btn">
                                <svg class="w-4 h-4 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                En attente
                            </button>
                            <button onclick="filterExpertises('EN_COURS')" data-filter="EN_COURS" class="filter-btn">
                                <svg class="w-4 h-4 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                                </svg>
                                En cours
                            </button>
                            <button onclick="filterExpertises('TERMINEE')" data-filter="TERMINEE" class="filter-btn">
                                <svg class="w-4 h-4 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                Terminées
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Table -->
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="bg-gray-50 border-b-2 border-gray-200">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Patient</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Date demande</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Médecin</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Statut</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Priorité</th>
                            <th class="px-6 py-4 text-center text-xs font-bold text-gray-700 uppercase tracking-wider">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            if (expertises != null) {
                                for (DemandeExpertise de : expertises) {
                                    String patientNom = "N/A";
                                    String medecinNom = "N/A";
                                    try {
                                        if (de.getConsultation() != null && de.getConsultation().getDossier() != null && de.getConsultation().getDossier().getPatient() != null) {
                                            patientNom = de.getConsultation().getDossier().getPatient().getNom() + " " + de.getConsultation().getDossier().getPatient().getPrenom();
                                        }
                                    } catch (Exception ignored) {}
                                    try {
                                        if (de.getConsultation() != null && de.getConsultation().getGeneraliste() != null) {
                                            medecinNom = de.getConsultation().getGeneraliste().getNom() + " " + de.getConsultation().getGeneraliste().getPrenom();
                                        }
                                    } catch (Exception ignored) {}
                        %>
                        <tr class="table-row-hover expertise-row" data-statut="<%= de.getStatus() != null ? de.getStatus().name() : "" %>">
                            <td class="px-6 py-4 text-sm text-gray-700">#<%= de.getId() %></td>
                            <td class="px-6 py-4 text-sm text-gray-700"><%= patientNom %></td>
                            <td class="px-6 py-4 text-sm text-gray-700"><%= de.getDateDemande() != null ? sdfTime.format(java.sql.Timestamp.valueOf(de.getDateDemande())) : "" %></td>
                            <td class="px-6 py-4 text-sm text-gray-700"><%= medecinNom %></td>
                            <td class="px-6 py-4 text-sm">
                                <span class="badge <%= de.getStatus() == null ? "" : (de.getStatus().name().equals("EN_ATTENTE") ? "badge-warning" : (de.getStatus().name().equals("EN_COURS") ? "badge-info" : "badge-success")) %>">
                                    <%= de.getStatus() != null ? de.getStatus().name() : "" %>
                                </span>
                            </td>
                            <td class="px-6 py-4 text-sm text-gray-700"><%= de.getPriorite() != null ? de.getPriorite() : "" %></td>
                            <td class="px-6 py-4 text-sm text-center">
                                <% boolean avisExistant = (de.getAvis() != null && !de.getAvis().isBlank()); %>
                                <% if (!avisExistant) { %>
                                <button onclick="openAvisForm('<%= de.getId() %>', '<%= patientNom %>')" class="px-4 py-2 rounded-lg text-white bg-sky-600 hover:bg-sky-700">
                                    Donner un avis
                                </button>
                                <% } else { %>
                                <button onclick="openDetailModal('<%= de.getId() %>')" class="px-4 py-2 rounded-lg border-2 border-gray-300 text-gray-700 hover:bg-gray-50">
                                    Voir détails
                                </button>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>

                </div>
                
                <!-- Modals de détails pour chaque expertise (lecture seule) -->
                <% if (expertises != null) { for (DemandeExpertise de : expertises) { %>
                <div id="modal-detail-<%= de.getId() %>" class="modal-overlay">
                    <div class="modal-content glass-effect rounded-2xl shadow-2xl p-8 m-4 w-full">
                        <div class="flex items-center space-x-3 mb-8">
                            <div class="w-12 h-12 bg-sky-600 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v11a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-2xl font-bold text-slate-900">
                                    Détails de l'expertise #<%= de.getId() %>
                                </h3>
                                <p class="text-sm text-gray-500 mt-1">Statut: <span class="font-semibold"><%= de.getStatus() != null ? de.getStatus().name() : "" %></span></p>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <p class="text-sm text-gray-600"><span class="font-semibold">Patient:</span>
                                    <%
                                        String pNom = "N/A";
                                        try {
                                            if (de.getConsultation() != null && de.getConsultation().getDossier() != null && de.getConsultation().getDossier().getPatient() != null) {
                                                pNom = de.getConsultation().getDossier().getPatient().getNom() + " " + de.getConsultation().getDossier().getPatient().getPrenom();
                                            }
                                        } catch (Exception ignored) {}
                                    %>
                                    <span><%= pNom %></span>
                                </p>
                                <p class="text-sm text-gray-600"><span class="font-semibold">Généraliste:</span>
                                    <%
                                        String gNom = "N/A";
                                        try {
                                            if (de.getConsultation() != null && de.getConsultation().getGeneraliste() != null) {
                                                gNom = de.getConsultation().getGeneraliste().getNom() + " " + de.getConsultation().getGeneraliste().getPrenom();
                                            }
                                        } catch (Exception ignored) {}
                                    %>
                                    <span><%= gNom %></span>
                                </p>
                                <p class="text-sm text-gray-600"><span class="font-semibold">Date de demande:</span>
                                    <span><%= de.getDateDemande() != null ? sdfTime.format(java.sql.Timestamp.valueOf(de.getDateDemande())) : "" %></span>
                                </p>
                                <p class="text-sm text-gray-600"><span class="font-semibold">Priorité:</span> <span><%= de.getPriorite() != null ? de.getPriorite() : "" %></span></p>
                            </div>
                            <div class="space-y-2">
                                <p class="text-sm text-gray-600"><span class="font-semibold">Question:</span> <span><%= de.getQuestion() != null ? de.getQuestion() : "" %></span></p>
                                <p class="text-sm text-gray-600"><span class="font-semibold">Observations consultation:</span>
                                    <span><%= (de.getConsultation() != null && de.getConsultation().getObservations() != null) ? de.getConsultation().getObservations() : "" %></span>
                                </p>
                                <p class="text-sm text-gray-600"><span class="font-semibold">Avis du spécialiste:</span>
                                    <span><%= de.getAvis() != null ? de.getAvis() : "—" %></span>
                                </p>
                            </div>
                        </div>

                        <div class="flex justify-end space-x-4 mt-8">
                            <button type="button" onclick="closeModal('modal-detail-<%= de.getId() %>')"
                                    class="px-8 py-4 rounded-xl border-2 border-gray-300 text-gray-700 font-bold hover:bg-gray-50 transition">
                                Fermer
                            </button>
                        </div>
                    </div>
                </div>
                <% } } %>
            </div>

            <!-- Modal pour formulaire d'avis -->
            <div id="modal-avis" class="modal-overlay">
                <div class="modal-content glass-effect rounded-2xl shadow-2xl p-8 m-4 w-full">
                    <div class="flex items-center space-x-3 mb-8">
                        <div class="w-12 h-12 bg-sky-600 rounded-xl flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-2xl font-bold text-slate-900">
                                Rédiger un avis médical
                            </h3>
                            <p class="text-sm text-gray-500 mt-1">Patient: <span id="patientInfoAvis" class="font-semibold text-gray-700"></span></p>
                        </div>
                    </div>

                    <form action="<%=request.getContextPath()%>/specialiste/avis" method="post" class="space-y-6">
                        <input type="hidden" name="expertiseId" id="expertiseIdAvis" />

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Avis médical détaillé *</label>
                            <textarea name="avis" rows="12" required
                                      class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-4 focus:border-amber-500 focus:outline-none"
                                      placeholder="Rédigez votre avis médical détaillé...&#10;&#10;- Diagnostic&#10;- Analyse des documents&#10;- Recommandations&#10;- Traitement proposé&#10;- Suivi nécessaire"></textarea>
                        </div>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">Nouveau statut *</label>
                                <select name="statut" required
                                        class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-amber-500 focus:outline-none">
                                    <option value="EN_COURS">En cours</option>
                                    <option value="TERMINEE">Terminée</option>
                                </select>
                            </div>


                        </div>

                        <div class="flex justify-end space-x-4 mt-8">
                            <button type="button" onclick="closeModal('modal-avis')"
                                    class="px-8 py-4 rounded-xl border-2 border-gray-300 text-gray-700 font-bold hover:bg-gray-50 transition">
                                Annuler
                            </button>
                            <button type="submit"
                                    class="bg-sky-600 hover:bg-sky-700 text-white font-bold py-4 px-10 rounded-xl shadow-lg transition transform hover:scale-105 flex items-center space-x-2">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <span>Soumettre l'avis</span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        
    </main>
</div>

    <script type="application/json" id="creneaux-data">
    [
    <% if (specialiste != null && specialiste.getCreneaux() != null) { 
         java.util.Iterator<org.example.medexpert.model.Creneau> it = specialiste.getCreneaux().iterator();
         while (it.hasNext()) { org.example.medexpert.model.Creneau c = it.next(); %>
        {"title":"Créneau","start":"<%= c.getDateDebut() != null ? c.getDateDebut().toString() : "" %>","end":"<%= c.getDateFin() != null ? c.getDateFin().toString() : "" %>","color":"<%= Boolean.TRUE.equals(c.getDisponible()) ? "#10b981" : "#ef4444" %>"}<%= it.hasNext() ? "," : "" %>
    <% } } %>
    ]
    </script>

    <script>
        function showSection(sectionId) {
            const sections = document.querySelectorAll('.section');
            sections.forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(sectionId).classList.add('active');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function filterExpertises(statut) {
            const rows = document.querySelectorAll('.expertise-row');
            const buttons = document.querySelectorAll('.filter-btn');

            buttons.forEach(btn => {
                btn.classList.remove('active');
                if (btn.dataset.filter === statut) {
                    btn.classList.add('active');
                }
            });

            rows.forEach(row => {
                if (statut === 'TOUS' || row.dataset.statut === statut) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function openDetailModal(expertiseId) {
            document.getElementById('modal-detail-' + expertiseId).classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
            document.body.style.overflow = 'auto';
        }

        function openAvisForm(expertiseId, patientNom) {
            document.getElementById('expertiseIdAvis').value = expertiseId;
            document.getElementById('patientInfoAvis').textContent = patientNom;
            document.getElementById('modal-avis').classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        setTimeout(() => {
            const messages = document.querySelectorAll('[id^="message"]');
            messages.forEach(msg => {
                if (msg) {
                    msg.style.transition = 'opacity 0.5s ease';
                    msg.style.opacity = '0';
                    setTimeout(() => msg.style.display = 'none', 500);
                }
            });
        }, 5000);

        document.addEventListener('click', function(event) {
            if (event.target.classList.contains('modal-overlay')) {
                closeModal(event.target.id);
            }
        });

        // FullCalendar integration for specialist creneaux

        document.addEventListener('DOMContentLoaded', function() {
            const calendarEl = document.getElementById('calendar');
            if (!calendarEl) return;

            const jsonTag = document.getElementById('creneaux-data');
            let existingEvents = [];
            if (jsonTag && jsonTag.textContent) {
                try { existingEvents = JSON.parse(jsonTag.textContent); } catch (e) { existingEvents = []; }
            }

            const pendingSlots = [];

            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'timeGridDay',
                initialDate: new Date(),
                locale: 'fr',
                firstDay: 1,
                slotDuration: '00:30:00',
                slotMinTime: '08:00:00',
                slotMaxTime: '19:00:00',
                allDaySlot: false,
                weekends: false,
                expandRows: true,
                contentHeight: 800,
                height: 800,
                businessHours: {
                    daysOfWeek: [1,2,3,4,5,6],
                    startTime: '09:00',
                    endTime: '18:00'
                },
                slotLabelFormat: {
                    hour: '2-digit', minute: '2-digit', hour12: false
                },
                selectable: true,
                selectMirror: true,
                nowIndicator: true,
                unselectAuto: false,
                longPressDelay: 0,
                selectMinDistance: 1,
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'timeGridDay,timeGridWeek'
                },
                events: existingEvents,
                selectAllow: function(info) {
                    const start = info.start; const end = info.end;
                    const day = start.getDay();
                    const isMonToSat = day >= 1 && day <= 6;
                    const diff = (end - start) / (1000 * 60);
                    return isMonToSat && diff === 30;
                },
                select: function(info) {
                    // Toggle selection: if an identical temp slot exists, remove it; else add it
                    const key = info.startStr.substring(0,16) + '|' + info.endStr.substring(0,16);
                    const existingIdx = pendingSlots.findIndex(s => s.key === key);
                    if (existingIdx >= 0) {
                        const removed = pendingSlots.splice(existingIdx, 1)[0];
                        const ev = calendar.getEventById(removed.id);
                        if (ev) ev.remove();
                        return;
                    }
                    const tempId = 'temp-' + Math.random().toString(36).slice(2);
                    pendingSlots.push({ key, start: info.startStr.substring(0,16), end: info.endStr.substring(0,16), id: tempId });
                    calendar.unselect();
                    calendar.addEvent({ id: tempId, title: 'Nouveau', start: info.start, end: info.end, color: '#38bdf8' });
                }
            });
            calendar.render();

            const saveBtn = document.getElementById('save-slots');
            const clearBtn = document.getElementById('clear-slots');

            saveBtn && saveBtn.addEventListener('click', function() {
                if (pendingSlots.length === 0) {
                    alert('Aucun créneau sélectionné.');
                    return;
                }
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%=request.getContextPath()%>/specialiste/creneau';
                pendingSlots.forEach((s, idx) => {
                    const sIn = document.createElement('input'); sIn.type='hidden'; sIn.name='dateDebut'; sIn.value=s.start;
                    const eIn = document.createElement('input'); eIn.type='hidden'; eIn.name='dateFin'; eIn.value=s.end;
                    form.appendChild(sIn); form.appendChild(eIn);
                });
                document.body.appendChild(form);
                form.submit();
            });

            clearBtn && clearBtn.addEventListener('click', function() {
                pendingSlots.forEach(s => {
                    const ev = calendar.getEventById(s.id);
                    if (ev) ev.remove();
                });
                pendingSlots.length = 0;
                calendar.unselect();
            });
        });
</script>

</body>
</html>




